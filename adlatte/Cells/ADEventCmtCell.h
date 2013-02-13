//
//  ADEventCmtCell.h
//  adlatte
//
//  Created by Tae Han Kim on 13. 2. 7..
//  Copyright (c) 2013년 AdLatte. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADEventCmtCell : UITableViewCell
{
    UIImageView     *profileImg;

    UILabel         *nickname;
    UILabel         *comment;
    UILabel         *cashText;
    UILabel         *dateText;
}

-(void) setData; // TODO: data params

@end
