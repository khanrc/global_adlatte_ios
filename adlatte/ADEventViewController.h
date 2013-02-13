//
//  ADEventViewController.h
//  adlatte
//
//  Created by Tae Han Kim on 13. 2. 7..
//  Copyright (c) 2013년 AdLatte. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADEventViewController : UITableViewController <UITextFieldDelegate>
{
    UIProgressView *progView;
    UILabel     *infoLabel, *balanceLabel;

    UITextField *fakeField, *textField;
}
@end
