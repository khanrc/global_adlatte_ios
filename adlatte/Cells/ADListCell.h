//
//  ADListCell.h
//  adlatte
//
//  Created by Tae Han Kim on 13. 2. 6..
//  Copyright (c) 2013년 AdLatte. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ADListCellDelegate

- (void) touchWatchButton:(NSUInteger)index;

@end

@interface ADListCell : UITableViewCell
{
    NSUInteger      index;

    UIImageView     *thumbImg;
    UIImageView     *arrowImg;
    UIImageView     *newBadgeImg;

    UILabel         *titleText;
    UILabel         *cashText;
    UILabel         *adTypeText;
    UILabel         *eventText;

    UIImageView     *actionBox;
    UIProgressView  *progView;
    UIButton        *watchBtn;

    UILabel         *watchedText;
    UILabel         *infoText;
    UILabel         *gageText;
}

- (void) dataInit;
- (void) openActionPannelWithInfoHeight:(CGFloat)iHeight;
- (void) closeActionPannelWithAnimation:(BOOL) ani;

@property (nonatomic, assign) id <ADListCellDelegate> delegate;

@end
