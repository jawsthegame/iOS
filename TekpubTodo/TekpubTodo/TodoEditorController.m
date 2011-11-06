//
//  TodoEditorController.m
//  TekpubTodo
//
//  Created by Thomas Fleischer on 11/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TodoEditorController.h"

@implementation TodoEditorController

@synthesize delegate, defaultText;

-(NSString *)text {
    return [textField text];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark -
#pragma mark Event handlers

-(IBAction)cancel {
    if(delegate != nil)
        [delegate todoEditor:self didFinishWithResult:NO];
}

-(IBAction)save {
    if(delegate != nil)
        [delegate todoEditor:self didFinishWithResult:YES];    
}

#pragma mark -
#pragma mark tableview datasource/delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""] autorelease];
    
    CGRect frame = CGRectInset(cell.contentView.bounds, 25, 10);
    
    textField = [[UITextField alloc] initWithFrame:frame];
    
    if(defaultText != nil)
        textField.text = defaultText;
    
    textField.delegate = self;
    
    [cell addSubview:textField];
    
    [textField release];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    [textField becomeFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)sourceTextField {
    [sourceTextField resignFirstResponder];    
    
    return NO;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Text";
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return @"Please enter a nice description";
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
