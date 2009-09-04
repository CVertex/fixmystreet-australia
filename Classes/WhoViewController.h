//  WhoViewController.h
//  FixMyStreet
//
//  Created by Jake MacMullin on 19/06/09.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h> 
#import <AddressBookUI/AddressBookUI.h>
#import "ProblemViewController.h"

@interface WhoViewController : ProblemViewController<ABPeoplePickerNavigationControllerDelegate, UITableViewDataSource> {
 @private
	UIView *myHeaderView;
  UILabel *nameLabel;
	UIView *myFooterView;
  UITableView *tableView;
	
	NSMutableArray *phoneNumberArray;
	NSMutableArray *emailArray;
  
  int selectedPhoneIndex;
  int selectedEmailIndex;
}

@property (nonatomic, retain) IBOutlet UIView *myHeaderView;
@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UIView *myFooterView;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *phoneNumberArray;
@property (nonatomic, retain) NSMutableArray *emailArray;

- (IBAction)selectAddress:(id)sender;

@end