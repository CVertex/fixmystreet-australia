//
//  Constants.h
//  FixMyStreet
//
//  Created by Jake MacMullin on 21/08/09.

#import <Foundation/Foundation.h>

// Contains constants used throughout the application.
// The URL that the multi-part HTTP post should be sent to
extern NSString * const kHTTPPostURL;

// The title of the application (as displayed in the navigation bar)
extern NSString * const kApplicationTitle;

// The initial description of a problem (used as a placeholder until the user has provided a description)
extern NSString * const kInitialProblemDescription;

// The following constants are used as the keys for the multi-part HTTP post
extern NSString * const kServiceKey;
extern NSString * const kPhoneIDKey;
extern NSString * const kNameKey;
extern NSString * const kEmailKey;
extern NSString * const kPhoneNumberKey;
extern NSString * const kSubjectKey;
extern NSString * const kLatitudeKey;
extern NSString * const kLongitudeKey;
extern NSString * const kPhotoKey;

// The value for the 'service' key sent when a HTTP post is submitted from this application
extern NSString * const kIphoneServiceIdentifierValue;


@interface Constants : NSObject {
  
}

@end
