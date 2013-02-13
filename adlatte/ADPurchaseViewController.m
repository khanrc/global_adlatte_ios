//
//  ADPurchaseViewController.m
//  adlatte
//
//  Created by Tae Han Kim on 13. 2. 13..
//  Copyright (c) 2013년 AdLatte. All rights reserved.
//

#import "ADPurchaseViewController.h"

@interface ADPurchaseViewController ()

@end

@implementation ADPurchaseViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"Purchase", @"Store:Purchase title");

        [self.view setBackgroundColor:[UIColor colorWithPatternImage:IMN(@"latte_store_bg_320_362.png")]];

        UIImageView *itemBg = [[UIImageView alloc] initWithFrame:CGRectMake(18, 18, 289, 214)];
        [itemBg setImage:IMN(@"latte_store_info_box_289_214.png")];
        [self.view addSubview:itemBg];

        UIButton *purchaseBtn = [[UIButton alloc] initWithFrame:CGRectMake(18, [UIScreen mainScreen].bounds.size.height-168, 284, 35)];
        [purchaseBtn setBackgroundImage:[UIImage imageNamed:@"login_button_284_35.png"] forState:UIControlStateNormal];
        [purchaseBtn setBackgroundImage:[UIImage imageNamed:@"login_button_p_284_35.png"] forState:UIControlStateHighlighted];
        [purchaseBtn setTitle:NSLocalizedString(@"Purchase", @"Store:Purchase title") forState:UIControlStateNormal];
        [purchaseBtn setTitleColor:HCOLOR(212, 163, 0) forState:UIControlStateNormal];
        [purchaseBtn setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [purchaseBtn.titleLabel setShadowOffset:CGSizeMake(0.8, 0.8)];
        [purchaseBtn addTarget:self action:@selector(purchaseAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:purchaseBtn];

        productName = [[UILabel alloc] initWithFrame:CGRectMake(18, 25, 289, 14)];
        [productName setBackgroundColor:[UIColor clearColor]];
        [productName setTextAlignment:NSTextAlignmentCenter];
        [productName setTextColor:[UIColor whiteColor]];
        [productName setFont:[UIFont systemFontOfSize:13]];
        [self.view addSubview:productName];

        descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(18, 241, 289, purchaseBtn.frame.origin.y - 241)];
        [descriptionLabel setTextColor:HCOLOR(39, 39, 39)];
        [descriptionLabel setBackgroundColor:[UIColor clearColor]];
        [descriptionLabel setFont:[UIFont systemFontOfSize:11.0]];
        [descriptionLabel setNumberOfLines:10];
        [self.view addSubview:descriptionLabel];

        productImageView = [[UIImageView alloc] initWithFrame:CGRectMake(29, 55, 262, 159)];
        [self.view addSubview:productImageView];
    }

    // TESTING ~~~~~~~~~~~~
    [productName setText:@"Starbucks cafe latte [tall size]"];
    [descriptionLabel setText:@"Starbucks cafe latte\nTake it now!\n~~"];

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

- (void) purchaseAction
{
    
}

@end
