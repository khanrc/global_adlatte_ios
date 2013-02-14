//
//  ADStoreViewController.m
//  adlatte
//
//  Created by Tae Han Kim on 13. 2. 4..
//  Copyright (c) 2013년 AdLatte. All rights reserved.
//

#import "ADStoreViewController.h"
#import "ADStoreCell.h"
#import "ADPurchaseViewController.h"

#define SBAR_H      34.0


@implementation ADStoreViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title = NSLocalizedString(@"LATTE STORE", @"3rd tab");

        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:self.title image:nil tag:0];
        [[self tabBarItem] setFinishedSelectedImage:[UIImage imageNamed:@"store_on_80_54.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"store_off_80_54.png"]];

        DEF_TITLE( self.title );

        self.refreshControl = (id)[[ISRefreshControl alloc] init];
        [self.refreshControl addTarget:self
                                action:@selector(refresh)
                      forControlEvents:UIControlEventValueChanged];

        searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, SBAR_H)];
        [searchBar setTintColor:[UIColor blackColor]];
        [searchBar setDelegate:self];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    DEF_BACK_NAVI_ITEM;
    storeListArray = [[NSMutableArray alloc] initWithCapacity:30];

    // TESTING ~~~~~~~~~~~~~~~~~~~~~
    [storeListArray setArray:@[@"A",@"B",@"C",@"D",@"E"]];
}

- (void) viewDidAppear:(BOOL)animated
{
    [self.tableView setContentOffset:CGPointMake(0, 33)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) refresh
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
    if( 0 == indexPath.row )  // search bar
        return SBAR_H;

    return 85.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    int rowCount;
    if( isFiltered )
        rowCount = [filteredListArray count];
    else
        rowCount = [storeListArray count];

    rowCount++;
    return rowCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"storeCell";
    ADStoreCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if( 0 == indexPath.row ) {
        UITableViewCell *scell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"scarchCell"];
        [scell addSubview:searchBar];
        return scell;
    }
    // Configure the cell...
    if( nil == cell ){
        cell = [[ADStoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    if( isFiltered )
        [cell dataInit];   // TODO: something with filteredListArray ...
    else
        [cell dataInit];   // TODO: something  ...

    return cell;
}

- (UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static UIView *headerView1;
    // Section Header view
    if( nil == headerView1) {
        headerView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 22)];
        [headerView1 setBackgroundColor:[UIColor colorWithPatternImage:IMN(@"notice_bar_320_22.png")]];
        UILabel *headLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 310, 22)];
        [headLabel setFont:[UIFont fontWithName:@"Arial-ItalicMT" size:11]];
        [headLabel setTextColor:HCOLOR(158, 159, 161)];
        [headLabel setBackgroundColor:[UIColor clearColor]];
        [headLabel setTextAlignment:NSTextAlignmentCenter];
        [headerView1 addSubview:headLabel];
        [headLabel setText:NSLocalizedString(@"The Current Latte Point : $ 40.00", @"Latte store point comment")];
    }
    return headerView1;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 22.0;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO:
    ADPurchaseViewController *pvc = [[ADPurchaseViewController alloc] init];
    [self.navigationController pushViewController:pvc animated:YES];
}

#pragma mark - Search Bar Delegate

-(void)searchBar:(UISearchBar*)searchBar textDidChange:(NSString*)text
{
    if(text.length == 0)
    {
        isFiltered = FALSE;
    }
    else
    {
        isFiltered = true;
        filteredListArray = [[NSMutableArray alloc] init];
        
        for (ADStoreCell* item in storeListArray)
        {
//            NSRange nameRange = [food.name rangeOfString:text options:NSCaseInsensitiveSearch];
//            NSRange descriptionRange = [food.description rangeOfString:text options:NSCaseInsensitiveSearch];
//            if(nameRange.location != NSNotFound || descriptionRange.location != NSNotFound)
//            {
                [filteredListArray addObject:item];
//            }
        }
    }
    
    [self.tableView reloadData];
}

@end
