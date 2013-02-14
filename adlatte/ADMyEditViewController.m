//
//  ADMyEditViewController.m
//  adlatte
//
//  Created by Tae Han Kim on 13. 2. 14..
//  Copyright (c) 2013년 AdLatte. All rights reserved.
//

#import "ADMyEditViewController.h"


@implementation ADMyEditViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.title = NSLocalizedString(@"Profile Edit", @"profile edit title");

        [self.view setBackgroundColor:HCOLOR(232, 232, 232)];

        UIImageView *bg1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 167)];
        [bg1 setImage:IMN(@"profile_edit_bg_320_167.png")];
        [self.view addSubview:bg1];

        profileImg = [[UIImageView alloc] initWithFrame:CGRectMake(118, 25, 84, 84)];
        [profileImg setImage:IMN(@"profile_img_84_84.png")];
        [self.view addSubview:profileImg];
        
        UIImageView *pv = [[UIImageView alloc] initWithFrame:CGRectMake(113, 20, 94, 99)];
        [pv setImage:[UIImage imageNamed:@"me_profile_imgbox_border_94_99.png"]];
        [self.view addSubview:pv];

        UIButton *picBtn = [[UIButton alloc] initWithFrame:CGRectMake(106, 128, 108, 26)];
        [picBtn setBackgroundImage:[UIImage imageNamed:@"profile_edit_button_108_26.png"] forState:UIControlStateNormal];
        [picBtn setBackgroundImage:[UIImage imageNamed:@"profile_edit_button_p_108_26.png"] forState:UIControlStateHighlighted];
        [picBtn setTitle:NSLocalizedString(@"Edit Picture", @"button on edit profile") forState:UIControlStateNormal];
        [picBtn setTitleColor:HCOLOR(212, 163, 0) forState:UIControlStateNormal];
        [picBtn setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [picBtn.titleLabel setFont:[UIFont systemFontOfSize:12.0]];
        [picBtn.titleLabel setShadowOffset:CGSizeMake(0.8, 0.8)];
        [picBtn addTarget:self action:@selector(picChangeAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:picBtn];

        // ----
        infoBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 167, 320, 195)];
        [infoBackView setBackgroundColor:[UIColor colorWithPatternImage:IMN(@"profile_edit_info_bg_320_195.png")]];
        [self.view addSubview:infoBackView];

        textField = [[UITextField alloc] initWithFrame:CGRectMake(26, 26, 320-52, 120)];
        [textField setBackgroundColor:[UIColor whiteColor]];
        [textField setTextColor:HCOLOR(143, 143, 143)];
        [textField setFont:[UIFont systemFontOfSize:12.0]];
        [textField setDelegate:self];
        [textField addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
        [infoBackView addSubview:textField];

        UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(resignTextField)];
        UIToolbar *tbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 33)];
        [tbar setItems:@[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],doneBtn] animated:NO];
        [tbar setBackgroundColor:[UIColor clearColor]];
        [tbar setBarStyle:UIBarStyleBlackTranslucent];
        [tbar setOpaque:NO];
        textField.inputAccessoryView = tbar;

        counterLabel = [[UILabel alloc] initWithFrame:CGRectMake(283, 168, 35, 13)];
        [counterLabel setBackgroundColor:[UIColor clearColor]];
        [counterLabel setTextColor:HCOLOR(162, 162, 144)];
        [counterLabel setFont:[UIFont systemFontOfSize:12.0]];
        [infoBackView addSubview:counterLabel];
    }

    DEF_TITLE(self.title);
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIBarButtonItem *setItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveMyInfos)];
    [setItem setTitleTextAttributes:@{UITextAttributeTextColor:[UIColor whiteColor], UITextAttributeTextShadowColor:[UIColor blackColor]} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = setItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark = Text Field Delegate and etc.

- (void) textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.3 animations:^{
        [infoBackView setFrame:CGRectMake(0, 0, 320, 195)];
        if( [UIScreen mainScreen].bounds.size.height == 480 )
            [counterLabel setFrame:CGRectMake(283, 150, 35, 13)];
    }];
}

- (void) textFieldDidEndEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.3 animations:^{
        [infoBackView setFrame:CGRectMake(0, 167, 320, 195)];
        [counterLabel setFrame:CGRectMake(283, 168, 35, 13)];
    }];
}

- (void) textChanged:(UITextField*) tField
{
    NSUInteger count = [tField.text length];

    [counterLabel setText:[NSString stringWithFormat:@"%d",count]];
}


- (BOOL) textFieldShouldReturn:(UITextField *)tField
{
    return YES;
}

- (void) resignTextField
{
    [textField resignFirstResponder];
}
#pragma mark -

- (void) picChangeAction
{
    
}

- (void) saveMyInfos
{
    
}

@end
