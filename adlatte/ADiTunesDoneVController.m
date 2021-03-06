//
//  ADiTunesDoneVController.m
//  adlatte
//
//  Created by Tae Han Kim on 13. 2. 15..
//  Copyright (c) 2013년 AdLatte. All rights reserved.
//

#import "ADiTunesDoneVController.h"

@interface ADiTunesDoneVController ()

@end

@implementation ADiTunesDoneVController

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
        
        UIView *lbv = [[UIView alloc] initWithFrame:CGRectMake(0, 123, 320, 400)];
        [lbv setBackgroundColor:HCOLOR(235, 236, 238)];
        [self.view addSubview:lbv];

        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 123, 320, 2)];
        [line setImage:IMN(@"redeem_back_line.png")];
        [self.view addSubview:line];
        UIImageView *line2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 172, 320, 2)];
        [line2 setImage:IMN(@"redeem_back_line.png")];
        [self.view addSubview:line2];

        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(51, 187, 215, 215)];
        if( [UIScreen mainScreen].bounds.size.height > 480.0 )
            [img setFrame:CGRectOffset(img.frame, 0, 40)];
        [img setImage:IMN(@"itunes_giftcard_215_215.png")];
        [self.view addSubview:img];

        UILabel *head = [[UILabel alloc] initWithFrame:CGRectMake(20, 29, 280, 34)];
        [head setBackgroundColor:self.view.backgroundColor];
        [head setFont:[UIFont boldSystemFontOfSize:14]];
        [head setTextAlignment:NSTextAlignmentCenter];
        [head setAdjustsFontSizeToFitWidth:YES];
        [head setNumberOfLines:2];
        [head setText:NSLocalizedString(@"You have successfully redeemed a $20\niTunes Gift Card!", @"Redeem iTunes done title")];
        [head setTextColor:HCOLOR(133, 133, 133)];
        [head setShadowColor:[UIColor whiteColor]];
        [head setShadowOffset:CGSizeMake(0.8, 0.8)];
        [self.view addSubview:head];
        
        UILabel *mypnt = [[UILabel alloc] initWithFrame:CGRectMake(20, 78, 280, 32)];
        [mypnt setBackgroundColor:self.view.backgroundColor];
        [mypnt setFont:[UIFont systemFontOfSize:13]];
        [mypnt setNumberOfLines:2];
        [mypnt setTextAlignment:NSTextAlignmentCenter];
        [mypnt setTextColor:HCOLOR(133, 133, 133)];
        [mypnt setShadowColor:[UIColor whiteColor]];
        [mypnt setShadowOffset:CGSizeMake(0.8, 0.8)];
        [mypnt setText:NSLocalizedString(@"Gift cards are transferred every Friday.\nThank you for using AdLatte!", @"Redeem iTunes done info")];
        [self.view addSubview:mypnt];

        UILabel *info = [[UILabel alloc] initWithFrame:CGRectMake(16, 135, 288, 32)];
        [info setBackgroundColor:lbv.backgroundColor];
        [info setFont:[UIFont systemFontOfSize:13]];
        [info setNumberOfLines:2];
        [info setTextColor:HCOLOR(111, 111, 111)];
        [info setShadowColor:[UIColor whiteColor]];
        [info setShadowOffset:CGSizeMake(0.8, 0.8)];
        [info setAdjustsFontSizeToFitWidth:YES];
        [info setText:NSLocalizedString(@"You have ___ Latte Points remaining.", @"Redeem iTunes done 2nd info")];
        [self.view addSubview:info];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIBarButtonItem *setItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneView)];
    self.navigationItem.rightBarButtonItem = setItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

- (void) doneView
{
    [self dismissViewControllerAnimated:YES completion:^{
        ;
    }];
}

@end
