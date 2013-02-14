//
//  ADListViewController.m
//  adlatte
//
//  Created by Tae Han Kim on 13. 2. 4..
//  Copyright (c) 2013년 AdLatte. All rights reserved.
//

#import "ADListViewController.h"
#import "AdDetailInfo.h"
#import "ShowAdvDetailViewController.h"
#import "ADEventViewController.h"

@implementation ADListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title = NSLocalizedString(@"LIST", @"1st tab");

        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:self.title image:nil tag:0];
        [[self tabBarItem] setFinishedSelectedImage:[UIImage imageNamed:@"list_on_80_54.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"list_off_80_54.png"]];

        self.refreshControl = (id)[[ISRefreshControl alloc] init];
        [self.refreshControl addTarget:self
                                action:@selector(refresh)
                      forControlEvents:UIControlEventValueChanged];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    DEF_TITLE_NAVI_ITEM;

    DEF_BACK_NAVI_ITEM;

    UIBarButtonItem *setItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"range_button.png"] landscapeImagePhone:nil style:UIBarButtonItemStyleBordered target:self action:@selector(selectRange)];
    self.navigationItem.rightBarButtonItem = setItem;

    adListArray = [[NSMutableArray alloc] initWithCapacity:30];

    pickerFirstItems = @[NSLocalizedString(@"All", @"Range item 1-1"),
                        NSLocalizedString(@"New", @"Range item 1-2"),
                        NSLocalizedString(@"Watched", @"Range item 1-3")];
    pickerSecItems = @[NSLocalizedString(@"Most Recent", @"Range item 2-1"),
                        NSLocalizedString(@"Top Points", @"Range item 2-2")];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(advDetailDownCompleted:) name:MSG_AdDetailInfo  object:nil];

    // TESTING ~~~~~~~~~~~~~~~~~~~~~
    [adListArray setArray:[NSArray arrayWithObjects:@(0),@(0),@(0),@(0),@(0),nil]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refresh
{
    int64_t delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){        
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
    });
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // TESTING ~~
    if( [(NSNumber*)(adListArray[indexPath.row]) isEqualToNumber:@(1)])
    {
//        UILabel *inL = [(ADListCell*)[tableView cellForRowAtIndexPath:indexPath] infoText];
        return 85+80+ [self infoLabelHeightHeight:@"The running shose superstore\nBlablabla adsjk a;sdjkfh ;kdsh lhkf aks fadkhj"];
    }

    return 85.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [adListArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"adCell";
    ADListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    // Configure the cell...
    if( nil == cell ){
        cell = [[ADListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.delegate = self;
    }
    [cell dataInit];

    // TESTING ~~
    if( [(NSNumber*)(adListArray[indexPath.row]) isEqualToNumber:@(1)])
        [cell openActionPannelWithInfoHeight:[self infoLabelHeightHeight:@"The running shose superstore\nBlablabla adsjk a;sdjkfh ;kdsh lhkf aks fadkhj"]];
    else
        [cell closeActionPannelWithAnimation:NO];

    return cell;
}

- (UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static UIView *headerView1, *headerView2;

    switch (section) {
        case 0:
            // Section Header view
            if( nil == headerView1) {
                headerView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 22)];
                [headerView1 setBackgroundColor:[UIColor colorWithPatternImage:IMN(@"notice_bar_320_22.png")]];
                UILabel *headLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 310, 22)];
                [headLabel setFont:[UIFont fontWithName:@"Arial-ItalicMT" size:11]];
                [headLabel setTextColor:HCOLOR(0x82, 0x64, 2)];
                [headLabel setBackgroundColor:[UIColor clearColor]];
                [headerView1 addSubview:headLabel];
                [headLabel setText:NSLocalizedString(@"Congraturations! You are on your way to being...", @"AdList 1st Header comment")];
            }
            return headerView1;
            break;

        case 2:
            if( nil == headerView2) {
                headerView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 22)];
                [headerView2 setBackgroundColor:[UIColor colorWithPatternImage:IMN(@"notice_bar_320_22.png")]];
                UILabel *headLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 310, 22)];
                [headLabel setFont:[UIFont fontWithName:@"Arial-ItalicMT" size:11]];
                [headLabel setTextColor:HCOLOR(0x82, 0x64, 2)];
                [headLabel setBackgroundColor:[UIColor clearColor]];
                [headerView2 addSubview:headLabel];
                [headLabel setText:NSLocalizedString(@"Sorry! ...", @"AdList 3rd Header comment")];
            }
            return headerView2;
            break;

        default:
            break;
    }
    return nil;
}

