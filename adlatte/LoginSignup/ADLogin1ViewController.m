//
//  ADLogin1ViewController.m
//  adlatte
//
//  Created by Tae Han Kim on 13. 2. 5..
//  Copyright (c) 2013년 Tae Han Kim. All rights reserved.
//

#import "ADLogin1ViewController.h"
#import "ADAppDelegate.h"

@interface ADLogin1ViewController ()
{
    UITextField *emailTF, *pwTF;
}
@end

@implementation ADLogin1ViewController

- (id)init
{
    self = [super init];
    if (self) {
//        [self.view setBackgroundColor:[UIColor whiteColor]];
//        _logFrame(@"loginview", self.view.frame);
//        NSLog(@"%f", _screenHeight);
        [self.view addSubview:_makeImageView(_fitImageName(@"login6_bg_320_416.png"), 0, 0)];

        [self.view addSubview:_makeImageView(@"login6_bgbox_296_228.png", 12, _fity(177))];
        [self.view addSubview:_makeImageView(@"login_adlatte_285_46.png", 18, _fity(235))];
        [self.view addSubview:_makeImageView(@"login_adlatte2_285_119.png", 18, _fity(281))];

        UILabel *l = _makeShortLabel(NSLocalizedString(@"Log in with Adlatte", @"login - Log in with Adlatte"), 85, _fity(250), 13, [UIColor colorWithHex:0x5a5a5a], NO);
        _addShadow(l, [UIColor whiteColor], CGSizeMake(0.8, 0.8));
        [self.view addSubview:l];
        
        emailTF = [[UITextField alloc] initWithFrame:CGRectMake(43, _fity(296), 220, 15)];
        emailTF.placeholder = NSLocalizedString(@"email address or nickname", @"login - E-mail");
        emailTF.font = [UIFont systemFontOfSize:13];
        emailTF.keyboardType = UIKeyboardTypeEmailAddress;
        pwTF = [[UITextField alloc] initWithFrame:CGRectMake(43, _fity(328), 220, 15)];
        pwTF.placeholder = NSLocalizedString(@"Password", @"login - Password");
        pwTF.font = [UIFont systemFontOfSize:13];
        pwTF.secureTextEntry = YES;
        [self.view addSubview:emailTF];
        [self.view addSubview:pwTF];

        UIButton *loginBtn = _makeButtonWithHL(@"startlogin_button_234_35.png", @"startlogin_button_p_234_35.png", NSLocalizedString(@"Log In", @"login button"), HCOLOR(212, 163, 0), 24, _fity(360), self, @selector(loginAction));
        [self.view addSubview:loginBtn];
    
    
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(showKeyboard:)
                                                     name:UIKeyboardWillShowNotification object:nil];
        

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(hideKeyboard:)
                                                     name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [emailTF resignFirstResponder];
    [pwTF resignFirstResponder];
}
-(void)showKeyboard:(NSNotification*)notif
{
    NSDictionary *dic = notif.userInfo;
    NSValue *v = [dic objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect rc = [v CGRectValue]; // keyboard rect
    float dur = [[dic objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    CGRect frame = self.view.frame;
    frame.origin.y = frame.origin.y - rc.size.height;
//    NSLog(@"%f", dur);
    
    [UIView animateWithDuration:dur animations:^{
        self.view.frame = frame;
    }];
}
- (void)hideKeyboard:(NSNotification*)notif
{
    NSDictionary *dic = notif.userInfo;
    float dur = [[dic objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    CGRect frame = [[UIScreen mainScreen] bounds];
    
    [UIView animateWithDuration:dur animations:^{
        self.view.frame = frame;
    }];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    DEF_TITLE_NAVI_ITEM;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    NSLog(@"disappear");
}

#pragma mark -

- (void) loginAction
{
    // API test
    [NetInterface loginEmail:emailTF.text
                    password:pwTF.text
                  onComplete:^(NSDictionary *dics)
    {
        NSLog(@"%@",dics);

        [(ADAppDelegate*)[UIApplication sharedApplication].delegate setupBasicTabs];
        
        [self.navigationController dismissViewControllerAnimated:YES completion:^{
            ;
        }];
    } onError:^(NSError *err) {
        NSLog(@"err %@",err);
    }];
}

@end
