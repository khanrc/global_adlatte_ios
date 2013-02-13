//
//  ADListViewController.h
//  adlatte
//
//  Created by Tae Han Kim on 13. 2. 4..
//  Copyright (c) 2013년 AdLatte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ADListCell.h"

@interface ADListViewController : UITableViewController <UIPickerViewDelegate, UIPickerViewDataSource, ADListCellDelegate>
{
    NSMutableArray  *adListArray;
    NSUInteger      lastSelectedIndex;

    NSArray     *pickerFirstItems, *pickerSecItems;
    UIActionSheet *actionSheet;
}

@end
