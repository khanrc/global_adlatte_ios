//
//  ADTutorialController.m
//  adlatte
//
//  Created by Tae Han Kim on 13. 2. 5..
//  Copyright (c) 2013년 Tae Han Kim. All rights reserved.
//

#import "ADTutorialController.h"
#import "ADGateViewController.h"

@implementation ADTutorialController

- (id)init
{
    self = [super init];
    CGFloat height = [UIScreen mainScreen].bounds.size.height;

    if (self) {
        [self.view setBackgroundColor:[UIColor blackColor]];

        self.view.backgroundColor = UIColor.blackColor;

        scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 460)];
        scroll.contentSize = CGSizeMake(320*4, 460);
        scroll.pagingEnabled = true;
        scroll.delegate = self;
        pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, height-95, 320, 9)];
        pageControl.numberOfPages = 4;
        [pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
        [pageControl setCurrentPageIndicatorTintColor:HCOLOR(255, 186, 28)];
        [pageControl setPageIndicatorTintColor:HCOLOR(196, 200, 206)];

        for( int i = 0; i < 4; i++ )
        {
            UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(i*320, 0, 320, 460)];
            [imgV setImage:[UIImage imageNamed:[NSString stringWithFormat:@"tutorial_%02d_bg_320_460.png",i+1]]];
            [scroll addSubview:imgV];
        }
        [self.view addSubview:scroll];
        [self.view addSubview:pageControl];

        startButton = [[UIButton alloc] initWithFrame:CGRectMake(11, height-70, 298, 44)];
        [startButton setBackgroundImage:[UIImage imageNamed:@"start_adlatte_button_298_44.png"] forState:UIControlStateNormal];
        [startButton setBackgroundImage:[UIImage imageNamed:@"start_adlatte_button_p_298_44.png"] forState:UIControlStateHighlighted];
        [startButton setTitle:NSLocalizedString(@"Start AD Latte",@"Start Button at Tutorial") forState:UIControlStateNormal];
        [startButton.titleLabel setTextColor:[UIColor whiteColor]];
        [startButton addTarget:self action:@selector(endTutorial) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:startButton];
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

#pragma mark - UIScrollView & PageControl

- (void)changePage:(id)sender
{
    _pageControlUsed = YES;
    CGFloat pageWidth = scroll.contentSize.width /pageControl.numberOfPages;
    CGFloat x = pageControl.currentPage * pageWidth;
    [scroll scrollRectToVisible:CGRectMake(x, 0, pageWidth, scroll.bounds.size.height) animated:YES];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    _pageControlUsed = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (!_pageControlUsed)
        pageControl.currentPage = lround(scroll.contentOffset.x /
                                          (scroll.contentSize.width / pageControl.numberOfPages));
}

#pragma mark -

- (void) endTutorial
{
    ADGateViewController *gateVC = [[ADGateViewController alloc] init];
    UINavigationController *loginNavi = [[UINavigationController alloc] initWithRootViewController:gateVC];

    [self presentViewController:loginNavi animated:YES completion:^{
        ;
    }];
}

@end
