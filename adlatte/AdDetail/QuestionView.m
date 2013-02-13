//
//  QuestionView.m
//  adlatteGlobalCore
//
//  Created by 수아 강 on 12. 8. 20..
//  Copyright (c) 2012년 서울대학교. All rights reserved.
//

#import "QuestionView.h"
#import <QuartzCore/QuartzCore.h>
#import "ImagesViewController.h"

@interface QuestionView()
{
    int answer;
    int tryAgain;
}
@end

@implementation QuestionView
@synthesize parent;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *backView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 480, 320)];
        [backView setImage:IMN(@"cpq_hybrid_bg_480_320.png")];
        [self addSubview:backView];
        UIButton *replyBtn = [[UIButton alloc] initWithFrame:CGRectMake(372, 26, 102, 49)];
        [replyBtn setBackgroundImage:IMN(@"cpq_replay_button_102_49.png") forState:UIControlStateNormal];
        [replyBtn setBackgroundImage:IMN(@"cpq_replay_button_p_102_49.png") forState:UIControlStateHighlighted];
        [replyBtn addTarget:self action:@selector(replay) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:replyBtn];

        tryAgain = 2;
    }
    return self;
}
- (void)createView: (AdDetailInfo*) adv
{
    NSString* question = [adv valueForKey:@"quiz"];
    answer = [[adv valueForKey:@"answer"] intValue];
    UILabel *q = [[UILabel alloc] initWithFrame:CGRectMake(114, 62, 480-114-60, 20)];
    [q setFont:[UIFont systemFontOfSize:16]];
    [q setBackgroundColor:[UIColor clearColor]];
    [q setTextColor:[UIColor blackColor]];
    [q setText:question];
    [self addSubview:q];
    q.numberOfLines = 3;
    float titleHeight = [q textRectForBounds:CGRectMake(0, 0, q.bounds.size.width, CGFLOAT_MAX)  limitedToNumberOfLines:3].size.height;
    [q setFrame:CGRectMake(114, 62+20-titleHeight, 480-114-60, titleHeight)];
    
    
    NSArray* exams = [adv valueForKey:@"examples"];
    int i = 0;
    for(NSString* exam in exams)
    {
        UILabel* l = [[UILabel alloc] initWithFrame:CGRectMake(110, 120+i*33, 480-110, 30)];
        [l setTextColor:HCOLOR(0x27, 0x27, 0x27)];
        [l setBackgroundColor:[UIColor clearColor]];
        [l setFont:[UIFont systemFontOfSize:15.0]];
        [l setText:exam];
        [self addSubview:l];
        l.userInteractionEnabled = true;
        l.tag = i;
        UILongPressGestureRecognizer* ll;
        [l addGestureRecognizer:ll =[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(choose:)]];
        ll.minimumPressDuration= 0.001;
        ++i;
    }
}

- (void)choose:(UILongPressGestureRecognizer*)tap
{
    int no = tap.view.tag;
    if (tap.state == 1)
    {
        CGRect frame = tap.view.frame;
        frame.origin.x -= 10;
        frame.size.width = 280;
        
        UIView* blueView = [[UIView alloc] initWithFrame:frame];
        [blueView setClipsToBounds:YES];
        [blueView setBackgroundColor:[UIColor blueColor]];
        [blueView.layer setCornerRadius:6.0];
        blueView.alpha = 0.3;
        [self addSubview:blueView];
    }
    else if(tap.state == 3)
    {
        [[self.subviews lastObject] removeFromSuperview];
        if (answer == no + 1)
        {
           [[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Good",@"Quiz - right answer") message:NSLocalizedString(@"You're rewarded!",@"You're rewarded!") delegate:NULL cancelButtonTitle:NSLocalizedString(@"OK",@"OK")otherButtonTitles:nil]show];
            [parent performSelector:@selector(backForOK)];
        }
        else
        {
            tryAgain --;
            if (tryAgain <= 0)
            {
                UIAlertView *a = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Wrong",@"Quiz - wrong answer") message:NSLocalizedString(@"Please, watch the ad again",@"quiz was wrong") delegate:self cancelButtonTitle:NSLocalizedString(@"OK",@"OK") otherButtonTitles:nil];
                a.tag = 1;
                [a show];
            }
            else {
                [[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Wrong",@"Quiz - wrong answer") message:NSLocalizedString(@"You have one more chance",@"Quiz - wrong answer") delegate:NULL cancelButtonTitle:NSLocalizedString(@"OK",@"OK") otherButtonTitles:nil]show];
            }
                
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1)
        [self replay];
}

- (void)replay
{
    [parent performSelector:@selector(backForReplay)];
   
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
