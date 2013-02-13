//
//  ADEventViewController.m
//  adlatte
//
//  Created by Tae Han Kim on 13. 2. 7..
//  Copyright (c) 2013년 AdLatte. All rights reserved.
//

#import "ADEventViewController.h"
#import "ADEventCmtCell.h"

@interface ADEventViewController ()

@end

#define TEST_E1 @"I will strengthen you and help you.\nI will uphold you"
#define TEST_B1 @"Total prize: $ 50,000\nBalance: $ 25,350\nReward: $ 1 x facebook friends(max 100)"

@implementation ADEventViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"Event", @"Event view title");
        
        self.tableView.backgroundView = nil;
        [self.tableView setBackgroundColor:HCOLOR(208, 208, 208)];
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }

    DEF_TITLE(self.title);

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    [self setHidesBottomBarWhenPushed:YES];
 
    UIBarButtonItem *setItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(goNext)];
    [setItem setTitleTextAttributes:@{UITextAttributeTextColor:[UIColor whiteColor], UITextAttributeTextShadowColor:[UIColor blackColor]} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = setItem;

    CGRect rectFake = CGRectZero;
    fakeField = [[UITextField alloc] initWithFrame:rectFake];
    [self.view addSubview:fakeField];

    UIView *av = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 0.0, 35.0)];
    av.backgroundColor = [UIColor darkGrayColor];
    CGRect rect = CGRectMake(8.0, 4.0, 253.0, 27.0);
    textField = [[UITextField alloc] initWithFrame:rect];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.font = [UIFont systemFontOfSize:15.0];
    textField.delegate = self;
    [av addSubview:textField];

    UIButton *send = [[UIButton alloc] initWithFrame:CGRectMake(263, 4, 51, 27)];
    [send setBackgroundImage:[UIImage imageNamed:@"ad_list_event_send_button_51_27.png"] forState:UIControlStateNormal];
    [send setBackgroundImage:[UIImage imageNamed:@"ad_list_event_send_button_p_51_27.png"] forState:UIControlStateHighlighted];
    [send setTitle:NSLocalizedString(@"Send", @"Send") forState:UIControlStateNormal];
    [send.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [send addTarget:self action:@selector(sendButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [av addSubview:send];
    
    fakeField.inputAccessoryView = av;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 4;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // event 내용이 나오는 셀. 내용에 따라 가변적 높이.
    if( 0 == indexPath.row ) {
        CGSize es = [TEST_E1 sizeWithFont:[UIFont systemFontOfSize:12]
                                 constrainedToSize:CGSizeMake(254,500)lineBreakMode:NSLineBreakByWordWrapping];
        CGSize bs = [TEST_B1 sizeWithFont:[UIFont systemFontOfSize:12]
                                 constrainedToSize:CGSizeMake(254,500)
                            lineBreakMode:NSLineBreakByWordWrapping];
        [infoLabel setFrame:CGRectMake(33, 14, 254, es.height)];
        [balanceLabel setFrame:CGRectMake(33, es.height+30, 254, bs.height)];

        NSLog(@"h: %f %f", es.height, bs.height);
        return 132 + es.height + bs.height;
    }

    // comments cell. 내용에 따라 가변적 높이.
    return 68; // TODO: calc
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cmtCell";
    UITableViewCell *cell;

    if( 0 == indexPath.row ) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"eventCell"];
        if( nil == cell ){
            cell = [self makeCellEventDescripton];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

        [infoLabel setText:TEST_E1];
        [balanceLabel setText:TEST_B1];
    }
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if( nil == cell ){
            cell = (UITableViewCell*)[[ADEventCmtCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        [(ADEventCmtCell*)cell setData];
    }
    
    return cell;
}

- (UIView*) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return fakeField.inputAccessoryView;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 35.0;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
//    [fakeField becomeFirstResponder];
}

#pragma mark -

// 목록 최상단의 이벤트 상세 정보 셀을 만드는 method
- (UITableViewCell*) makeCellEventDescripton
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"eventCell"];
    [cell setFrame:CGRectMake(0, 0, 320, 171)]; // temp.
    
    UIImageView *b1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 12)];
    [b1 setImage:IMN(@"slogan_Topper_320_12.png")];
    [cell.contentView addSubview:b1];
    
    UIImageView *b2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 12, 320, 88)];
    [b2 setImage:[IMN(@"slogan_middle_40_14.png") resizableImageWithCapInsets:UIEdgeInsetsMake(0, 20, 0, 20)]];
    [b2 setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [cell.contentView addSubview:b2];
    
    UIImageView *b3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, 320, 71)];
    [b3 setImage:IMN(@"slogan_bottom_320_71.png")];
    [b3 setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin];
    [cell.contentView addSubview:b3];
    
    progView = [[UIProgressView alloc] initWithFrame:CGRectMake(33, 171-87, 254, 8)];
    [progView setTrackImage:IMN(@"ad_list_slider_bar_268_8")];
    [progView setProgressImage:[IMN(@"ad_list_slider_bar_bl_8_8") resizableImageWithCapInsets:UIEdgeInsetsMake(0, 4, 0, 4)]];
    [progView setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin];
    [cell.contentView addSubview:progView];
    
    UIButton *shareBtn = [[UIButton alloc] initWithFrame:CGRectMake(18, cell.contentView.bounds.size.height-42, 284, 30)];
    [shareBtn setBackgroundImage:IMN(@"ad_list_event_share_button_284_30.png") forState:UIControlStateNormal];
    [shareBtn setBackgroundImage:IMN(@"ad_list_event_share_button_p_284_30.png") forState:UIControlStateHighlighted];
    [shareBtn setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin];
    [shareBtn setTitle:NSLocalizedString(@"Share", @"Share btn on Event view") forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(doShare) forControlEvents:UIControlEventTouchUpInside];
    [shareBtn.titleLabel setShadowColor:HCOLOR(0x42, 0x42, 0x42)];
    [shareBtn.titleLabel setShadowOffset:CGSizeMake(-0.8, -0.8)];
    [cell.contentView addSubview:shareBtn];

    infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(33, 14, 254, 50)];
    [infoLabel setNumberOfLines:10];
    [infoLabel setBackgroundColor:[UIColor clearColor]];
    [infoLabel setFont:[UIFont systemFontOfSize:12]];
    [infoLabel setTextColor:HCOLOR(60, 60, 60)];
    [infoLabel setShadowColor:[UIColor whiteColor]];
    [infoLabel setShadowOffset:CGSizeMake(0.8, 0.8)];
    [infoLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [cell.contentView addSubview:infoLabel];

    balanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(33, 65, 254, 48)];
    [balanceLabel setNumberOfLines:3];
    [balanceLabel setBackgroundColor:[UIColor clearColor]];
    [balanceLabel setFont:[UIFont systemFontOfSize:12]];
    [balanceLabel setTextColor:HCOLOR(122, 122, 122)];
    [balanceLabel setShadowOffset:CGSizeMake(0.8, 0.8)];
    [balanceLabel setShadowColor:[UIColor whiteColor]];
    [balanceLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [cell.contentView addSubview:balanceLabel];

    return cell;
}

- (void) textFieldDidEndEditing:(UITextField *)_textField
{
    [textField resignFirstResponder];
}

- (BOOL) textFieldShouldReturn:(UITextField *)_textField
{
    [textField resignFirstResponder];
    return NO;
}

- (void) sendButtonAction:(id) sender
{
    [textField resignFirstResponder];
}

@end
