// Problem.h
// FixMyStreet
//
// Created by Jake MacMullin on 9/06/09.


#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

// Represents a 'problem' that the user would like to report.
// Each problem consists of a descripton of the problem itself,
// coordinates indicating where the problem is,
// an optional photograph to illustrate the problem and
// the contact details of the person reporting the problem
// (including their name, email address and phone number)
//
// This class also implements the 'MKAnnotation' interface so that
// problems can appear as 'annotations' on an MKMapView.
@interface Problem : NSObject<MKAnnotation> {
  // The name of the problem
	NSString *name;
  // The location of the problem
	CLLocationCoordinate2D coordinate;
  // A photograph of the problem
  UIImage *photo;
  // The name of the person reporting the problem
  NSString *personName;
  // The email address of the person reporting the problem
  NSString *personEmailAddress;
  // The phone number of the person reporting the problem
  NSString *personPhoneNumber;
  // A 'subtitle' that is not sent to the server, but
  // used when the problem is displayed in a MKMapView
  NSString *subtitle;
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, retain) UIImage *photo;
@property (nonatomic, retain) NSString *personName;
@property (nonatomic, retain) NSString *personEmailAddress;
@property (nonatomic, retain) NSString *personPhoneNumber;
@property (nonatomic, retain) NSString *subtitle;

- (id)initWithName:(NSString *)aName;
- (id)initWithName:(NSString *)aName coordinate:(CLLocationCoordinate2D)aCoordinate;

@end
