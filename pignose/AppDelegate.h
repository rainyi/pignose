//
//  AppDelegate.h
//  pignose
//
//  Created by WooGyeong Lee on 12. 8. 2..
//  Copyright (c) 2012년 rainyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "MainViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MainViewController *mainViewController;
@property (strong, nonatomic) UINavigationController* navController;


- (void)openSession;

@end
