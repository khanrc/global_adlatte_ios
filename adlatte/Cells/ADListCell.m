//
//  ADListCell.m
//  adlatte
//
//  Created by Tae Han Kim on 13. 2. 6..
//  Copyright (c) 2013년 AdLatte. All rights reserved.
//

#import "ADListCell.h"

@implementation ADListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
