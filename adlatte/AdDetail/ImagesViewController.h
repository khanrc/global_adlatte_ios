//
//  ImagesViewController.h
//  adlatteGlobalCore
//
//  Created by 수아 강 on 12. 8. 20..
//  Copyright (c) 2012년 서울대학교. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdDetailInfo.h"
@class ShowAdvDetailViewController;
@interface ImagesViewController : UIViewController<UIScrollViewDelegate>
@property (nonatomic, strong) AdDetailInfo* adv;

@property (nonatomic, strong) NSArray* images;
@property (nonatomic, strong) ShowAdvDetailViewController* parent;

@end
