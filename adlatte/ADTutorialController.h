//
//  ADTutorialController.h
//  adlatte
//
//  Created by Tae Han Kim on 13. 2. 5..
//  Copyright (c) 2013년 Tae Han Kim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADTutorialController : UIViewController <UIScrollViewDelegate>
{
    UIScrollView    *scroll;
    UIPageControl   *pageControl;
    BOOL    _pageControlUsed;

    UIButton *startButton;
}

@end