// only for 1st and 3rd header.
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if( 0 == section || 2 == section )
        return 22.0;

    return 0;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // close previous cell
    [(ADListCell*)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:lastSelectedIndex inSection:0]] closeActionPannelWithAnimation:YES];

    ADListCell *selectedCell = (ADListCell*)[tableView cellForRowAtIndexPath:indexPath];
    [selectedCell setSelected:NO animated:YES];

    // TESTING ~~~~~~~~~~~~~~~~~
    [adListArray setArray:[NSArray arrayWithObjects:@(0),@(0),@(0),@(0),@(0),nil]];
    if( lastSelectedIndex != indexPath.row )
    {
        [adListArray setObject:@(1) atIndexedSubscript:indexPath.row];

        [selectedCell openActionPannelWithInfoHeight:[self infoLabelHeightHeight:@"The running shose superstore\nBlablabla adsjk a;sdjkfh ;kdsh lhkf aks fadkhj"] ];
        lastSelectedIndex = indexPath.row;
    }
    else
    {
        lastSelectedIndex = 999;
    }
    [tableView beginUpdates];
    [tableView endUpdates];

    [tableView scrollRectToVisible:selectedCell.frame animated:YES];
}

// 광고 상세 정보의 설명 텍스트 라벨 높이를 구한다.
- (CGFloat) infoLabelHeightHeight:(NSString*)infoLabelTxt
{
    UILabel *infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 13, 268, 100)];
    [infoLabel setFont:[UIFont systemFontOfSize:12]];
    [infoLabel setNumberOfLines:0];
    [infoLabel setLineBreakMode:NSLineBreakByWordWrapping];
    
    CGSize labelSize = [infoLabelTxt sizeWithFont:infoLabel.font
                                constrainedToSize:infoLabel.frame.size
                                    lineBreakMode:UILineBreakModeWordWrap];
    return labelSize.height;
}

#pragma mark - ADListCellDelegate Actions

// If Watch button is tapped, run this one.
- (void) touchWatchButton:(NSUInteger)index
{
    // TODO: download ad, receive the result, and go to viewer
    ;

    // TESTING ~~~~
//    [[[AdDetailInfo alloc] initForList:nil key:nil] startFileDownload];
    ADEventViewController *ae = [[ADEventViewController alloc] initWithStyle:UITableViewStylePlain];
    [self.navigationController pushViewController:ae animated:YES];
}

#pragma mark -

// Right navigation bar item's action
- (void) selectRange
{
    actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil
                                                    cancelButtonTitle:nil
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:nil];
    
    [actionSheet setActionSheetStyle:UIActionSheetStyleDefault];
    [actionSheet setBackgroundColor:[UIColor clearColor]];
    
    CGRect pickerFrame = CGRectMake(0, 40, 0, 0);
    
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:pickerFrame];
    pickerView.showsSelectionIndicator = YES;
    pickerView.dataSource = self;
    pickerView.delegate = self;

    [actionSheet addSubview:pickerView];

    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    [toolBar setItems:@[
     [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismissActionSheet)],
     [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
     [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(changeListRange:)]
     ]];
    [toolBar setBarStyle:UIBarStyleBlackOpaque];
    [toolBar setTranslucent:YES];
    [toolBar setOpaque:NO];
    [actionSheet addSubview:toolBar];

    // TODO:Previous selected items
    [pickerView selectRow:0 inComponent:0 animated:NO];
    [pickerView selectRow:0 inComponent:1 animated:NO];

    [actionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
    [actionSheet setBounds:CGRectMake(0, 0, 320, 485)];
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
}

- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if( 0 == component ) return pickerFirstItems.count;
    else return pickerSecItems.count;

    return 0;
}

- (NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *ret;

    switch (component) {
        case 0:
            ret = pickerFirstItems[row]; break;
        case 1:
            ret = pickerSecItems[row]; break;
        default:
            return nil;
    }

    return ret;
}


- (void) dismissActionSheet
{
    [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
}

- (void) changeListRange:(id)sender
{
    // TODO: something ..

    [self dismissActionSheet];
}

#pragma mark - AD Actions

- (void)advDetailDownCompleted:(NSNotification*)sender
{
    AdDetailInfo* ad = (AdDetailInfo*)sender.object;

    if (ad.downloadSucceeded == true)
    {
        ShowAdvDetailViewController* s = [[ShowAdvDetailViewController alloc]init];
        s.adv = ad;
        s.modalTransitionStyle=  UIModalTransitionStyleCrossDissolve;
        [self presentModalViewController:s animated:TRUE];
    }
    else
    {
        [[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Error",@"Error") message:NSLocalizedString(@"Advertisement download error\nTry again, please",@"Error msg") delegate:NULL cancelButtonTitle:NSLocalizedString(@"OK",@"OK") otherButtonTitles:nil] show];
    }
}

@end
