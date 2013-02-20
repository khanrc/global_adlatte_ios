//
//  ADAnnouncementsViewController.m
//  adlatte
//
//  Created by 차준범 on 13. 2. 19..
//  Copyright (c) 2013년 AdLatte. All rights reserved.
//

#import "ADAnnouncementsViewController.h"
#import "ADExpandTableViewController.h"

@interface ADAnnouncementsViewController ()
{
    NSMutableArray *testData;
    ADExpandTableViewController *table;
}
@end

@implementation ADAnnouncementsViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        testData = [[NSMutableArray alloc] init];
        for(int i=0; i<10; i++){
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                 @"## Notice title", @"title",
                                 @"sdaopfjsfsfwsdfjopfjopdsafjsafjdsoapfjdsfjosfjodpsafjpsodafjspfjopwejfeowpfjeopfjajewfpjaaojooapwjwpopajpdsfajd;pjfop;jopjopsopposdjfposfjwpfpo", @"contents",
                                 @"2012/04/05", @"date",
                                 nil];
            [testData addObject:dic];
        }
        
        table = [[ADExpandTableViewController alloc] initWithData:testData];
        table.view.frame = CGRectMake(0, 0, 320, _fity(362+93));
        [self.view addSubview:table.view];
//        self.tabBarController.tabBar.hidden=YES;
        
        self.title = NSLocalizedString(@"Announcements", @"Announcements");
        DEF_TITLE( self.title );
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
