//
//  ADStoreCell.m
//  adlatte
//
//  Created by Tae Han Kim on 13. 2. 13..
//  Copyright (c) 2013년 AdLatte. All rights reserved.
//

#import "ADStoreCell.h"

@implementation ADStoreCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self setFrame:CGRectMake(0, 0, 320, 85)];
        UIImageView *bgv = [[UIImageView alloc] initWithImage:IMN(@"bar_bg_320_85.png")];
        [bgv setFrame:self.contentView.bounds];
        [bgv setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
        [self.contentView addSubview:bgv];

        thumbImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 65, 65)];
        [self.contentView addSubview:thumbImg];
        UIImageView *shadow = [[UIImageView alloc] initWithFrame:CGRectMake(10, 75, 65, 5)];
        [shadow setImage:IMN(@"thumb_shadow_65_5.png")];
        [self.contentView addSubview:shadow];

        arrowImg = [[UIImageView alloc] initWithFrame:CGRectMake(294, 35, 15, 15)];
        [arrowImg setImage:IMN(@"arrow_15_15.png")];
        [self.contentView addSubview:arrowImg];

        brandText = [[UILabel alloc] initWithFrame:CGRectMake(87, 17, 200, 12)];
        [brandText setBackgroundColor:[UIColor clearColor]];
        [brandText setFont:[UIFont systemFontOfSize:11.0]];
        [brandText setTextColor:HCOLOR(56, 56, 56)];
        [self.contentView addSubview:brandText];

        titleText = [[UILabel alloc] initWithFrame:CGRectMake(87, 35, 200, 16)];
        [titleText setBackgroundColor:[UIColor clearColor]];
        [titleText setFont:[UIFont systemFontOfSize:15.0]];
        [titleText setTextColor:HCOLOR(56, 56, 56)];
        [titleText setShadowOffset:CGSizeMake(0.8, 0.8)];
        [titleText setShadowColor:[UIColor whiteColor]];
        [self.contentView addSubview:titleText];

        cashText = [[UILabel alloc] initWithFrame:CGRectMake(87, 56, 120, 12)];
        [cashText  setFont:[UIFont systemFontOfSize:12.0]];
        [cashText setBackgroundColor:[UIColor clearColor]];
        [cashText setTextColor:HCOLOR(93, 93, 93)];
        [cashText setShadowOffset:CGSizeMake(0.8, 0.8)];
        [cashText setShadowColor:[UIColor whiteColor]];
        [self.contentView addSubview:cashText];

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark -

- (void) dataInit
{
    [brandText setText:@"Starbucks"];
    [titleText setText:@"Ice Cafe Latte"];
    [cashText setText:@"$ 3.5"];

    // brand text 가 없는 경우는 나머지 두 개의 라벨 위치를 조정한다.
    if( nil == brandText.text ){
        [titleText setFrame:CGRectMake(87, 27, 200, 16)];
        [cashText setFrame:CGRectMake(87, 48, 120, 12)];
    } else {
        [titleText setFrame:CGRectMake(87, 35, 200, 16)];
        [cashText setFrame:CGRectMake(87, 56, 120, 12)];
    }
}

@end
