//
//  ADGateViewController.m
//  adlatte
//
//  Created by Tae Han Kim on 13. 2. 5..
//  Copyright (c) 2013년 Tae Han Kim. All rights reserved.
//
//  This is LogIn / SignUp Selection View Controller

#import "ADGateViewController.h"
#import "ADSignup1ViewController.h"
#import "ADLogin1ViewController.h"

@interface ADGateViewController()
{

}
@end

@implementation ADGateViewController

- (id)init
{
    self = [super init];
    if (self) {
//        UIImageView
        [self.view addSubview:_makeImageView(_fitImageName(@"launch_login_bg_320_416.png"), 0, 0)];
        
        UIButton *loginBtn = _makeButton(@"login_button_146_45.png", NSLocalizedString(@"Log In", @"login button"), [UIColor colorWithHex:0xd8d8d8], 11, _screenHeight-119, self, @selector(loginAction));
        _addShadow(loginBtn.titleLabel, [UIColor colorWithHex:0x434343], CGSizeMake(0.8, 0.8));
        [self.view addSubview:loginBtn];

        UIButton *signupBtn = _makeButton(@"signup_button_146_45.png", NSLocalizedString(@"Sign Up", @"sign up button"), [UIColor colorWithHex:0xd4a300], 163, loginBtn.y, self, @selector(signupAction));
        _addShadow(signupBtn.titleLabel, [UIColor colorWithHex:0xffffff], CGSizeMake(0.8, 0.8));
        [self.view addSubview:signupBtn];
        
//        NSLog(@"%@", _fitImageName(@"hoi.png"));
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];

    DEF_TITLE_NAVI_ITEM;
    
    DEF_BACK_NAVI_ITEM;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

- (void) loginAction
{
    ADLogin1ViewController *loginVC = [[ADLogin1ViewController alloc] init];
    [self.navigationController pushViewController:loginVC animated:YES];
}

- (void) signupAction
{
    ADSignup1ViewController *signupVC = [[ADSignup1ViewController alloc] init];
    [self.navigationController pushViewController:signupVC animated:YES];
}

@end
