//
//  ADWISHVController.m
//  adlatte
//
//  Created by Tae Han Kim on 13. 2. 15..
//  Copyright (c) 2013년 AdLatte. All rights reserved.
//

#import "ADWISHVController.h"


@implementation ADWISHVController

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

        UIButton *comboBtn = [[UIButton alloc] initWithFrame:CGRectMake(272, 239, 27, 27)];
        [comboBtn setBackgroundImage:IMN(@"login_down_button_27_27.png") forState:UIControlStateNormal];
        [comboBtn setBackgroundImage:IMN(@"login_down_button_p_27_27.png") forState:UIControlStateHighlighted];
        [comboBtn addTarget:self action:@selector(comboAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:comboBtn];

        UILabel *info = [[UILabel alloc] initWithFrame:CGRectMake(21, 31, 280, 50)];
        [info setBackgroundColor:self.view.backgroundColor];
        [info setFont:[UIFont systemFontOfSize:12]];
        [info setTextColor:HCOLOR(93, 93, 93)];
        [info setShadowColor:[UIColor whiteColor]];
        [info setShadowOffset:CGSizeMake(0.8, 0.8)];
        [info setNumberOfLines:0];
        [info setText:NSLocalizedString(@"WISH gift cards takes 6~8 days for delivery.\nYour information will be used only for delivery purposes. ", @"WISH giftcard info text")];
        [info sizeToFit];
        [self.view addSubview:info];

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

#pragma mark -

- (void) redeemSubmit
{
    // TODO: something...
}

@end
