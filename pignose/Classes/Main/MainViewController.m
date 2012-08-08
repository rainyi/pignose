//
//  MainViewController.m
//  pignose
//
//  Created by WooGyeong Lee on 12. 8. 3..
//  Copyright (c) 2012년 rainyi. All rights reserved.
//

#import "MainViewController.h"
#import "SelectedFriendsViewController.h"
#import "MFSideMenu.h"

@interface MainViewController ()

@end

@implementation MainViewController

//@synthesize selectedFriendsView = _friendResultText;
@synthesize friendPickerController = _friendPickerController;
//@synthesize selectedFriends = _selectedFriends;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupSideMenuBarButtonItem];
    
    // FBSample logic
    // if the session is open, then load the data for our view controller
    if (!FBSession.activeSession.isOpen)
    {
        // if the session is closed, then we open it here, and establish a handler for state changes
        [FBSession.activeSession openWithCompletionHandler:^(FBSession *session,
                                                             FBSessionState state,
                                                             NSError *error)
         {
            switch (state)
             {
                case FBSessionStateClosedLoginFailed:
                {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                        message:error.localizedDescription
                                                                       delegate:nil
                                                              cancelButtonTitle:@"OK"
                                                              otherButtonTitles:nil];
                    [alertView show];
                }
                    break;
                default:
                    break;
            }
        }];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    if (FBSession.activeSession.isOpen)
    {
        [self populateUserDetails];
    }
}

- (void)viewDidUnload
{
//    self.selectedFriendsView = nil;
    self.userProfileImage = nil;
    self.userNameLabel = nil;
    self.friendPickerController = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)populateUserDetails
{
    if (FBSession.activeSession.isOpen)
    {
        [[FBRequest requestForMe] startWithCompletionHandler:
         ^(FBRequestConnection *connection,
           NSDictionary<FBGraphUser> *user,
           NSError *error)
         {
             if (!error)
             {
                 self.userNameLabel.text = user.name;
                 self.userProfileImage.profileID = user.id;
             }
         }];
    }
}

- (void)facebookViewControllerDoneWasPressed:(id)sender
{
    NSMutableString *text = [[NSMutableString alloc] init];
    
    // we pick up the users from the selection, and create a string that we use to update the text view
    // at the bottom of the display; note that self.selection is a property inherited from our base class
    for (id<FBGraphUser> user in self.friendPickerController.selection) {
        if ([text length]) {
            [text appendString:@", "];
        }
        [text appendString:user.name];
    }
    
//    [self fillTextBoxAndDismiss:text.length > 0 ? text : @"<None>"];
    NSLog(@"selected text: %@", text);
    [self dismissViewControllerAnimated:YES completion:nil];
    SelectedFriendsViewController *pushViewController = [[SelectedFriendsViewController alloc] initWithNibName:@"SelectedFriendsViewController" bundle:nil];
    pushViewController.title = @"Selected Friends";
    pushViewController.txtSelectedFriends = text;
    [self.navigationController pushViewController:pushViewController animated:YES];
}

- (void)facebookViewControllerCancelWasPressed:(id)sender
{
    [self fillTextBoxAndDismiss:@"<Cancelled>"];
}

- (void)fillTextBoxAndDismiss:(NSString *)text {
//    self.selectedFriendsView.text = text;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)logoutButtonWasPressed:(id)sender
{
    [FBSession.activeSession closeAndClearTokenInformation];
}

- (IBAction)showFriendsButtonWasPressed:(id)sender
{
    if (self.friendPickerController == nil)
    {
        // Create friend picker, and get data loaded into it.
#if 1   // Bar Button Hidden NO
        self.friendPickerController = [[FBFriendPickerViewController alloc] init];
#else   // Bar Buttoh Hidden YES
        self.friendPickerController = [[FBFriendPickerViewController alloc] initWithNibName:nil bundle:nil];
#endif
        self.friendPickerController.title = @"Pick Friends";
        self.friendPickerController.delegate = self;
    }
    
    [self.friendPickerController loadData];
    [self.friendPickerController clearSelection];
//    [self presentModalViewController:self.friendPickerController animated:YES];
    [self presentViewController:self.friendPickerController animated:YES completion:nil];
//    [self.navigationController pushViewController:self.friendPickerController animated:YES];
}

@end
