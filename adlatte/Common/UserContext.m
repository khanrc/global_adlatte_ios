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

#include <stdio.h>

void _addShadow(UILabel *l, UIColor *shadowColor, CGSize shadowOffset)
{
    l.layer.shadowOpacity = 1.0;
    l.layer.shadowRadius = 0.0;
    l.layer.shadowColor = shadowColor.CGColor;
    l.layer.shadowOffset = shadowOffset;
}

NSString *_fitImageName(NSString *str)
{
    if(is5() == NO)
        return str;
    
    NSRange range;
    range.location = str.length-4;
    range.length = 4;
    NSString *ret =[str stringByReplacingCharactersInRange:range withString:@"-568h.png"];
    return ret;
}

UIView *_findFirstResponder(UIView *view)
{
    if([view isFirstResponder])
        return view;
    
    for(UIView *v in view.subviews){
        UIView *ret = _findFirstResponder(v);
        if(ret)
            return ret;
    }
    
    return nil;
}

//UITextField *_makeTextField(CGRect frame, )
UIImageView *_makeTextFieldWithBack(NSString *backName, UITextField *__strong *txtFld, int x, int y, int space, int fontSize, UIColor *fontColor, NSString *placeholder) // 이중포인터
{
    UIImageView *back = _makeImageView(backName, x, y);
    back.userInteractionEnabled = YES;
    *txtFld = [[UITextField alloc] initWithFrame:CGRectMake(space, (back.height-fontSize-3)/2-1, back.width-space*2, fontSize+3)];
    (*txtFld).font = [UIFont systemFontOfSize:fontSize];
    (*txtFld).textColor = fontColor;
    (*txtFld).placeholder = placeholder;
    [back addSubview:(*txtFld)];
    
    return back;
}
UIButton *_makeButton(NSString *bgImgName, NSString *title, UIColor *titleColor, int x, int y, id target, SEL sel)
{
    UIImage* img= [UIImage imageNamed:bgImgName];
    CGSize size = img.size;
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(x, y, size.width, size.height)];
    [btn setBackgroundImage:img forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}
UIButton *_makeButtonWithHL(NSString *bgImgName, NSString *bgHLimgName, NSString *title, UIColor *titleColor, int x, int y, id target, SEL sel)
{
    UIButton *btn = _makeButton(bgImgName, title, titleColor, x, y, target, sel);
    [btn setBackgroundImage:[UIImage imageNamed:bgHLimgName] forState:UIControlStateHighlighted];
    return btn;
}

UILabel *_makeShortLabel(NSString *text, int x, int y, int fontSize, UIColor *fontColor, BOOL isBold)
{ // 무조건 한줄짜리 라벨
    //    UIFont *font = [UIFont fontWithName:fontName size:fontSize];
    UIFont *font = (isBold)?[UIFont boldSystemFontOfSize:fontSize]:[UIFont systemFontOfSize:fontSize];
    CGSize textSize = [text sizeWithFont:font];
    UILabel *ret = [[UILabel alloc] initWithFrame:CGRectMake(x, y, textSize.width, textSize.height)];
    [ret setText:text];
    [ret setFont:font];
    [ret setTextColor:fontColor];
    [ret setBackgroundColor:[UIColor clearColor]];
    
    return ret;
}

UILabel *_makeLongLabel(NSString *text, int x, int y, int width, int fontSize, UIColor *fontColor)
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, 1)];
    label.text = text;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textColor = fontColor;
    label.backgroundColor = [UIColor clearColor];
    label.numberOfLines = 0;
    label.height = [label textRectForBounds:CGRectMake(0, 0, width, CGFLOAT_MAX) limitedToNumberOfLines:0].size.height;
    
    return label;
}

UIImageView *_makeImageView(NSString *imgName, int x, int y)
{
    UIImage *img = [UIImage imageNamed:imgName];
    CGSize size = img.size;
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, size.width, size.height)];
    [imgView setImage:img];
    return imgView;
}
