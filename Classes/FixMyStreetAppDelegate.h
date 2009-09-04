// FixMyStreetAppDelegate.h
// FixMyStreet
//
// Created by Jake MacMullin on 9/06/09.

#import<UIKit/UIKit.h>
#import "MainViewController.h"
#import "Problem.h"

// The application delegate for the FixMyStreet iPhone application.
// This class is responsible for application initialisation and for
// saving data to disk as the application is about to quit.
@interface FixMyStreetAppDelegate : NSObject <UIApplicationDelegate> {
  UIWindow *window;
  UINavigationController *navigationController;
  MainViewController *mainViewController;
  Problem *problem;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) IBOutlet MainViewController *mainViewController;

@end

