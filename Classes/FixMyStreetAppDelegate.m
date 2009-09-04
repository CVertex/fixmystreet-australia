// FixMyStreetAppDelegate.m
// FixMyStreet
//
// Created by Jake MacMullin on 9/06/09.

#import "FixMyStreetAppDelegate.h"
#import "MainViewController.h"
#import "Constants.h"

@interface FixMyStreetAppDelegate()

// Loads any saved contact details so the user doesn't need to provide
// them again if s/he doesn't want to.
- (NSDictionary *)loadContactDetails;

// Saves the contact details so they can be used to report future problems
- (void)saveName:(NSString *)name emailAddress:(NSString *)emailAddress phoneNumber:(NSString *)phoneNumber;

@end


@implementation FixMyStreetAppDelegate

@synthesize window;
@synthesize navigationController;
@synthesize mainViewController;

static NSString * const kContactDetailsUserDefaultsKey = @"fixMyStreetContactDetails";
static NSString * const kContactNameKey = @"name";
static NSString * const kContactEmailKey = @"email";
static NSString * const kContactPhoneNumberKey = @"phone";


#pragma mark -
#pragma mark Application lifecycle

// delegate method called when the application has finished launching.
- (void)applicationDidFinishLaunching:(UIApplication *)application {
  
  // Create an instance of the 'problem' class to hold the
  // details of the problem the user wants to report
  problem = [[Problem alloc] initWithName:kInitialProblemDescription];
  
  // load any saved contact details as if someone has already
  // submitted a problem report on this phone, then chances
  // are the same person is submitting this problem.
  NSDictionary *details = [self loadContactDetails];
  [problem setPersonName:[details objectForKey:kContactNameKey]];
  [problem setPersonEmailAddress:[details objectForKey:kContactEmailKey]];
  [problem setPersonPhoneNumber:[details objectForKey:kContactPhoneNumberKey]];  
  
  [mainViewController setProblem:problem];
  
	[window addSubview:[navigationController view]];
  [window makeKeyAndVisible];
}

// delegate method called when the application is about to quit
- (void)applicationWillTerminate:(UIApplication *)application {
  // save the contact details used to report the problem
  // so they can be used next time the application is run.
	[self saveName:problem.personName emailAddress:problem.personEmailAddress phoneNumber:problem.personPhoneNumber];
}

#pragma mark -
#pragma mark Private methods
- (NSDictionary *)loadContactDetails {
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  return [defaults dictionaryForKey:kContactDetailsUserDefaultsKey];
}

- (void)saveName:(NSString *)name emailAddress:(NSString *)emailAddress phoneNumber:(NSString *)phoneNumber {
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  NSMutableDictionary *contactDetailsDictionary = [[NSMutableDictionary alloc] initWithCapacity:3];
  [contactDetailsDictionary setObject:name forKey:kContactNameKey];
  [contactDetailsDictionary setObject:emailAddress forKey:kContactEmailKey];
  [contactDetailsDictionary setObject:phoneNumber forKey:kContactPhoneNumberKey];
  [defaults setObject:contactDetailsDictionary forKey:kContactDetailsUserDefaultsKey];
  [contactDetailsDictionary release];
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
  [problem release];
	[navigationController release];
	[window release];
	[super dealloc];
}


@end

