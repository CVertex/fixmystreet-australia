//  MainViewController.m
//  FixMyStreet
//
//  Created by Jake MacMullin on 9/06/09.

#import "MainViewController.h"
#import "HTTPMultiPartPost.h"
#import "Constants.h"

@implementation MainViewController

@synthesize problem;

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
	[whatController release];
	[whereController release];
}

- (void)viewDidLoad { // might be called more than once (due to memory management)
	if(self.title==nil) {
		self.title = kApplicationTitle;
	}
}

- (void)viewDidUnload {
}

- (void)viewWillAppear:(BOOL)animated {
 
  if(problem.coordinate.latitude!=0 && problem.coordinate.latitude!=0) {
    [whereCompleteImageView setAlpha:1.0];
  } else {
    [whereCompleteImageView setAlpha:0.3];
  }
  
  if(problem.personName!=nil && problem.personEmailAddress!=nil && problem.personPhoneNumber!=nil) {
    [whoCompleteImageView setAlpha:1.0];
  } else {
    [whoCompleteImageView setAlpha:0.3];
  }
  
  if(problem.name!=nil && problem.name!=kInitialProblemDescription) {
    [whatCompleteImageView setAlpha:1.0];
  } else {
    [whatCompleteImageView setAlpha:0.3];
  }
  
  if(whereCompleteImageView.alpha==1.0 && whatCompleteImageView.alpha==1.0 && whoCompleteImageView.alpha==1.0) {
    [reportButton setEnabled:YES];
    [reportButton setAlpha:1.0];
  } else {
    [reportButton setEnabled:NO];
    [reportButton setAlpha:0.3];    
  }
  
}

- (void)displayWhereView:(id)sender {	
	if(whereController==nil) {
		whereController = [[WhereViewController alloc] initWithProblem:problem];
	}
	[self.navigationController pushViewController:whereController animated:YES];
}

- (void)displayWhatView:(id)sender {	
	if(whatController==nil) {
		whatController = [[WhatViewController alloc] initWithProblem:problem];
	}
	[self.navigationController pushViewController:whatController animated:YES];
}

- (IBAction)displayWhoView:(id)sender {
	if(whoController==nil) {
		whoController = [[WhoViewController alloc] initWithProblem:problem];
	}
	[self.navigationController pushViewController:whoController animated:YES];
}

- (IBAction)submitReport:(id)sender {
  // create a HTTPMultiPartPost to send the details of the problem to the 
  // server.
  HTTPMultiPartPost *multiPartPost = [[HTTPMultiPartPost alloc] initWithURL:[NSURL URLWithString:kHTTPPostURL]];
  [multiPartPost addStringPart:kIphoneServiceIdentifierValue withKey:kServiceKey];
  [multiPartPost addStringPart:[[UIDevice currentDevice] uniqueIdentifier] withKey:kPhoneIDKey];  
  [multiPartPost addStringPart:problem.personName withKey:kNameKey];
  [multiPartPost addStringPart:problem.personEmailAddress withKey:kEmailKey];
  [multiPartPost addStringPart:problem.personPhoneNumber withKey:kPhoneNumberKey];
  [multiPartPost addStringPart:problem.name withKey:kSubjectKey];
  [multiPartPost addStringPart:[NSString stringWithFormat:@"%d", problem.coordinate.latitude] withKey:kLatitudeKey];
  [multiPartPost addStringPart:[NSString stringWithFormat:@"%d", problem.coordinate.longitude] withKey:kLongitudeKey];
  
  NSData *photoData = UIImageJPEGRepresentation(problem.photo, 1.0);
  [multiPartPost addFilePart:photoData withKey:kPhotoKey fileName:@"FromiPhone.jpg" contentType:@"image/jpeg"];
  [multiPartPost send];
}

- (void)dealloc {
	[problem release];
	[whereController release];
	[whatController release];
	[whoController release];
  [super dealloc];
}

@end
