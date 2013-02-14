//
//  ADMyEditViewController.h
//  adlatte
//
//  Created by Tae Han Kim on 13. 2. 14..
//  Copyright (c) 2013년 AdLatte. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADMyEditViewController : UIViewController <UITextFieldDelegate>
{
    UIImageView *profileImg;
    UIView      *infoBackView;
    UITextField *textField;
    UILabel     *counterLabel;
}

@end
