//
//  ADSignup1ViewController.m
//  adlatte
//
//  Created by Tae Han Kim on 13. 2. 5..
//  Copyright (c) 2013년 Tae Han Kim. All rights reserved.
//

#import "ADSignup1ViewController.h"

@interface ADSignup1ViewController ()
{
    UIScrollView *backView;
    UITextField *emailTF, *pwTF, *nicknameTF, *referredTF, *genderTF, *birthTF;
    
    int gender;
    UIPickerView *genderPicker;
    UIDatePicker *datePicker;
    BOOL showKeyboard;
    
    UIToolbar* tool;
}
@end

@implementation ADSignup1ViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
//        _logFrame(@"self.view.frame", self.view.frame);
        backView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.height-44)];
        backView.backgroundColor = [UIColor clearColor];
        [self.view setBackgroundColor:HCOLOR(216, 216, 216)]; // iPhont 5 에서 하단이 비어보이지 않도록 색 채움.
        [self.view addSubview:backView];
        [backView addSubview:_makeImageView(@"login1_bg_320_416.png", 0, 0)];
        UIImageView *emailBack, *pwBack, *nicknameBack, *referredBack, *genderBack, *birthBack;

//        UITextField *t = &emailTF;
        emailBack = _makeTextFieldWithBack(@"login_name_284_33.png", &emailTF, 18, 29, 14, 14, [UIColor blackColor], NSLocalizedString(@"email address", @"signup - email address"));
        pwBack = _makeTextFieldWithBack(@"login_name_284_33.png", &pwTF, 18, 69, 14, 14, [UIColor blackColor], NSLocalizedString(@"password", @"signup - password"));
        nicknameBack = _makeTextFieldWithBack(@"login_name_284_33.png", &nicknameTF, 18, 109, 14, 14, [UIColor blackColor], NSLocalizedString(@"choose a nickname", @"signup - choose a nickname"));
        referredBack = _makeTextFieldWithBack(@"login_name_284_33.png", &referredTF, 18, 149, 14, 14, [UIColor blackColor], NSLocalizedString(@"referred? enter nickname here", @"signup - referred? enter nickname here"));
        genderBack = _makeTextFieldWithBack(@"login_name_284_33.png", &genderTF, 18, 189, 14, 14, [UIColor blackColor], NSLocalizedString(@"gender", @"signup - gender"));
        birthBack = _makeTextFieldWithBack(@"login_name_284_33.png", &birthTF, 18, 229, 14, 14, [UIColor blackColor], NSLocalizedString(@"date of birth", @"signup - date of birth"));
        [genderBack addSubview:_makeButtonWithHL(@"login_down_button_27_27.png", @"login_down_button_p_27_27.png", nil, nil, 272-18, 3, self, @selector(genderClk))];
        [birthBack addSubview:_makeButtonWithHL(@"login_down_button_27_27.png", @"login_down_button_p_27_27.png", nil, nil, 272-18, 3, self, @selector(birthClk))];
        [backView addSubview:emailBack];
        [backView addSubview:pwBack];
        [backView addSubview:nicknameBack];
        [backView addSubview:referredBack];
        [backView addSubview:genderBack];
        [backView addSubview:birthBack];
        emailTF.delegate = pwTF.delegate = nicknameTF.delegate = referredTF.delegate = genderTF.delegate = birthTF.delegate = self;
        
        
        UIButton *btn;
        [backView addSubview:btn=_makeButton(@"login2_terms_button_82_14.png", nil, nil, 53, _fity(314), self, @selector(policyClk:))];
        btn.tag = 0;
        [backView addSubview:btn=_makeButton(@"login2_privacy_button_90_14.png", nil, nil, 172, _fity(314), self, @selector(policyClk:))];
        btn.tag = 1;
        
        UILabel *label;
        [backView addSubview:label=_makeShortLabel(@"By signing up, you are agreeing to our", 0, _fity(292), 12, [UIColor colorWithHex:0x5d5d5d], NO)];
        _addShadow(label, [UIColor whiteColor], CGSizeMake(0.8, 0.8));
        label.x = (320 - label.width)/2;
        [backView addSubview:label=_makeShortLabel(@"and", 0, _fity(312), 12, [UIColor colorWithHex:0x5d5d5d], NO)];
        _addShadow(label, [UIColor whiteColor], CGSizeMake(0.8, 0.8));
        label.x = (320 - label.width)/2-5;
        
        [backView addSubview:btn=_makeButtonWithHL(@"login_button_284_35.png", @"login_button_p_284_35.png", NSLocalizedString(@"Sign Up", @"Sign Up"), [UIColor colorWithHex:0xd4a300], 18, _fity(351), self, @selector(signupClk))];
        _addShadow([btn titleLabel], [UIColor whiteColor], CGSizeMake(0.8, 0.8));
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardDidShow:)
                                                     name:UIKeyboardDidShowNotification object:nil];
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillBeHidden:)
                                                     name:UIKeyboardWillHideNotification object:nil];
        
        tool = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
        tool.barStyle = UIBarStyleBlack;
        tool.translucent = true;
        UIBarButtonItem *ok = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(ok)];
        UIBarButtonItem* flex= [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:NULL action:NULL];
        tool.items = [NSArray arrayWithObjects: flex,ok, nil];
        
        backView.scrollEnabled = YES;
        backView.contentSize = CGSizeMake(320, backView.height);
    }
    return self;
}
-(void)genderClk
{
    [genderTF becomeFirstResponder];
}
-(void)birthClk
{
    [birthTF becomeFirstResponder];
}
- (void)keyboardDidShow:(NSNotification*)aNotification
{
    if (showKeyboard)
        return;
    showKeyboard = true;
    
    CGRect frame = backView.frame;
    backView.tag = (int)frame.size.height;
    frame.size.height = _fity(200);
    backView.frame = frame;
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    if (showKeyboard == false)
        return;
    showKeyboard = false;
    
    CGPoint pt = backView.contentOffset;
    CGRect frame = backView.frame;
    frame.size.height = backView.tag;
    backView.frame = frame;
    backView.contentOffset = pt;
    
    [backView setContentOffset:CGPointMake(0, 0) animated:true];
}
-(void)ok
{
//    NSLog(@"touch");
    UIView *v = _findFirstResponder(self.view);
    [v resignFirstResponder];
}
-(void)policyClk:(UIButton *)sender
{
    NSLog(@"%d", sender.tag);
}
-(void)signupClk
{
    NSLog(@"signup");

    // API test
    // gender 필드는 BOOL 값으로, 남자는 YES 여자는 NO 입니다.
    // API 에서 요구되는 생일의 형태는 YYYY-mm-dd 입니다.
    [NetInterface signupEmail:emailTF.text
                     password:pwTF.text
                     nickname:nicknameTF.text
                       gender:(1==gender)
                     birthday:birthTF.text  // ex : @"1973-06-15"
                   onComplete:^(NSDictionary *dics)
    {
        NSLog(@"%@",dics);
    } onError:^(NSError *err) {
        NSLog(@"err %@",err);
    }];
}


