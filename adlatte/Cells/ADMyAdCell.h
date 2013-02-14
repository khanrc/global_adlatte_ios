//
//  ADMyAdCell.h
//  adlatte
//
//  Created by Tae Han Kim on 13. 2. 14..
//  Copyright (c) 2013년 AdLatte. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADMyAdCell : UITableViewCell
{
    UIImageView     *thumbImg;
    UILabel         *titleText;
    UILabel         *dateText;
}

- (void) dataInit;

@end
