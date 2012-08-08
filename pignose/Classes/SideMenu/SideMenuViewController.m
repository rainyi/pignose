//
//  SideMenuViewController.m
//  pignose
//
//  Created by WooGyeong Lee on 12. 8. 2..
//  Copyright (c) 2012년 rainyi. All rights reserved.
//

#import "SideMenuViewController.h"
#import "LoginViewController.h"
#import "MainViewController.h"
#import "MFSideMenu.h"

@interface SideMenuViewController ()

@end

@implementation SideMenuViewController

//@synthesize friendPickerController = _friendPickerController;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"Section %d", section];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.row == 0)
    {
        cell.textLabel.text = @"User Info.";
    }
//    else if (indexPath.row == 1)
//    {
//        cell.textLabel.text = @"My Friends";
//    }
    
//    cell.textLabel.text = [NSString stringWithFormat:@"Item %d", indexPath.row];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    LoginViewController *demoController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
//    demoController.title = [NSString stringWithFormat:@"Demo Controller #%d-%d", indexPath.section, indexPath.row];

    if (indexPath.row == 0)
    {
        MainViewController *mainViewController = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
        mainViewController.title = @"User Info.";
        NSArray *controllers = [NSArray arrayWithObject:mainViewController];
        [MFSideMenuManager sharedManager].navigationController.viewControllers = controllers;
        [MFSideMenuManager sharedManager].navigationController.menuState = MFSideMenuStateHidden;
    }
//    else if (indexPath.row == 1)
//    {
//        self.friendPickerController = [[FBFriendPickerViewController alloc] initWithNibName:nil bundle:nil];
//        // Set the friend picker delegate
//        self.friendPickerController.delegate = self;
//        self.friendPickerController.title = @"Select friends";
//        [self.friendPickerController loadData];
//        NSArray *controllers = [NSArray arrayWithObject:self.friendPickerController];
//        [MFSideMenuManager sharedManager].navigationController.viewControllers = controllers;
//        [MFSideMenuManager sharedManager].navigationController.menuState = MFSideMenuStateHidden;
//    }
}

@end
