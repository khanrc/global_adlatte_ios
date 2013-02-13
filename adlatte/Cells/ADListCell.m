//
//  ADListCell.m
//  adlatte
//
//  Created by Tae Han Kim on 13. 2. 6..
//  Copyright (c) 2013년 AdLatte. All rights reserved.
//
//  TableCell for Main Ad List

#import "ADListCell.h"

@implementation ADListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setFrame:CGRectMake(0, 0, 320, 85+105)];
        UIImageView *bgv = [[UIImageView alloc] initWithImage:IMN(@"bar_bg_320_85.png")];
        [bgv setFrame:self.contentView.bounds];
        [bgv setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
        [self.contentView addSubview:bgv];
//        [self.contentView setBackgroundColor:[UIColor colorWithPatternImage:IMN(@"bar_bg_320_85.png")] ];        
        [self.contentView setClipsToBounds:YES];

        thumbImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 65, 65)];
        [self.contentView addSubview:thumbImg];
        UIImageView *shadow = [[UIImageView alloc] initWithFrame:CGRectMake(10, 75, 65, 5)];
        [shadow setImage:IMN(@"thumb_shadow_65_5.png")];
        [self.contentView addSubview:shadow];

        arrowImg = [[UIImageView alloc] initWithFrame:CGRectMake(294, 35, 14, 9)];
        [arrowImg setImage:IMN(@"arrow_button_down_14_9.png")];
        [self.contentView addSubview:arrowImg];

        newBadgeImg = [[UIImageView alloc] initWithFrame:CGRectMake(4, 10, 32, 32)];
        [newBadgeImg setImage:IMN(@"new_button_32_32.png")];
        [self.contentView addSubview:newBadgeImg];

        titleText = [[UILabel alloc] initWithFrame:CGRectMake(87, 8, 200, 30)];
        [titleText setBackgroundColor:[UIColor clearColor]];
        [titleText setFont:[UIFont systemFontOfSize:15.0]];
        [titleText setTextColor:HCOLOR(0x42, 0x42, 0x42)];
        [titleText setShadowOffset:CGSizeMake(0.8, 0.8)];
        [titleText setShadowColor:[UIColor whiteColor]];
        [self.contentView addSubview:titleText];

        cashText = [[UILabel alloc] initWithFrame:CGRectMake(87, 31, 100, 24)];
        [cashText setBackgroundColor:[UIColor clearColor]];
        [cashText setFont:[UIFont systemFontOfSize:12.0]];
        [cashText setTextColor:HCOLOR(0x80, 0x80, 0x80)];
        [cashText setShadowOffset:CGSizeMake(0.8, 0.8)];
        [cashText setShadowColor:[UIColor whiteColor]];
        [self.contentView addSubview:cashText];

        adTypeText = [[UILabel alloc] initWithFrame:CGRectMake(87, 31, 100, 24)];
        [adTypeText setBackgroundColor:[UIColor clearColor]];
        [adTypeText setFont:[UIFont systemFontOfSize:11.0]];
        [adTypeText setTextColor:HCOLOR(0x23, 0x23, 0x23)];
        [adTypeText setShadowOffset:CGSizeMake(0.8, 0.8)];
        [adTypeText setShadowColor:[UIColor whiteColor]];
        [self.contentView addSubview:adTypeText];

        eventText = [[UILabel alloc] initWithFrame:CGRectMake(87, 54, 190, 24)];
        [eventText setBackgroundColor:[UIColor clearColor]];
        [eventText setFont:[UIFont systemFontOfSize:12.0]];
        [eventText setTextColor:HCOLOR(0x42, 0x42, 0x42)];
        [eventText setShadowOffset:CGSizeMake(0.8, 0.8)];
        [eventText setShadowColor:[UIColor whiteColor]];
        [self.contentView addSubview:eventText];

        //---------------------------------------------------------
        actionBox = [[UIImageView alloc] initWithFrame:CGRectMake(10, 85, 300, 100)];
        [actionBox setImage:[IMN(@"ad_list_ac_sheet.png") resizableImageWithCapInsets:UIEdgeInsetsMake(6, 6, 6, 6)]];
        [actionBox setClipsToBounds:YES];
        [actionBox setUserInteractionEnabled:YES];
