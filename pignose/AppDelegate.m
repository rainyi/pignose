//
//  AppDelegate.m
//  pignose
//
//  Created by WooGyeong Lee on 12. 8. 2..
//  Copyright (c) 2012년 rainyi. All rights reserved.
//

#import "AppDelegate.h"
#import "MFSideMenu.h"
#import "MainViewController.h"
#import "LoginViewController.h"
#import "SideMenuViewController.h"

@implementation AppDelegate

@synthesize navController = _navController;
@synthesize mainViewController = _mainViewController;

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [FBSession.activeSession handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [FBProfilePictureView class];
    
    if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded)
    {
        // Yes, so just open the session (this won't display any UX).
        [self openSession];
        self.mainViewController = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
        self.mainViewController.title = @"USER INFO";
        self.navController = [[UINavigationController alloc] initWithRootViewController:self.mainViewController];
        self.window.rootViewController = self.navController;
        [self.window makeKeyAndVisible];
        SideMenuViewController *sideMenuViewController = [[SideMenuViewController alloc] init];
        // make sure to display the navigation controller before calling this
        [MFSideMenuManager configureWithNavigationController:self.navController
                                          sideMenuController:sideMenuViewController];
    }
    else
    {
        // No, display the login page.
        self.mainViewController = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
        self.mainViewController.title = @"USER INFO";
        self.navController = [[UINavigationController alloc] initWithRootViewController:self.mainViewController];
        self.window.rootViewController = self.navController;
        [self.window makeKeyAndVisible];
        SideMenuViewController *sideMenuViewController = [[SideMenuViewController alloc] init];
        // make sure to display the navigation controller before calling this
        [MFSideMenuManager configureWithNavigationController:self.navController
                                          sideMenuController:sideMenuViewController];
        [self showLoginView];
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    // this means the user switched back to this app without completing
    // a login in Safari/Facebook App
    if (FBSession.activeSession.state == FBSessionStateCreatedOpening)
    {
        [FBSession.activeSession close]; // so we close our session and start over
    }
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)showLoginView
{
    UIViewController *topViewController = [self.navController topViewController];
    UIViewController *modalViewController = [topViewController modalViewController];
    
    // If the login screen is not already displayed, display it. If the login screen is
    // displayed, then getting back here means the login in progress did not successfully
    // complete. In that case, notify the login view so it can update its UI appropriately.
    if (![modalViewController isKindOfClass:[LoginViewController class]])
    {
        LoginViewController* loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        [topViewController presentModalViewController:loginViewController animated:NO];
    }
    else
    {
        LoginViewController* loginViewController = (LoginViewController*)modalViewController;
        [loginViewController loginFailed];
    }
}

- (void)sessionStateChanged:(FBSession *)session
                      state:(FBSessionState) state
                      error:(NSError *)error
{
    switch (state)
    {
        case FBSessionStateOpen:
        {
            UIViewController *topViewController = [self.navController topViewController];
            if ([[topViewController modalViewController] isKindOfClass:[LoginViewController class]])
            {
                [topViewController dismissModalViewControllerAnimated:YES];
            }
        }
            break;
        case FBSessionStateClosed:
        case FBSessionStateClosedLoginFailed:
            // Once the user has logged in, we want them to
            // be looking at the root view.
            [self.navController popToRootViewControllerAnimated:NO];
            
            [FBSession.activeSession closeAndClearTokenInformation];
            
            [self showLoginView];
            break;
        default:
            break;
    }
    
    if (error)
    {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Error"
                                  message:error.localizedDescription
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
}

- (void)openSession
{
    [FBSession sessionOpenWithPermissions:nil completionHandler:
     ^(FBSession *session, FBSessionState state, NSError *error) {
         [self sessionStateChanged:session state:state error:error];
     }];    
}

@end
