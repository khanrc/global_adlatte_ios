//
//  ADMyShareViewController.m
//  adlatte
//
//  Created by Tae Han Kim on 13. 2. 14..
//  Copyright (c) 2013년 AdLatte. All rights reserved.
//

#import "ADMyShareViewController.h"

@interface ADMyShareViewController ()

@end

@implementation ADMyShareViewController

- (id)init
{
    self = [super init];
    if (self) {
        [self.view setBackgroundColor:HCOLOR(242, 242, 242)];

        UIButton *smsBtn = [[UIButton alloc] initWithFrame:CGRectMake(79, 190, 73, 73)];
        [smsBtn setBackgroundImage:IMN(@"sms_button_73_73.png") forState:UIControlStateNormal];
        [smsBtn addTarget:self action:@selector(smsAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:smsBtn];

        UIButton *mailBtn = [[UIButton alloc] initWithFrame:CGRectMake(168, 190, 73, 73)];
        [mailBtn setBackgroundImage:IMN(@"email_button_73_73.png") forState:UIControlStateNormal];
        [mailBtn addTarget:self action:@selector(emailAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:mailBtn];

        UILabel *head = [[UILabel alloc] initWithFrame:CGRectMake(0, 43, 320, 16)];
        [head setBackgroundColor:[UIColor clearColor]];
        [head setFont:[UIFont boldSystemFontOfSize:16.0]];
        [head setTextAlignment:NSTextAlignmentCenter];
        [head setTextColor:HCOLOR(39, 39, 39)];
        [self.view addSubview:head];

        UILabel *desc = [[UILabel alloc] initWithFrame:CGRectMake(30, 73, 260, 100)];
        [desc setBackgroundColor:[UIColor clearColor]];
        [desc setFont:[UIFont systemFontOfSize:12.0]];
        [desc setTextAlignment:NSTextAlignmentCenter];
        [desc setTextColor:HCOLOR(98, 98, 98)];
        [self.view addSubview:desc];

        [head setText:NSLocalizedString(@"Share with friends", @"at ME screen 2nd cell")];
        [desc setText:NSLocalizedString(@"Share AdLatte with friends!\nIf your friends sign-up and name you as their referrer, you will instantly earn Latte Points! The more friends you invite, the more you earn!", @"share with friends title")];
        [desc setNumberOfLines:0];
        [desc sizeToFit];
    }

    DEF_TITLE( @"Nickname" );
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

#pragma mark -

- (void) smsAction
{
    if( ![MFMessageComposeViewController canSendText] ) return;

    MFMessageComposeViewController *vController = [[MFMessageComposeViewController alloc] init];
    vController.body = @"[some text]";
    [vController setMessageComposeDelegate:self];
    [self presentViewController:vController animated:YES completion:^{
        ;
    }];
}

- (void) emailAction
{
    if( ![MFMailComposeViewController canSendMail] ) return;

    MFMailComposeViewController *vController = [[MFMailComposeViewController alloc] init];
    [vController setSubject:@"[some title]"];
    [vController setMessageBody:@"[some text]" isHTML:NO];
    [vController setMailComposeDelegate:self];
    [self presentViewController:vController animated:YES completion:^{
        ;
    }];
}

#pragma mark - Message Delegate

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
	switch (result) {
		case MessageComposeResultCancelled:
			NSLog(@"Cancelled");
			break;
		case MessageComposeResultFailed:
			NOTI(@"SMS Failed");
			break;
		case MessageComposeResultSent:
			break;

		default:
			break;
	}
    
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
	switch (result) {
		case MFMailComposeResultCancelled:
			NSLog(@"Cancelled");
			break;
		case MFMailComposeResultFailed:
			NOTI(@"Email Failed");
			break;
		case MFMailComposeResultSent:
			break;
        case MFMailComposeResultSaved:
            break;
		default:
			break;
	}

	[controller dismissViewControllerAnimated:YES completion:nil];
}

@end
