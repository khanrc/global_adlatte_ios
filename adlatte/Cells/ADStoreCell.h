//
//  ADStoreCell.h
//  adlatte
//
//  Created by Tae Han Kim on 13. 2. 13..
//  Copyright (c) 2013년 AdLatte. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADStoreCell : UITableViewCell
{
    NSUInteger      index;
    
    UIImageView     *thumbImg;
    UIImageView     *arrowImg;

    UILabel         *brandText;
    UILabel         *titleText;
    UILabel         *cashText;

}

// TODO: change the prototype
- (void) dataInit;

@end
