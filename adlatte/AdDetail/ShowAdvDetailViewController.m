//
//  ShowAdvDetailViewController.m
//  adlatteGlobalCore
//
//  Created by 수아 강 on 12. 8. 20..
//  Copyright (c) 2012년 서울대학교. All rights reserved.
//

#import "ShowAdvDetailViewController.h"
#import "MovieViewController.h"
#import "ImagesViewController.h"
//#import "RequestManager2.h"

@interface ShowAdvDetailViewController ()

@end

@implementation ShowAdvDetailViewController
@synthesize adv;

- (void)loadView
{
    [super loadView];
    [[UIApplication sharedApplication] setStatusBarHidden:true];
    [self showMovie];
//    [self performSelector:@selector(showMovie) withObject:NULL afterDelay:0.01];
}

- (void)showMovie
{
    if ([adv hasMovie])
    {
        NSString* movie = [adv pathForMovie];
        MovieViewController* m = [[MovieViewController alloc] init];
        m.parent = self;
        m.path = movie;
        [self.view addSubview:m.view];
    }
    else {
        [self showImage];
    }
}

- (void)questionSolved
{
//    [RequestManager questionSolved:[adv valueForKey:@"idx"]];
    [self back];
}

- (void)showImage
{
    NSArray* images = [adv advImagesPaths];
    if (images)
    {
        ImagesViewController* m = [[ImagesViewController alloc] init];
        m.adv = adv;
        m.parent = self;
        m.images = images;
        [self.view addSubview:m.view];
    }
    else
        [self back];
}

- (void)back
{
    [[UIApplication sharedApplication] setStatusBarHidden:false];
    [self dismissModalViewControllerAnimated:TRUE];
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

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}
@end
