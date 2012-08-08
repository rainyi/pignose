//
//  LoginViewController.h
//  pignose
//
//  Created by WooGyeong Lee on 12. 8. 2..
//  Copyright (c) 2012년 rainyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

- (void)loginFailed;
- (IBAction)loginButtonWasPressed:(id)sender;

@end
