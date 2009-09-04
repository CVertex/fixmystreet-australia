//  WhatViewController.m
//  FixMyStreet
//
//  Created by Jake MacMullin on 9/06/09.

#import "WhatViewController.h"


@implementation WhatViewController

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	  self.title = @"What?";
	  [categoryPicker setHidden:YES];
}

- (void)viewWillAppear:(BOOL)animated {
	[problemNameField setText:[[problem name] copy]];
}

- (void) setProblemName:(id)sender {
	[problem setName:[[problemNameField text] copy]];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (IBAction)blah:(id)sender {
	
	// display a modal dialog asking the user if they want to take a photo
	// or choose an existing photo
	UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil 
													   delegate:self 
											  cancelButtonTitle:@"Cancel" 
										 destructiveButtonTitle:nil 
											  otherButtonTitles:@"Take photo", @"Choose existing photo", nil];
	[sheet showInView:self.view];	
}


- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
	switch (buttonIndex) {
		case 0:
			// take a photo
			[self displayCamera:self];
			break;
		case 1:
			// choose a photo
			[self displayPhotoLibrary:self];
			break;
	}
}

- (IBAction)toggleCategoryPicker:(id)sender {
    // show the picker if it is hidden
	if(categoryPicker.hidden == YES) {
		categoryPicker.hidden = NO;
		[categoryPicker setFrame:CGRectMake(categoryPicker.frame.origin.x, categoryPicker.frame.origin.y - 200, categoryPicker.frame.size.width, categoryPicker.frame.size.height)];
	} else {
		[categoryPicker setFrame:CGRectMake(categoryPicker.frame.origin.x, categoryPicker.frame.origin.y + 200, categoryPicker.frame.size.width, categoryPicker.frame.size.height)];		
		categoryPicker.hidden = YES;
	}
}

- (void)displayPhotoLibrary:(id)sender {
    picker = [[UIImagePickerController alloc] init];
	
	if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
		picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	}
	
  [picker setDelegate:self]; 
    picker.allowsImageEditing = YES; 
    // Picker is displayed asynchronously. 
	[self presentModalViewController:picker animated:YES]; 
	
}

- (void)displayCamera:(id)sender {
    picker = [[UIImagePickerController alloc] init];
	
	if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
		picker.sourceType = UIImagePickerControllerSourceTypeCamera;
	}
	
    picker.delegate = self; 
    picker.allowsImageEditing = NO; 
    // Picker is displayed asynchronously. 
	[self presentModalViewController:picker animated:YES]; 
	
}


- (void)imagePickerController:(UIImagePickerController *)apicker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
  [fooImageView setImage:image];
  problem.photo = image;
	[[apicker parentViewController] dismissModalViewControllerAnimated:YES];
	[apicker release];
}

- (void)useImage:(UIImage *)image {
	
	[self.view setNeedsDisplay];
}


// UITextField delegate methods
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	// the problem 'title' text field did return
	[problem setName:[textField.text copy]];
	[textField resignFirstResponder];
	return YES;
}



// UIPickerView datasource methods
- (int) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 1;
}

- (int) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(int)component {
	return 8;
}


// UIPickerView delegate methods
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	return @"Poo";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	[categoryTextField setText:[self pickerView:pickerView titleForRow:row forComponent:component]];
	[self toggleCategoryPicker:self];
}

- (void)dealloc {
    [super dealloc];
}


@end
