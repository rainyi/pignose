//
//  MainViewController.h
//  pignose
//
//  Created by WooGyeong Lee on 12. 8. 3..
//  Copyright (c) 2012년 rainyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface MainViewController : UIViewController <FBFriendPickerDelegate>

//@property (strong, nonatomic) IBOutlet UITextView *selectedFriendsView;
@property (strong, nonatomic) IBOutlet FBProfilePictureView *userProfileImage;
@property (strong, nonatomic) IBOutlet UILabel *userNameLabel;
@property (strong, nonatomic) FBFriendPickerViewController *friendPickerController;
//@property (strong, nonatomic) NSArray* selectedFriends;

- (void)facebookViewControllerDoneWasPressed:(id)sender;
- (void)facebookViewControllerCancelWasPressed:(id)sender;
- (IBAction)logoutButtonWasPressed:(id)sender;
- (IBAction)showFriendsButtonWasPressed:(id)sender;

@end
