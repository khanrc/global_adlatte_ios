//
//  UserContext.m
//
//  Created by Bladekim on 10. 4. 13..
//  Copyright 2010 HotCons. All rights reserved.
//

#import "UserContext.h"
#import <QuartzCore/QuartzCore.h>


@implementation UserContext

//
// singleton stuff
//
static UserContext *_sharedUserContext = nil;

+ (UserContext *)sharedUserContext
{
	@synchronized(self)
	{
		if (!_sharedUserContext) {
			_sharedUserContext = [[self alloc] initWithDefault];
		}
		return _sharedUserContext;
	}
	// to avoid compiler warning
	return nil;
}

+ (id)alloc
{
	@synchronized(self)
	{
		NSAssert(_sharedUserContext == nil, @"Attempted to allocate a second instance of a singleton.");
		_sharedUserContext = [super alloc];
		return _sharedUserContext;
	}
	// to avoid compiler warning
	return nil;
}


- (id) initWithDefault
{
	self = [super init];
	if (self != nil) {
        //
        if( ![[NSUserDefaults standardUserDefaults] boolForKey:@"firstBootup"] ){
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstBootup"];
            /// ... and more...
        }
    }
	return self;
}

#pragma mark - Wating View

- (void) startWaitView: (NSInteger) yDeltaPos
{
	if( nil == waitV ) {
		UIWindow* mainWindow = [[UIApplication sharedApplication] keyWindow];
		waitV = [[WaitView alloc] initWithFrame:CGRectMake(mainWindow.frame.size.width/2-40, (mainWindow.frame.size.height/2)-40+yDeltaPos,80,80)];

        [waitV setAlpha:0.0];
        [waitV setTransform:CGAffineTransformMakeScale(1.5, 1.5)];
		[mainWindow addSubview:waitV];
        // wait view 가 나타날 때 화면 조작이 불가능하게 함.
///        if( nil != waitV )
///            [[UIApplication sharedApplication].keyWindow setUserInteractionEnabled:NO];
	}

    [UIView animateWithDuration:0.4 animations:^(void) {
        [waitV setTransform:CGAffineTransformMakeScale(1.0, 1.0)];
        [waitV setAlpha:1.0];
    } completion:^(BOOL finished) {
    }];
}

- (void) stopWaitView
{
	if( waitV ){
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        [UIView animateWithDuration:0.3 animations:^(void) {
            [waitV setAlpha:0.0];
            [waitV setTransform:CGAffineTransformMakeScale(1.5, 1.5)];
        } completion:^(BOOL finished) {
            [waitV removeFromSuperview];
            // 화면 조작을 다시 가능하게 풀어야 한다.
///            [[UIApplication sharedApplication].keyWindow setUserInteractionEnabled:YES];
            waitV = nil;
        }];
//		waitV = nil;
	}
}

#pragma mark -

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
