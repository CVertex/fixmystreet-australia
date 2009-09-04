//
//  WhoViewController.h
//  FixMyStreet
//
//  Created by Jake MacMullin on 16/06/09.
//  Copyright 2009 BBC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h> 
#import <AddressBookUI/AddressBookUI.h>

@interface WhoViewController : UITableViewController<ABPeoplePickerNavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate> {
  IBOutlet UILabel *nameLabel;
  IBOutlet UIView *headerView;
}

@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UIView *headerView;

- (IBAction)displayAddressBook;
@end
