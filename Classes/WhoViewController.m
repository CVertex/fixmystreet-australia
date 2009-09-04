// WhoViewController.m
// FixMyStreet
//
// Created by Jake MacMullin on 19/06/09.
//

#import "WhoViewController.h"

@implementation WhoViewController

@synthesize myHeaderView, nameLabel, myFooterView, tableView, phoneNumberArray, emailArray;

- (void)viewDidLoad {
	// setup our table data
	self.phoneNumberArray = [[NSMutableArray alloc] init];
	self.emailArray = [[NSMutableArray alloc] init];  
  
  selectedEmailIndex = 0;
  selectedPhoneIndex = 0;
  
  // load the details from last time the application was used
  if(problem.personName!=nil && problem.personEmailAddress!=nil && problem.personPhoneNumber!=nil) {
    self.nameLabel.text = problem.personName;    
    [emailArray addObject:[[NSDictionary alloc] initWithObjectsAndKeys:problem.personEmailAddress, @"value", @"email", @"label", nil]];
    [phoneNumberArray addObject:[[NSDictionary alloc] initWithObjectsAndKeys:problem.personPhoneNumber, @"value", @"phone", @"label", nil]];
  }
	
	// set up the table's header view based on our UIView 'myHeaderView' outlet
	self.myHeaderView.backgroundColor = [UIColor clearColor];
	self.tableView.tableHeaderView = self.myHeaderView;	// note this will override UITableView's 'sectionHeaderHeight' property
	
	// set up the table's footer view based on our UIView 'myFooterView' outlet
	self.myFooterView.backgroundColor = [UIColor clearColor];
	self.tableView.tableFooterView = self.myFooterView;	// note this will override UITableView's 'sectionFooterHeight' property
}

- (void)viewWillDisappear:(BOOL)animated {
  // save the details of the selected person in to the 'problem' report
  if([self.phoneNumberArray count]>=1) {
    problem.personPhoneNumber = [[self.phoneNumberArray objectAtIndex:selectedPhoneIndex] objectForKey:@"value"];
  }

  if([self.emailArray count]>=1) {
    problem.personEmailAddress = [[self.emailArray objectAtIndex:selectedEmailIndex] objectForKey:@"value"];
  }
}

- (void)viewDidUnload {
	self.myHeaderView = nil;
	self.myFooterView = nil;
	self.phoneNumberArray = nil;
}

- (void)dealloc {	
	[myFooterView release];
	[myHeaderView release];
	[phoneNumberArray release];
	
	[super dealloc];
}


#pragma mark -
#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if(section==0) {
    return self.phoneNumberArray.count;
  } else {
    return self.emailArray.count;
  }
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *kCellID = @"cellID";
  static int kLabelTag = 100;
  static int kValueTag = 101;  
	
	UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:kCellID];
  UILabel *label;
  UILabel *value;
  
	if (cell == nil)
	{
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellID] autorelease];
		cell.accessoryType = UITableViewCellAccessoryNone;
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    label = [[[UILabel alloc] initWithFrame:CGRectMake(5.0, 10.0, 50.0, 20.0)] autorelease];
    [label setFont:[UIFont boldSystemFontOfSize:12.0]];
    [label setTextColor:[UIColor colorWithRed:0.322 green:0.404 blue:0.573 alpha:1.0]];
    [label setTextAlignment:UITextAlignmentRight];
    [label setTag:kLabelTag];
    [cell.contentView addSubview:label];
    
    value = [[[UILabel alloc] initWithFrame:CGRectMake(75.0, 10.0, 220.0, 20.0)] autorelease];
    [value setFont:[UIFont boldSystemFontOfSize:14.0]];
    [value setTag:kValueTag];
    [cell.contentView addSubview:value];
        
	} else {
    label = (UILabel *) [cell viewWithTag:kLabelTag];
    value = (UILabel *) [cell viewWithTag:kValueTag];
  }
	
  if(indexPath.section==0) {
    label.text = [[self.phoneNumberArray objectAtIndex:indexPath.row] objectForKey:@"label"];
    value.text = [[self.phoneNumberArray objectAtIndex:indexPath.row] objectForKey:@"value"];
      if(indexPath.row==selectedPhoneIndex) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
      } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
      }
  } else {
    label.text = [[self.emailArray objectAtIndex:indexPath.row] objectForKey:@"label"];
    value.text = [[self.emailArray objectAtIndex:indexPath.row] objectForKey:@"value"];
    if(indexPath.row==selectedEmailIndex) {
      cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
      cell.accessoryType = UITableViewCellAccessoryNone;
    }
  }
  
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate methods
- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  if(indexPath.section==0) {
    selectedPhoneIndex = indexPath.row;
  } else {
    selectedEmailIndex = indexPath.row;
  }
  [self.tableView reloadData];
}

#pragma mark -
#pragma mark ABPeoplePickerNavigationControllerDelegate methods
- (void)peoplePickerNavigationControllerDidCancel: (ABPeoplePickerNavigationController *)peoplePicker { 
  [self dismissModalViewControllerAnimated:YES]; 
} 

- (BOOL)peoplePickerNavigationController: (ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person {
  
  // clear old data
  [self.phoneNumberArray removeAllObjects];
  [self.emailArray removeAllObjects];
  
  NSString *fullName = (NSString *)ABRecordCopyCompositeName(person);
  self.nameLabel.text = fullName;
  problem.personName = fullName;
  [fullName autorelease];
  
  // gets all the phone numbers for the selected person    
  ABMultiValueRef phoneNumbers = ABRecordCopyValue(person, kABPersonPhoneProperty);
  for(int i=0; i<ABMultiValueGetCount(phoneNumbers); i++) {
   
    NSMutableDictionary *phoneNumberDict = [[NSMutableDictionary alloc] init];
    NSString *label = (NSString *)ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(phoneNumbers, i));
    NSString *value = (NSString *)ABMultiValueCopyValueAtIndex(phoneNumbers, i);
    [phoneNumberDict setObject:label forKey:@"label"];
    [phoneNumberDict setObject:value forKey:@"value"];
    [phoneNumberArray addObject:phoneNumberDict];
    [phoneNumberDict release];
    
  }

  // gets all the phone numbers for the selected person    
  ABMultiValueRef emailAddresses = ABRecordCopyValue(person, kABPersonEmailProperty);
  for(int i=0; i<ABMultiValueGetCount(emailAddresses); i++) {
    
    NSMutableDictionary *emailDict = [[NSMutableDictionary alloc] init];
    NSString *label = (NSString *)ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(emailAddresses, i));
    NSString *value = (NSString *)ABMultiValueCopyValueAtIndex(emailAddresses, i);
    [emailDict setObject:label forKey:@"label"];
    [emailDict setObject:value forKey:@"value"];
    [emailArray addObject:emailDict];
    [emailDict release];
    
  }
  
  [tableView reloadData];
  
  [self dismissModalViewControllerAnimated:YES]; 
  return NO; 
}

- (BOOL)peoplePickerNavigationController: (ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier{ 
  return NO; 
}

#pragma mark -
#pragma mark Action methods

- (IBAction)selectAddress:(id)sender
{
  ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init]; 
  picker.peoplePickerDelegate = self; 
  [self presentModalViewController:picker animated:YES]; 
  [picker release];
}


@end

