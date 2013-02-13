//
//  MovieViewController.m
//  adlatteGlobalCore
//
//  Created by 수아 강 on 12. 8. 20..
//  Copyright (c) 2012년 서울대학교. All rights reserved.
//
#import <MediaPlayer/MediaPlayer.h>
#import "MovieViewController.h"
#import "ShowAdvDetailViewController.h"

@interface MovieViewController ()
{
    UIProgressView* progress;
    NSTimer* timer;
    UIView* controllView;
    UIButton* playBtn;
}
@property(nonatomic,retain) MPMoviePlayerController *movie; 
@end

@implementation MovieViewController
@synthesize path, parent, movie;

- (void)loadView
{
    [super loadView];
    
    
    self.view.backgroundColor = UIColor.blackColor;
    
    // Register to receive a notification when the movie has finished playing. 
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(moviePlayBackDidFinish:) 
                                                 name:MPMoviePlayerPlaybackDidFinishNotification 
                                               object:nil];
    
  
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(moviePlayerLoadStateChanged:) 
                                                 name:MPMoviePlayerLoadStateDidChangeNotification 
                                               object:nil];

    timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(check) userInfo:NULL repeats:true];
    self.movie = [self createMovie];
    [self.view addSubview:movie.view];


}

- (void)check
{
    if (movie.playbackState == MPMoviePlaybackStatePlaying)
    {
        [playBtn setImage:[UIImage imageNamed:@"pause_button_54_66.png"] forState:UIControlStateNormal];
        progress.progress = movie.currentPlaybackTime/movie.duration;
    }
    else
        [playBtn setImage:[UIImage imageNamed:@"play_button_54_66.png"] forState:UIControlStateNormal];
        
    
}

- (void)clear
{
    [[NSNotificationCenter  defaultCenter] removeObserver:self name:MPMoviePlayerLoadStateDidChangeNotification object:nil];
    
    [[NSNotificationCenter  defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];

    [timer invalidate];
    timer = NULL;
    
    [self.movie stop];
    [self.movie.view removeFromSuperview];
    self.movie = NULL;
    
    NSLog(@"Movie Cleared");
}

- (void)back
{
    [parent back];
    [self.view removeFromSuperview];
    [self clear];
}

- (MPMoviePlayerController*)createMovie
{
    
    MPMoviePlayerController* retMovie = [[MPMoviePlayerController alloc]  initWithContentURL:[NSURL fileURLWithPath:path]];
    retMovie.controlStyle = MPMovieControlStyleNone;
    retMovie.scalingMode = MPMovieScalingModeAspectFit;
    retMovie.fullscreen = true;
    retMovie.view.frame = CGRectMake(0, 0, 480, 320);
    retMovie.shouldAutoplay = true;
    

    progress = [[UIProgressView alloc]initWithFrame:CGRectMake(66, 40, 480-70, 10)];

    controllView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 480, 320)];
    controllView.backgroundColor = [UIColor clearColor];
    UIImageView *barView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 480, 38)];
    [barView setImage:IMN(@"ad_view_bar_bg_480_38.png")];
    [controllView addSubview:barView];
    playBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 54, 66)];
    [playBtn setBackgroundImage:IMN(@"pause_button_54_66.png") forState:UIControlStateNormal];
    [playBtn addTarget:self action:@selector(playMovie:) forControlEvents:UIControlEventTouchUpInside];
    [controllView addSubview:playBtn];
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(447, 6, 25, 25)];
    [backBtn setBackgroundImage:IMN(@"ad_view_back_button_25_25.png") forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [controllView addSubview:backBtn];

    [controllView addSubview:progress];
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(63, 10, 300, 17)];
    [lbl setBackgroundColor:[UIColor clearColor]];
    [lbl setTextColor:[UIColor whiteColor]];
    [lbl setFont:[UIFont systemFontOfSize:15.0]];
    [lbl setText:NSLocalizedString(@"watch carefully for question", @"movie AD msg")];
    [controllView addSubview:lbl];
    [retMovie.view addSubview:controllView];

    UIView* emptyView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, 480, 320)];
    emptyView.backgroundColor = [UIColor clearColor];
    [emptyView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickScreen)]];
    emptyView.userInteractionEnabled = true;
    [retMovie.view addSubview:emptyView];
    
    
    if ([retMovie respondsToSelector:@selector(loadState)]) 
    {
        [retMovie prepareToPlay];
        [self performSelector:@selector(clickScreen) withObject:NULL afterDelay:1];
    }  
    
    return retMovie;
}

- (void)playMovie:(UIButton*)sender
{
    if (movie.playbackState == MPMoviePlaybackStatePlaying)
    {
        [movie pause];
        [sender setImage:[UIImage imageNamed:@"play_button_54_66.png"] forState:UIControlStateNormal];
    }
    else {
        if (movie.playbackState == MPMoviePlaybackStateStopped)
            movie.currentPlaybackTime = 0;
        [movie play];
        [sender setImage:[UIImage imageNamed:@"pause_button_54_66.png"] forState:UIControlStateNormal];
    }
}

- (void)clickScreen
{
    [UIView animateWithDuration:0.3 animations:^{controllView.alpha = (controllView.alpha == 1)?0:1;}];

 //   controllView.hidden = !controllView.hidden;
    
}

- (void) moviePlayerLoadStateChanged:(NSNotification*)notification 
{
    // Unless state is unknown, start playback
    NSLog(@"state change : %d",[notification.object loadState]);
}

- (void)backForGoNext
{
    [self.view removeFromSuperview];
    [self clear];
}

- (void) moviePlayBackDidFinish:(NSNotification*)notification 
{
    [self performSelector:@selector(backForGoNext) withObject:NULL afterDelay:1];
    [parent showImage];
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
