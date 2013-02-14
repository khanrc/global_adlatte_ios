//
//  ADMyAdCell.m
//  adlatte
//
//  Created by Tae Han Kim on 13. 2. 14..
//  Copyright (c) 2013년 AdLatte. All rights reserved.
//

#import "ADMyAdCell.h"

@implementation ADMyAdCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setFrame:CGRectMake(0, 0, 320, 85+105)];
        UIImageView *bgv = [[UIImageView alloc] initWithImage:IMN(@"bar_bg_320_85.png")];
        [bgv setFrame:self.contentView.bounds];
        [bgv setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
        [self.contentView addSubview:bgv];

        thumbImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 65, 65)];
        [self.contentView addSubview:thumbImg];
        UIImageView *shadow = [[UIImageView alloc] initWithFrame:CGRectMake(10, 75, 65, 5)];
        [shadow setImage:IMN(@"thumb_shadow_65_5.png")];
        [self.contentView addSubview:shadow];

        titleText = [[UILabel alloc] initWithFrame:CGRectMake(87, 35, 160, 16)];
        [titleText setBackgroundColor:[UIColor clearColor]];
        [titleText setFont:[UIFont systemFontOfSize:15.0]];
        [titleText setTextColor:HCOLOR(0x38, 0x38, 0x38)];
        [titleText setShadowOffset:CGSizeMake(0.8, 0.8)];
        [titleText setShadowColor:[UIColor whiteColor]];
        [self.contentView addSubview:titleText];

        dateText = [[UILabel alloc] initWithFrame:CGRectMake(254, 35, 200, 15)];
        [dateText setBackgroundColor:[UIColor clearColor]];
        [dateText setFont:[UIFont systemFontOfSize:12.0]];
        [dateText setTextColor:HCOLOR(0x42, 0x42, 0x42)];
        [dateText setShadowOffset:CGSizeMake(0.8, 0.8)];
        [dateText setShadowColor:[UIColor whiteColor]];
        [self.contentView addSubview:dateText];

        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) dataInit
{
    [titleText setText:@"The Sample"];
    [dateText setText:@"2013.02.14"];
}

@end
