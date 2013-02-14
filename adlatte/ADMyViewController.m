//
//  ADMyViewController.m
//  adlatte
//
//  Created by Tae Han Kim on 13. 2. 4..
//  Copyright (c) 2013년 AdLatte. All rights reserved.
//

#import "ADMyViewController.h"
#import "ADMyEditViewController.h"


@implementation ADMyViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title = NSLocalizedString(@"ME", @"2nd tab");

        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:self.title image:nil tag:0];
        [[self tabBarItem] setFinishedSelectedImage:[UIImage imageNamed:@"me_on_80_54.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"me_off_80_54.png"]];

        self.tableView.backgroundView = nil;
        [self.tableView setBackgroundColor:HCOLOR(208, 208, 208)];
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }

    DEF_TITLE( @"Nickname" );
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    DEF_BACK_NAVI_ITEM;
    
    UIBarButtonItem *setItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editMyInfos)];
    [setItem setTitleTextAttributes:@{UITextAttributeTextColor:[UIColor whiteColor], UITextAttributeTextShadowColor:[UIColor blackColor]} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = setItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5; //TODO:
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;

    switch (indexPath.row ) {
        case 0:
            cell = [tableView dequeueReusableCellWithIdentifier:@"myPCell"];
            if( nil == cell){
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myPCell"];
                [cell.contentView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"me_bg_320_167.png"]]];
                 UIImageView *pv = [[UIImageView alloc] initWithFrame:CGRectMake(113, 19, 94, 99)];
                 [pv setImage:[UIImage imageNamed:@"me_profile_imgbox_border_94_99.png"]];
                [cell.contentView addSubview:pv];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        {
            UILabel *money = [[UILabel alloc] initWithFrame:CGRectMake(0, 132, 320, 14)];
            [money setBackgroundColor:[UIColor clearColor]];
            [cell.contentView addSubview:money];
            [money setTextColor:HCOLOR(246, 226, 0)];
            [money setTextAlignment:NSTextAlignmentCenter];
            [money setText:[NSString stringWithFormat:NSLocalizedString(@"I have earned $%d", @"below my profile pic."),20]];
        }
            return cell;

        case 1:
            cell = [tableView dequeueReusableCellWithIdentifier:@"myInfo"];
            if( nil == cell){
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myPCell"];
                [cell.contentView setBackgroundColor:HCOLOR(237, 237, 237)];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;

        case 2:
            cell = [tableView dequeueReusableCellWithIdentifier:@"gap"];
            if( nil == cell ){
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"gap"];
                [cell.contentView setBackgroundColor:HCOLOR(208, 208, 208)];
                UIImageView *pv = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 320, 3)];
                [pv setImage:[UIImage imageNamed:@"me_shadow_320_3.png"]];
                [cell.contentView addSubview:pv];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;

        default:
            cell = [tableView dequeueReusableCellWithIdentifier:@"selectCell"];
            if( nil == cell ){
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"selectCell"];
                [cell.contentView setBackgroundColor:HCOLOR(208, 208, 208)];
                UIImageView *pv = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 300, 44)];
                [pv setImage:[UIImage imageNamed:[NSString stringWithFormat:@"me_table_0%d_300_44.png",indexPath.row-2]]];
                [cell.contentView addSubview:pv];
            }
            break;
    }
    
    // Configure the cell...
    cell.selectionStyle = UITableViewCellSelectionStyleGray;

    UIImageView *ti = [[UIImageView alloc] initWithFrame:CGRectMake(19, 9, 26, 26)];
    UILabel     *tl = [[UILabel alloc] initWithFrame:CGRectMake(67, 0, 200, 44)];
    [tl setBackgroundColor:[UIColor clearColor]];
    [tl setFont:[UIFont systemFontOfSize:15]];
    [tl setTextColor:HCOLOR(120, 120, 120)];
    [tl setShadowColor:[UIColor whiteColor]];
    [tl setShadowOffset:CGSizeMake(0.8, 0.8)];
    if( 3 == indexPath.row ){
        [ti setImage:[UIImage imageNamed:@"me_ads_icon_26_26.png"]];
        [tl setText:NSLocalizedString(@"My Ads", @"at ME screen 1st cell")];
    } else {
        [ti setImage:[UIImage imageNamed:@"me_share_friends_icon_26_26.png"]];
        [tl setText:NSLocalizedString(@"Share with friends", @"at ME screen 2nd cell")];
    }
    [cell.contentView addSubview:ti];
    [cell.contentView addSubview:tl];

    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            return 167.0;

        case 1:
            return 80; // and +alpha

        case 2:
            return 13; // just gap.

        default:
            break;
    }
    return 44;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController    *vc;

    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];

    if( 3 == indexPath.row )            // My Ads
    {
//        vc = [];
    } else if ( 4 == indexPath.row )    // Share with friends
    {
        
    }
//    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -

- (void) editMyInfos
{
    ADMyEditViewController *edv = [[ADMyEditViewController alloc] init];
    [self.navigationController pushViewController:edv animated:YES];
}

@end
