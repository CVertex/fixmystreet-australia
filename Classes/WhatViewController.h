//  WhatViewController.h
//  FixMyStreet
//
//  Created by Jake MacMullin on 9/06/09.

#import <UIKit/UIKit.h>
#import "ProblemViewController.h"

@interface WhatViewController : ProblemViewController<UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate> {
    IBOutlet UITextField *problemNameField;
    IBOutlet UITextField *categoryTextField;	
    IBOutlet UIPickerView *categoryPicker;
    IBOutlet UIImageView *imageView;
    IBOutlet UIImageView *fooImageView;	

	UIImagePickerController *picker;
}
- (IBAction)setProblemName:(id)sender;
- (IBAction)displayPhotoPicker:(id)sender;
- (IBAction)setProblemName:(id)sender;
- (IBAction)blah:(id)sender;
- (IBAction)toggleCategoryPicker:(id)sender;

@end
