//
//  ADLogin1ViewController.m
//  adlatte
//
//  Created by Tae Han Kim on 13. 2. 5..
//  Copyright (c) 2013년 Tae Han Kim. All rights reserved.
//

#import "ADLogin1ViewController.h"
#import "ADAppDelegate.h"

@interface ADLogin1ViewController ()

@end

@implementation ADLogin1ViewController

- (id)init
{
    self = [super init];
    if (self) {
        [self.view setBackgroundColor:[UIColor whiteColor]];

        UIButton *loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(24, [UIScreen mainScreen].bounds.size.height-144, 234, 35)];
        [loginBtn setBackgroundImage:[UIImage imageNamed:@"startlogin_button_234_35.png"] forState:UIControlStateNormal];
        [loginBtn setBackgroundImage:[UIImage imageNamed:@"startlogin_button_p_234_35.png"] forState:UIControlStateHighlighted];
        [loginBtn setTitle:NSLocalizedString(@"Log In", @"login button") forState:UIControlStateNormal];
        [loginBtn setTitleColor:HCOLOR(212, 163, 0) forState:UIControlStateNormal];
        [loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:loginBtn];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

- (void) loginAction
{
    [(ADAppDelegate*)[UIApplication sharedApplication].delegate setupBasicTabs];

    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        ;
    }];
}

@end
