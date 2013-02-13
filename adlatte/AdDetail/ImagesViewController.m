//
//  ImagesViewController.m
//  adlatteGlobalCore
//
//  Created by 수아 강 on 12. 8. 20..
//  Copyright (c) 2012년 서울대학교. All rights reserved.
//

#import "ImagesViewController.h"
#import "QuestionView.h"
#import "ShowAdvDetailViewController.h"

@interface ImagesViewController ()
{
    UIScrollView* scrollView;
    UIPageControl* pageControl;
    NSMutableArray* pageViews;
    QuestionView* questionView;
    NSInteger pageCount;
}
@end

@implementation ImagesViewController
@synthesize images, parent, adv;

- (void)loadView
{
    [super loadView];
    self.view.backgroundColor = UIColor.blackColor;
    
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 480, 320)];
    scrollView.pagingEnabled = true;
    scrollView.delegate = self;
    scrollView.backgroundColor = UIColor.blackColor;

    [self.view addSubview:scrollView];

    pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 300, 340, 20)];
    [pageControl addTarget:self action:@selector(pageChangeValue:) forControlEvents:UIControlEventValueChanged]; 
    [self.view addSubview:pageControl];
    
    pageCount = images.count + 1;
    // Set up the page control
    pageControl.numberOfPages = pageCount;
    pageControl.currentPage = 0;

    [scrollView setContentSize:CGSizeMake(pageCount * 480, 0)];

    pageViews = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < pageCount; ++i) {
        [pageViews addObject:[NSNull null]];
    }

    questionView = [[QuestionView alloc]initWithFrame:CGRectMake(0, 0, 480, 320)];
    [questionView createView:adv];
    questionView.parent = self;
    [self loadVisiblePages];

}

#pragma mark - UIScrollViewDelegate

//페이지 컨트롤 값이 변경될때, 스크롤뷰 위치 설정
- (void) pageChangeValue:(id)sender {
    UIPageControl *pControl = (UIPageControl *) sender;
    [scrollView setContentOffset:CGPointMake(pControl.currentPage*480, 0) animated:YES];
    [self loadVisiblePages];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // Load the pages which are now on screen
    [self loadVisiblePages];
}

- (void)loadVisiblePages {
    // First, determine which page is currently visible
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger page = (NSInteger)floor((scrollView.contentOffset.x * 2.0f + pageWidth) / (pageWidth * 2.0f));
    
    // Update the page control
    pageControl.currentPage = page;
    
    // Work out which pages we want to load
    NSInteger firstPage = page - 1;
    NSInteger lastPage = page + 1;
    
    // Purge anything before the first page
    for (NSInteger i=0; i<firstPage; i++) {
        [self purgePage:i];
    }
    for (NSInteger i=firstPage; i<=lastPage; i++) {
        [self loadPage:i];
    }
    for (NSInteger i=lastPage+1; i<pageCount; i++) {
        [self purgePage:i];
    }
    
 
}



- (void)loadPage:(NSInteger)page {
    if (page < 0 || page >= pageCount) {
        // If it's outside the range of what we have to display, then do nothing
        return;
    }
    
    // Load an individual page, first seeing if we've already loaded it
    UIView *pageView = [pageViews objectAtIndex:page];
    if ((NSNull*)pageView == [NSNull null]) 
    {
        CGRect frame = scrollView.bounds;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0.0f;
        frame.size.width= 480;
        frame.size.height = 320;

        if (page < images.count)
        {
            UIWebView* newPageView = [[UIWebView alloc ]initWithFrame:CGRectMake(0, 0, 480, 320)];
            [pageViews replaceObjectAtIndex:page withObject:newPageView];
            [scrollView addSubview:newPageView];
            newPageView.scalesPageToFit = YES;
            newPageView.backgroundColor = UIColor.blackColor;
            newPageView.frame = frame;

            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                NSData* data = [NSData dataWithContentsOfFile:[images objectAtIndex:page]];
//                dispatch_async(dispatch_get_main_queue(), ^{
                    [newPageView loadData:data MIMEType:@"image/png" textEncodingName:NULL baseURL:NULL];
  //              });
            });
        }
        else {
            questionView.frame = frame;
            [scrollView addSubview:questionView];
            [pageViews replaceObjectAtIndex:page withObject:questionView];
        }
    }
}


- (void)purgePage:(NSInteger)page {
    if (page < 0 || page >= pageCount) {
        // If it's outside the range of what we have to display, then do nothing
        return;
    }
    
    // Remove a page from the scroll view and reset the container array
    UIView *pageView = [pageViews objectAtIndex:page];
    if ((NSNull*)pageView != [NSNull null]) {
        [pageView removeFromSuperview];
        [pageViews replaceObjectAtIndex:page withObject:[NSNull null]];
    }
}

- (void)backForOK
{
    [parent questionSolved];
    [pageViews removeAllObjects];
    pageViews = NULL;
}

- (void)backForReplay
{
    [parent showMovie];
    
    [pageViews removeAllObjects];
    [self.view removeFromSuperview];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

@end
