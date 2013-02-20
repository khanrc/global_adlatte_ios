//
//  ADDefHeader.h
//  adlatte
//
//  Created by Tae Han Kim on 13. 2. 5..
//  Copyright (c) 2013년 AdLatte. All rights reserved.
//

#ifndef adlatte_Header_h
#define adlatte_Header_h

#import "ISRefreshControl.h"
#import "UserContext.h"
#import "UIView+Position.h"


#define DEF_TITLE_NAVI_ITEM  self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"adlatte_title.png"]];

#define NSUD    [NSUserDefaults standardUserDefaults]
#define IMN(_n) [UIImage imageNamed:_n]

#define USERCONTEXT     [UserContext sharedUserContext]

#define START_WAIT_VIEW     [USERCONTEXT startWaitView:0]
#define STOP_WAIT_VIEW      [USERCONTEXT stopWaitView]

#define DEF_BACK_NAVI_ITEM   UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];\
    [backItem setTitleTextAttributes:@{UITextAttributeTextColor:[UIColor whiteColor], UITextAttributeTextShadowColor:[UIColor blackColor]} forState:UIControlStateNormal]; \
    [backItem setTitle:NSLocalizedString(@"back",@"back navi item")]; \
    [backItem setTintColor:[UIColor blackColor]]; \
    self.navigationItem.backBarButtonItem = backItem

#define DEF_TITLE(_s_)      UILabel *tLbl = [[UILabel alloc] initWithFrame:CGRectZero]; \
    tLbl.backgroundColor = [UIColor clearColor];\
    tLbl.font = [UIFont boldSystemFontOfSize:20.0];\
    tLbl.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];\
    tLbl.textColor = [UIColor yellowColor];\
    self.navigationItem.titleView = tLbl;\
    tLbl.text = _s_;\
    [tLbl sizeToFit]

#define HCOLOR(_r,_g,_b)    [UIColor colorWithRed:_r/255.0 green:_g/255.0 blue:_b/255.0 alpha:1.0]

#define CSIGN        @"$"

// ---- from Global.h

#define _logFrame(NSString, CGRect) NSLog(@"%@ : %f %f %f %f", NSString, CGRect.origin.x, CGRect.origin.y, CGRect.size.width, CGRect.size.height);
#define _screenHeight [UIScreen mainScreen].bounds.size.height
#define is5() (_screenHeight > 500)
#define _fity(y) (y+(_screenHeight-480))

NSString *_fitImageName(NSString *str);
void _addShadow(UILabel *l, UIColor *shadowColor, CGSize shadowOffset);
UIButton *_makeButton(NSString *bgImgName, NSString *title, UIColor *titleColor, int x, int y, id target, SEL sel);
UIButton *_makeButtonWithHL(NSString *bgImgName, NSString *bgHLimgName, NSString *title, UIColor *titleColor, int x, int y, id target, SEL sel);
UIImageView *_makeImageView(NSString *imgName, int x, int y);
UILabel *_makeShortLabel(NSString *text, int x, int y, int fontSize, UIColor *fontColor, BOOL isBold);
UILabel *_makeLongLabel(NSString *text, int x, int y, int width, int fontSize, UIColor *fontColor);
UIImageView *_makeTextFieldWithBack(NSString *backName, UITextField *__strong *txtFld, int x, int y, int space, int fontSize, UIColor *fontColor, NSString *placeholder);

UIView *_findFirstResponder(UIView *view);


// Simple Alert View
#define NOTI(_m_)   [[[UIAlertView alloc] initWithTitle:@"Notice" message:_m_ delegate:nil cancelButtonTitle:@"Confirm" otherButtonTitles:nil] show]


#endif
