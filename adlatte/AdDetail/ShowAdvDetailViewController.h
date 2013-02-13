//
//  ShowAdvDetailViewController.h
//  adlatteGlobalCore
//
//  Created by 수아 강 on 12. 8. 20..
//  Copyright (c) 2012년 서울대학교. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdDetailInfo.h"

@interface ShowAdvDetailViewController : UIViewController
@property (nonatomic, strong) AdDetailInfo *adv;
- (void)showMovie;
- (void)showImage;
- (void)questionSolved;
- (void)back;
@end
