//
//  LoginViewController.m
//  pignose
//
//  Created by WooGyeong Lee on 12. 8. 2..
//  Copyright (c) 2012년 rainyi. All rights reserved.
//

#import "LoginViewController.h"
#import "MainViewController.h"
#import "AppDelegate.h"
#import "MFSideMenu.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize spinner;

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
//    self.navigationController.navigationBarHidden = YES;
    [self setupSideMenuBarButtonItem];
}

- (void)viewDidUnload
{
    self.spinner = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)sessionStateChanged:(NSNotification*)notification
{

}

- (void)loginFailed
{
    // User switched back to the app without authorizing. Stay here, but
    // stop the spinner.
    [self.spinner stopAnimating];
}

#if 0
- (IBAction)pushAnotherPressed:(id)sender
{
#if 1
    MainViewController *demoController = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    demoController.title = @"USER INFO";
#else
    LoginViewController *demoController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    demoController.title = @"Other ViewController";
#endif
    
    [self.navigationController pushViewController:demoController animated:YES];
}
#endif

- (IBAction)loginButtonWasPressed:(id)sender
{
    [self.spinner startAnimating];
    
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate openSession];
}

@end
