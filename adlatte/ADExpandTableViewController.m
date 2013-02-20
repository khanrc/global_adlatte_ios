//
//  ADExpandTableViewController.m
//  adlatte
//
//  Created by 차준범 on 13. 2. 19..
//  Copyright (c) 2013년 AdLatte. All rights reserved.
//

#import "ADExpandTableViewController.h"

@interface ADExpandTableViewController ()
{
    NSArray *listData;
    
    int selectedSection;
}
@end

@implementation ADExpandTableViewController

- (id)initWithData:(NSArray *)_data
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        // Custom initialization
        listData = _data;
        // title
        // contents
        // (date)
        
        selectedSection = -1;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return listData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(selectedSection == section){
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *dic = [listData objectAtIndex:indexPath.section];
    
    // Configure the cell...
    cell.backgroundView = [[UIView alloc] initWithFrame:cell.bounds];
    cell.backgroundView.backgroundColor = [UIColor grayColor];
    [cell addSubview:_makeImageView(@"announcements_arrow_16_16.png", 9, 12)];
    [cell addSubview:_makeLongLabel([dic objectForKey:@"contents"], 37, 14, 247, 12, [UIColor whiteColor])];
    
    
    return cell;
}


#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [listData objectAtIndex:indexPath.section];
    UILabel *t = _makeLongLabel([dic objectForKey:@"contents"], 37, 4, 247, 12, [UIColor whiteColor]);
    
    return t.height+28;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 55;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 55)];
    UIImageView *bg = _makeImageView(@"bar_bg_320_85.png", 0, 0);
    bg.height = 55;
    [header addSubview:bg];
    
    NSString *arrowName = (section == selectedSection)?@"announcements_up_14_10.png":@"announcements_down_14_10.png";
    [bg addSubview:_makeImageView(arrowName, 289, 22)];
    
    NSDictionary *dic = [listData objectAtIndex:section];
    UILabel *label = _makeShortLabel(dic[@"title"], 15, 20, 15, [UIColor colorWithHex:0x98999b], NO);
    _addShadow(label, [UIColor whiteColor], CGSizeMake(0.8, 0.8));
    [header addSubview:label];
    
    if(dic[@"date"]) // 날짜가 있으면
        [header addSubview:_makeShortLabel(dic[@"date"], 224, 22, 10, [UIColor colorWithHex:0x616264], NO)];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = header.bounds;
    btn.tag = section;
    [btn addTarget:self action:@selector(sectionClk:) forControlEvents:UIControlEventTouchUpInside];
    [header addSubview:btn];
    
    return header;
}

-(void)sectionClk:(UIButton *)sender
{
    if(selectedSection == sender.tag)
        selectedSection = -1;
    else
        selectedSection = sender.tag;
    [self.tableView reloadData];
}

@end
