//
//  ADiTunesVController.m
//  adlatte
//
//  Created by Tae Han Kim on 13. 2. 15..
//  Copyright (c) 2013년 AdLatte. All rights reserved.
//

#import "ADiTunesVController.h"
#import "ADiTunesDoneVController.h"


@implementation ADiTunesVController

- (id)init
{
    self = [super init];
    if (self) {
        self.title = NSLocalizedString(@"LATTE STORE", @"3rd tab");
        DEF_TITLE( self.title );
        
        priceArray = @[@"20", @"40", @"50"];

        [self.view setBackgroundColor:HCOLOR(247, 248, 249)];

        UIImageView *hb = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 10)];
        [hb setImage:IMN(@"bgtop_shadow_320_10.png")];
        [self.view addSubview:hb];
        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 150, 320, 2)];
        [line setImage:IMN(@"redeem_back_line.png")];
        [self.view addSubview:line];

        UIView *lbv = [[UIView alloc] initWithFrame:CGRectMake(0, 152, 320, 400)];
        [lbv setBackgroundColor:HCOLOR(235, 236, 238)];
        [self.view addSubview:lbv];

        UIImageView *tb = [[UIImageView alloc] initWithFrame:CGRectMake(18, 101, 284, 34)];
        [tb setImage:IMN(@"redeem_itunes_box_284_34.png")];
        [self.view addSubview:tb];

        UILabel *head = [[UILabel alloc] initWithFrame:CGRectMake(20, 31, 280, 17)];
        [head setBackgroundColor:self.view.backgroundColor];
        [head setFont:[UIFont boldSystemFontOfSize:13]];
        [head setTextAlignment:NSTextAlignmentCenter];
        [head setText:NSLocalizedString(@"You currently have ___ Latte Points!", @"Redeem Paypal - my points")];
        [head setTextColor:HCOLOR(133, 133, 133)];
        [head setShadowColor:[UIColor whiteColor]];
        [head setShadowOffset:CGSizeMake(0.8, 0.8)];
        [self.view addSubview:head];

        // -----------------------------------------------------------
        NSMutableArray  *btnArray = [[NSMutableArray alloc] initWithCapacity:3];
        for( NSUInteger i = 0; i < 3 ; i ++ )
        {
            UIButton *cBtn = [[UIButton alloc] initWithFrame:CGRectMake(25, 57, 79, 30)];
            [cBtn setBackgroundImage:IMN(@"redeem_price_79_30.png") forState:UIControlStateNormal];
            [cBtn setBackgroundImage:IMN(@"redeem_price_p_79_30.png") forState:UIControlStateHighlighted];
            [btnArray addObject:cBtn];
            [cBtn addTarget:self action:@selector(priceBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [cBtn setTag:i];
            [cBtn setTitleColor:HCOLOR(212, 163, 0) forState:UIControlStateNormal];
            [cBtn setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [cBtn.titleLabel setShadowOffset:CGSizeMake(0.8, 0.8)];
            [cBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
            [cBtn setTitle:[NSString stringWithFormat:@"%@%@",CSIGN,priceArray[i]] forState:UIControlStateNormal];
            [self.view addSubview:cBtn];
        }
        ((UIButton*)btnArray[1]).frame = CGRectMake(121, 57, 79, 30);
        ((UIButton*)btnArray[2]).frame = CGRectMake(216, 57, 79, 30);

        emailField = [[UITextField alloc] initWithFrame:CGRectMake(25, 108, 270, 20)];
        [emailField setPlaceholder:NSLocalizedString(@"enter email address here", @"Paypal redeem email box")];
        [emailField setFont:[UIFont systemFontOfSize:15]];
        [emailField setKeyboardType:UIKeyboardTypeEmailAddress];
        [self.view addSubview:emailField];
    }

    [emailField becomeFirstResponder];

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

- (void) priceBtnAction:(UIButton*)sender
{
    // TODO: something...
    
}

- (void) redeemSubmit
{
    // TODO: something...

    // 결과 화면은 modal view 로 나타나고, 그 사이 현재 뷰는 pop 한다.
    ADiTunesDoneVController *dvc = [[ADiTunesDoneVController alloc] init];
    UINavigationController *tnvc = [[UINavigationController alloc] initWithRootViewController:dvc];
    
    [self presentViewController:tnvc animated:YES completion:^{
        [self.navigationController popViewControllerAnimated:NO];
    }];
}

@end
