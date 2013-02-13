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


@implementation ADGateViewController

- (id)init
{
    self = [super init];
    if (self) {
        UIButton *loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(11, [UIScreen mainScreen].bounds.size.height-119, 146, 45)];
        [loginBtn setBackgroundImage:[UIImage imageNamed:@"login_button_146_45.png"] forState:UIControlStateNormal];
        [loginBtn setTitle:NSLocalizedString(@"Log In", @"login button") forState:UIControlStateNormal];
        [loginBtn.titleLabel setTextColor:HCOLOR(31,31,31)];
        [loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:loginBtn];

        UIButton *signupBtn = [[UIButton alloc] initWithFrame:CGRectMake(163, loginBtn.frame.origin.y, 146, 45)];
        [signupBtn setBackgroundImage:[UIImage imageNamed:@"signup_button_146_45.png"] forState:UIControlStateNormal];
        [signupBtn setTitle:NSLocalizedString(@"Sign Up", @"sign up button") forState:UIControlStateNormal];
        [signupBtn.titleLabel setTextColor:HCOLOR(212, 163, 0)];
        [signupBtn addTarget:self action:@selector(signupAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:signupBtn];
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
