//
//  ADWISHVController.h
//  adlatte
//
//  Created by Tae Han Kim on 13. 2. 15..
//  Copyright (c) 2013년 AdLatte. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADWISHVController : UIViewController <UITextFieldDelegate,UIPickerViewDelegate, UIPickerViewDataSource>
{
    UITextField *addField1, *addField2;
    UITextField *nameField, *townField;
    UILabel     *state;
    UITextField *contNumField;
    UITextField *emailField;

    NSUInteger  selectedPicker;
    NSMutableArray     *pickerFirstItems;
    UIActionSheet *actionSheet;
}

@end
