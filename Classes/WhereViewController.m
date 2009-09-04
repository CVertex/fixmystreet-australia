//  WhereViewController.m
//  FixMyStreet
//
//  Created by Jake MacMullin on 9/06/09.

#import "WhereViewController.h"
#import "DraggablePinView.h"


@implementation WhereViewController

- (void)viewDidLoad {
  [super viewDidLoad];

	self.title = @"Where?";

	dropPinButton = [[UIBarButtonItem alloc] initWithTitle:@"Place pin" 
                                                   style:UIBarButtonItemStylePlain 
                                                  target:self 
                                                  action:@selector(dropPin:)];
  [dropPinButton setEnabled:NO];
	savePinButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave 
                                                                target:self 
                                                                action:@selector(savePinLocation:)];
	[self.navigationItem setRightBarButtonItem:dropPinButton];
	
	locationManager = [[CLLocationManager alloc] init];
	locationManager.delegate = self;
	locationManager.desiredAccuracy = kCLLocationAccuracyBest;
	[locationManager startUpdatingLocation];
	
	dragMode = NO;
	mapView.delegate = self;
}

// Called when the location is updated
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {  

  // the first time, enable to 'dropPin' button
  // and zoom in
  if([dropPinButton isEnabled]==NO) {
    [dropPinButton setEnabled:YES];
    
    MKCoordinateRegion region;
    region.center = newLocation.coordinate;
    region.span = MKCoordinateSpanMake(0.015, 0.015);

    [mapView setRegion:region animated:YES];
    [mapView regionThatFits:region];
  }
  
  if(oldLocation!=nil && newLocation!=nil) {
    // only re-center the map view if the location
    // has changed significantly (otherwise it'll reset
    // the zoom level every few seconds - which could
    // be quite anoying).
    if([newLocation getDistanceFrom:oldLocation] > 20) {

      MKCoordinateRegion region;
      region.center = newLocation.coordinate;
      region.span = MKCoordinateSpanMake(0.015, 0.015);
      
      [mapView setRegion:region animated:YES];
      [mapView regionThatFits:region];
      
    }
  }
  
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];	
}

- (void)viewDidUnload {
}

// drop the pin so that the user can specify where the problem is.
- (void)dropPin:(id)sender {
	
  // keep track of the fact we're now in 'drag mode'
	dragMode = YES;
  
  // change the 'drop pin' button to a 'save' button
	[self.navigationItem setRightBarButtonItem:savePinButton];
	
	// place the 'draggable pin' pin in the center of the map view
	if([problem coordinate].latitude==0 && [problem coordinate].longitude==0) {    
    CGPoint centre = CGPointMake(mapView.frame.origin.x + (mapView.frame.size.width / 2), 
                                 mapView.frame.origin.y + (mapView.frame.size.height / 2));
    
		[draggablePin setFrame:CGRectMake(centre.x - (draggablePin.frame.size.width / 2), 
                                      centre.y - (draggablePin.frame.size.height / 2), 
                                      draggablePin.frame.size.width, 
                                      draggablePin.frame.size.height)];
	} else {
		// hide the problem pin for now
		[mapView removeAnnotation:problem];
	}
	
  // make the 'draggable pin' visible (it is created in the .xib file)
	[draggablePin setHidden:NO];	
}

- (void) savePinLocation:(id)sender {
	
  // translate the 'draggable pin's' location within the view
  // to a lat/long and set this as the problem's location.
	[problem setCoordinate:[mapView convertPoint:
                                      CGPointMake(draggablePin.frame.origin.x + (draggablePin.frame.size.width / 2),
                                      draggablePin.frame.origin.y + (draggablePin.frame.size.height / 2))
                          toCoordinateFromView:self.view]];
  
  // Add the 'problem' as an annotation to the mapView (this is possible as 'problem'
  // implements the 'MKAnnotation' protocol.
	[mapView addAnnotation:problem];
	
	// hide the 'draggable pin' (as we've now created an 'annotation' to mark this location)
	[draggablePin setHidden:YES];
	
	// change the button back
	[self.navigationItem setRightBarButtonItem:dropPinButton];
	dragMode = NO;
  
  [mapView setHidden:YES];
  
  // reverse geo-code the location to get a sub-title to display
  MKReverseGeocoder *gecoder = [[MKReverseGeocoder alloc] initWithCoordinate:problem.coordinate];
  [gecoder setDelegate:self];
  [gecoder start];
  
  [mapView setHidden:NO];
}

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark {
  [problem setSubtitle:[NSString stringWithFormat:@"%@, %@", placemark.thoroughfare, placemark.locality]];
  [geocoder release];
}

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error {
  [geocoder release];
}

- (void)dealloc {
  [dropPinButton release];
  [savePinButton release];
  [locationManager release];
  [super dealloc];
}


@end