//        [actionBox setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
        [self.contentView addSubview:actionBox];

        progView = [[UIProgressView alloc] initWithFrame:CGRectMake(16, 45, 268, 8)];
        [progView setTrackImage:IMN(@"ad_list_slider_bar_268_8")];
        [progView setProgressImage:[IMN(@"ad_list_slider_bar_bl_8_8") resizableImageWithCapInsets:UIEdgeInsetsMake(0, 4, 0, 4)]];
        [progView setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin];
        [actionBox addSubview:progView];

        watchBtn = [[UIButton alloc] initWithFrame:CGRectMake(87, 65, 127, 29)];
        [watchBtn setBackgroundImage:IMN(@"watch_ad_button_127_29.png") forState:UIControlStateNormal];
        [watchBtn setBackgroundImage:IMN(@"watch_ad_button_p_127_29.png") forState:UIControlStateHighlighted];
        [watchBtn setTitle:NSLocalizedString(@"WATCH AD", @"Watch Ad button on list cell") forState:UIControlStateNormal];
        [watchBtn addTarget:self action:@selector(watchAction:) forControlEvents:UIControlEventTouchUpInside];
        [watchBtn setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin];
        [watchBtn.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
        [watchBtn.titleLabel setShadowColor:[UIColor blackColor]];
        [watchBtn.titleLabel setShadowOffset:CGSizeMake(-0.8, -0.8)];
        [actionBox addSubview:watchBtn];

        watchedText = [[UILabel alloc] initWithFrame:CGRectMake(16, 5, 200, 9)];
        [watchedText setBackgroundColor:[UIColor clearColor]];
        [watchedText setTextColor:[UIColor redColor]];
        [watchedText setFont:[UIFont systemFontOfSize:8]];
        [actionBox addSubview:watchedText];

        gageText = [[UILabel alloc] initWithFrame:CGRectMake(231, 58, 53, 16)];
        [gageText setBackgroundColor:[UIColor clearColor]];
        [gageText setTextColor:HCOLOR(0x42, 0x42, 0x42)];
        [gageText setFont:[UIFont systemFontOfSize:11]];
        [gageText setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin];
        [actionBox addSubview:gageText];

        infoText = [[UILabel alloc] initWithFrame:CGRectMake(16, 13, 268, 15)];
        [infoText setBackgroundColor:[UIColor clearColor]];
        [infoText setTextColor:HCOLOR(0x42, 0x42, 0x42)];
        [infoText setFont:[UIFont systemFontOfSize:12]];
        [infoText setNumberOfLines:0];
//        [infoText setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
        [infoText setLineBreakMode:NSLineBreakByWordWrapping];
        [actionBox addSubview:infoText];
    }

    [self setSelectionStyle:UITableViewCellSelectionStyleGray];

    return self;
}

- (void) dataInit
{
    [progView setProgress:0.5];
    // TODO:....
    [titleText setText:@"Awesome AD title"];
    [cashText setText:@"$ 1.99"];
    [adTypeText setText:@"view AD"];
    [adTypeText setFrame:CGRectOffset(cashText.frame, [cashText.text sizeWithFont:[cashText font]].width + 20, 0)];
    [eventText setText:@"EVENT $199.99"];

    [watchedText setText:@"watched ad"];
    [infoText setText:@"The running shose superstore\nBlablabla adsjk a;sdjkfh ;kdsh lhkf aks fadkhj"];
    [gageText setText:@"568/1,000"];
}

- (void) openActionPannelWithInfoHeight:(CGFloat)iHeight
{
    [arrowImg setImage:IMN(@"arrow_button_up_14_9.png")];

    [infoText setFrame:CGRectMake(16, 13, 268, iHeight)];
    [UIView animateWithDuration:0.3 animations:^{
        [actionBox setFrame:CGRectMake(10, 85, 300, 75 + iHeight)];
        [actionBox setAlpha:1.0];
    }];
}

- (void) closeActionPannelWithAnimation:(BOOL) ani
{
    if( ani )
        [UIView animateWithDuration:0.3 animations:^{
            [actionBox setAlpha:0.0];
            [actionBox setFrame:CGRectMake(10, 85, 300, 2)];
        }];
    else
    {
        [actionBox setAlpha:0.0];
        [actionBox setFrame:CGRectMake(10, 85, 300, 2)];
    }
    [arrowImg setImage:IMN(@"arrow_button_down_14_9.png")];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark -

- (void) watchAction:(UIButton*)sender
{
    [_delegate touchWatchButton:index];
}


@end
