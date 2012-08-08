//
//  SelectedFriendsViewController.m
//  pignose
//
//  Created by WooGyeong Lee on 12. 8. 6..
//  Copyright (c) 2012년 rainyi. All rights reserved.
//

#import "SelectedFriendsViewController.h"

@interface SelectedFriendsViewController ()

@end

@implementation SelectedFriendsViewController

@synthesize selectedFriendsTextView = _friendResultText;
@synthesize txtSelectedFriends;

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
    self.selectedFriendsTextView.text = txtSelectedFriends;
    NSLog(@"text: %@", self.selectedFriendsTextView.text);
}

- (void)viewDidUnload
{
    self.selectedFriendsTextView = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