#pragma mark --- TextField Delegate ---
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //NEXT버튼 눌렸을때 처리
    NSArray* arr = [NSArray arrayWithObjects:emailTF,
                    pwTF,
                    nicknameTF,
                    referredTF,
                    genderTF,
                    birthTF,
                    nil];
    
    for(int i = 0; i<arr.count - 1;i++)
        if (textField == [arr objectAtIndex:i])
        {
            [[arr objectAtIndex:i + 1] becomeFirstResponder];
            [self scrollToTextField:[arr objectAtIndex:i]];
            return YES;
        }
    
    [textField resignFirstResponder];
    return YES;
}

- (void)scrollToTextField:(UITextField *)textField
{
    UIView* view = textField;
    while ([[view.superview class] isSubclassOfClass:[UIScrollView class]] == false)
        view = view.superview;
    // 이게 뭔짓하는거냐면
    // textview가 scrollview에 바로 붙어있는게 아니니까 거기까지 쭉 올라가는거임.
    // 보통은, TF의 Back인 이미지뷰의 상위뷰가 scrollView.
    [backView setContentOffset:CGPointMake(0, MAX(0, view.y-70)) animated:true];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == birthTF)
        return false;
    if (textField == genderTF)
        return false;
    return true;
}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    //    [self scrollToTextField:textField];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    textField.returnKeyType = UIReturnKeyNext;
    textField.inputAccessoryView = tool;
    [self scrollToTextField:textField];
    return TRUE;
}
//////////////////////////////////////////////////////////////////


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

@end
