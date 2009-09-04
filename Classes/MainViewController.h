//  MainViewController.h
//  FixMyStreet
//
//  Created by Jake MacMullin on 9/06/09.

#import <UIKit/UIKit.h>
#import "WhereViewController.h"
#import "WhatViewController.h"
#import "WhoViewController.h"

@interface MainViewController : UIViewController {
  
  IBOutlet UIImageView *whereCompleteImageView;
  IBOutlet UIImageView *whatCompleteImageView;  
  IBOutlet UIImageView *whoCompleteImageView;
  IBOutlet UIButton *reportButton;
  
	WhereViewController *whereController;
	WhatViewController *whatController;
	WhoViewController *whoController;
	Problem *problem;
}

@property (nonatomic, retain) Problem *problem;

- (IBAction)displayWhereView:(id)sender;
- (IBAction)displayWhatView:(id)sender;
- (IBAction)displayWhoView:(id)sender;
- (IBAction)submitReport:(id)sender;

@end
