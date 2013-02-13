//
//  MovieViewController.h
//  adlatteGlobalCore
//
//  Created by 수아 강 on 12. 8. 20..
//  Copyright (c) 2012년 서울대학교. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ShowAdvDetailViewController;
@interface MovieViewController : UIViewController
@property (nonatomic, strong) NSString* path;
@property (nonatomic, strong) ShowAdvDetailViewController* parent;
@end
