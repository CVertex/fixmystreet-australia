//  WhereViewController.h
//  FixMyStreet
//
//  Created by Jake MacMullin on 9/06/09.

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "DraggablePinView.h"
#import "ProblemViewController.h"

@interface WhereViewController : ProblemViewController<CLLocationManagerDelegate, MKMapViewDelegate, MKReverseGeocoderDelegate> {
	IBOutlet MKMapView *mapView;
	IBOutlet DraggablePinView *draggablePin;
	CLLocationManager *locationManager;
	BOOL dragMode;
	UIBarButtonItem *dropPinButton;
	UIBarButtonItem *savePinButton;
}

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark;

@end
