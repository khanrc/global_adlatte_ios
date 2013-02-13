//
//  ADEventCmtCell.m
//  adlatte
//
//  Created by Tae Han Kim on 13. 2. 7..
//  Copyright (c) 2013년 AdLatte. All rights reserved.
//

#import "ADEventCmtCell.h"

@implementation ADEventCmtCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UIImageView *backView = [[UIImageView alloc] initWithFrame:self.bounds];
        [backView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
        [backView setImage:IMN(@"ad_list_event_copy_sell_bg_320_68.png")];
        [self.contentView addSubview:backView];

        UIImageView *frImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 58, 63)];
        [frImg setImage:IMN(@"ad_list_event_list_thumb_58_63.png")];
        [self.contentView addSubview:frImg];

        profileImg = [[UIImageView alloc] initWithFrame:CGRectMake(14, 9, 50, 50)];
        [profileImg setImage:IMN(@"profile_img_64_64.png")];
        [self.contentView addSubview:profileImg];

        // ---------------------------------------------------------------
        nickname = [[UILabel alloc] initWithFrame:CGRectMake(78, 11, 178, 14)];
        [nickname setFont:[UIFont systemFontOfSize:10.0]];
        [nickname setBackgroundColor:[UIColor clearColor]];
        [nickname setTextColor:HCOLOR(121, 121, 121)];
        [self.contentView addSubview:nickname];

        comment = [[UILabel alloc] initWithFrame:CGRectMake(78, 27, 200, 15)];
        [comment  setFont:[UIFont systemFontOfSize:13.0]];
        [comment setBackgroundColor:[UIColor clearColor]];
        [comment setTextColor:HCOLOR(71, 69, 69)];
        [comment setShadowOffset:CGSizeMake(-0.8, -0.8)];
        [comment setShadowColor:[UIColor whiteColor]];
        [self.contentView addSubview:comment];

        cashText = [[UILabel alloc] initWithFrame:CGRectMake(78, 50, 120, 12)];
        [cashText  setFont:[UIFont systemFontOfSize:12.0]];
        [cashText setBackgroundColor:[UIColor clearColor]];
        [cashText setTextColor:HCOLOR(115, 111, 111)];
        [cashText setShadowOffset:CGSizeMake(-0.8, -0.8)];
        [cashText setShadowColor:[UIColor whiteColor]];
        [self.contentView addSubview:cashText];

        dateText = [[UILabel alloc] initWithFrame:CGRectMake(252, 11, 70, 12)];
        [dateText  setFont:[UIFont systemFontOfSize:11.0]];
        [dateText setBackgroundColor:[UIColor clearColor]];
        [dateText setTextColor:HCOLOR(128, 128, 128)];
        [dateText setShadowOffset:CGSizeMake(-0.8, -0.8)];
        [dateText setShadowColor:[UIColor whiteColor]];
        [self.contentView addSubview:dateText];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark -

-(void) setData
{
    [nickname setText:@"Brian"];
    [comment setText:@"You should know that"];
    [cashText setText:@"$ 0.5"];
    [dateText setText:@"1.17 16:01"];
}

@end
