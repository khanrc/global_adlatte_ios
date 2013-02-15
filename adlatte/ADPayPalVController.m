//
//  ADPayPalVController.m
//  adlatte
//
//  Created by Tae Han Kim on 13. 2. 15..
//  Copyright (c) 2013년 AdLatte. All rights reserved.
//

#import "ADPayPalVController.h"
#import "ADPayPalDoneVController.h"

@interface ADPayPalVController ()

@end

@implementation ADPayPalVController

- (id)init
{
    self = [super init];
    if (self) {
        self.title = NSLocalizedString(@"LATTE STORE", @"3rd tab");
        DEF_TITLE( self.title );

        [self.view setBackgroundColor:HCOLOR(247, 248, 249)];

        UIImageView *hb = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 10)];
        [hb setImage:IMN(@"bgtop_shadow_320_10.png")];
        [self.view addSubview:hb];

        UIImageView *tb = [[UIImageView alloc] initWithFrame:CGRectMake(18, 69, 284, 67)];
        [tb setImage:IMN(@"redeem_box_284_67.png")];
        [self.view addSubview:tb];

        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 150, 320, 2)];
        [line setImage:IMN(@"redeem_back_line.png")];
        [self.view addSubview:line];

        UIView *lbv = [[UIView alloc] initWithFrame:CGRectMake(0, 152, 320, 400)];
        [lbv setBackgroundColor:HCOLOR(235, 236, 238)];
        [self.view addSubview:lbv];

        UILabel *head = [[UILabel alloc] initWithFrame:CGRectMake(20, 29, 280, 17)];
        [head setBackgroundColor:self.view.backgroundColor];
        [head setFont:[UIFont boldSystemFontOfSize:16]];
        [head setTextAlignment:NSTextAlignmentCenter];
        [head setText:NSLocalizedString(@"Congratulations!", @"Redeem Paypal title")];
        [head setTextColor:HCOLOR(133, 133, 133)];
        [head setShadowColor:[UIColor whiteColor]];
        [head setShadowOffset:CGSizeMake(0.8, 0.8)];
        [self.view addSubview:head];

        UILabel *mypnt = [[UILabel alloc] initWithFrame:CGRectMake(20, 48, 280, 16)];
        [mypnt setBackgroundColor:self.view.backgroundColor];
        [mypnt setFont:[UIFont systemFontOfSize:13]];
        [mypnt setTextAlignment:NSTextAlignmentCenter];
        [mypnt setTextColor:HCOLOR(133, 133, 133)];
        [mypnt setShadowColor:[UIColor whiteColor]];
        [mypnt setShadowOffset:CGSizeMake(0.8, 0.8)];
        [mypnt setText:NSLocalizedString(@"You currently have ___ Latte Points!", @"Redeem Paypal - my points")];
        [self.view addSubview:mypnt];

        UILabel *info = [[UILabel alloc] initWithFrame:CGRectMake(20, 161, 280, 35)];
        [info setBackgroundColor:lbv.backgroundColor];
        [info setFont:[UIFont systemFontOfSize:12]];
        [info setTextColor:HCOLOR(111, 111, 111)];
        [info setShadowColor:[UIColor whiteColor]];
        [info setShadowOffset:CGSizeMake(0.8, 0.8)];
        [info setNumberOfLines:2];
        [info setText:NSLocalizedString(@"You must have at least 15 Latte Points in order to exchange your points for cash.", @"Redeem Paypal - info text")];
        [self.view addSubview:info];

        pointNumField = [[UITextField alloc] initWithFrame:CGRectMake(25, 75, 270, 20)];
        [pointNumField setPlaceholder:NSLocalizedString(@"how many points you want to exchange?", @"Paypal redeem input box")];
        [pointNumField setFont:[UIFont systemFontOfSize:15]];
        [pointNumField setAdjustsFontSizeToFitWidth:YES];
        [pointNumField setKeyboardType:UIKeyboardTypeNumberPad];
        [self.view addSubview:pointNumField];

        emailField = [[UITextField alloc] initWithFrame:CGRectMake(25, 110, 270, 20)];
        [emailField setPlaceholder:NSLocalizedString(@"enter email address here", @"Paypal redeem email box")];
        [emailField setFont:[UIFont systemFontOfSize:15]];
        [emailField setKeyboardType:UIKeyboardTypeEmailAddress];
        [self.view addSubview:emailField];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *setItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Submit", @"Store redeem") style:UIBarButtonItemStyleBordered target:self action:@selector(redeemSubmit)];
    self.navigationItem.rightBarButtonItem = setItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action

- (void) redeemSubmit
{
    // TODO: something...

    // 결과 화면은 modal view 로 나타나고, 그 사이 현재 뷰는 pop 한다.
    ADPayPalDoneVController *dvc = [[ADPayPalDoneVController alloc] init];
    UINavigationController *tnvc = [[UINavigationController alloc] initWithRootViewController:dvc];

    [self presentViewController:tnvc animated:YES completion:^{
        [self.navigationController popViewControllerAnimated:NO];
    }];
}

@end
