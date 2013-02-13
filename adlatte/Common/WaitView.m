//
//  WaitView.m
//
//  Created by 태한 김 on 11. 1. 13..
//  Copyright 2013 AppDisco. All rights reserved.
//

#import "WaitView.h"
#import <QuartzCore/QuartzCore.h>

@implementation WaitView


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.7];
        self.layer.cornerRadius = 10.0;
        self.clipsToBounds = YES;

        starView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 55, 55)];
        [starView setCenter:CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2)];
        [starView setImage:[UIImage imageNamed:@"loading_55_55.png"]];
        [self addSubview: starView];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code.
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 /* full rotation*/ * 1 * 10.0 ];
    rotationAnimation.duration = 10.0;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 10;
    
    [starView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

@end
