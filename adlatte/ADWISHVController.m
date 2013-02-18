//
//  ADWISHVController.m
//  adlatte
//
//  Created by Tae Han Kim on 13. 2. 15..
//  Copyright (c) 2013년 AdLatte. All rights reserved.
//

#import "ADWISHVController.h"

#define WISH_TF(_f,_y,_p)            _f = [[UITextField alloc] initWithFrame:CGRectMake(25,_y,270,20)]; \
[_f setPlaceholder:_p]; \
[_f setFont:[UIFont systemFontOfSize:15]]; \
[_f setDelegate:self]; \
[self.view addSubview:_f]


@implementation ADWISHVController

- (id)init
{
    self = [super init];
    if (self) {
        self.title = NSLocalizedString(@"LATTE STORE", @"3rd tab");
        DEF_TITLE( self.title );

        self.view = [[UIScrollView alloc] initWithFrame:self.view.bounds];
//        [(UIScrollView*)(self.view) setContent ]
        [self.view setBackgroundColor:HCOLOR(247, 248, 249)];
        
        UIImageView *hb = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 10)];
        [hb setImage:IMN(@"bgtop_shadow_320_10.png")];
        [self.view addSubview:hb];

        UILabel *info = [[UILabel alloc] initWithFrame:CGRectMake(21, 31, 280, 50)];
        [info setBackgroundColor:self.view.backgroundColor];
        [info setFont:[UIFont systemFontOfSize:12]];
        [info setTextColor:HCOLOR(93, 93, 93)];
        [info setShadowColor:[UIColor whiteColor]];
        [info setShadowOffset:CGSizeMake(0.8, 0.8)];
        [info setNumberOfLines:0];
        [info setText:NSLocalizedString(@"WISH gift cards takes 6~8 days for delivery.\nYour information will be used only for delivery purposes. ", @"WISH giftcard info text")];
        [info sizeToFit];
        [self.view addSubview:info];

        UIImageView *b1 = [[UIImageView alloc] initWithFrame:CGRectMake(18, 86, 284, 132)];
        [b1 setImage:IMN(@"wish_giftcard_table01_284_132.png")];
        [self.view addSubview:b1];
        UIImageView *b2 = [[UIImageView alloc] initWithFrame:CGRectMake(18, 236, 284, 33)];
        [b2 setImage:IMN(@"wish_giftcard_table02_284_33.png")];
        [self.view addSubview:b2];
        UIImageView *b3 = [[UIImageView alloc] initWithFrame:CGRectMake(18, 277, 284, 66)];
        [b3 setImage:IMN(@"wish_giftcard_table03_284_66.png")];
        [self.view addSubview:b3];

        UIButton *comboBtn = [[UIButton alloc] initWithFrame:CGRectMake(272, 239, 27, 27)];
        [comboBtn setBackgroundImage:IMN(@"login_down_button_27_27.png") forState:UIControlStateNormal];
        [comboBtn setBackgroundImage:IMN(@"login_down_button_p_27_27.png") forState:UIControlStateHighlighted];
        [comboBtn addTarget:self action:@selector(comboAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:comboBtn];

        state = [[UILabel alloc] initWithFrame:CGRectMake(25, 239, 230, 27)];
        [state setText:NSLocalizedString(@"state", @"WISH state combo box")];
        [state setFont:[UIFont systemFontOfSize:15]];
        [state setTextColor:[UIColor grayColor]];
        [self.view addSubview:state];

        WISH_TF(nameField,92,NSLocalizedString(@"name", @"WISH name box"));

        WISH_TF(addField2,92+33,NSLocalizedString(@"address line two", @"WISH address2 box"));

        WISH_TF(townField,92+66,NSLocalizedString(@"town/suburb", @"WISH town address box"));

        WISH_TF(addField1,92+99,NSLocalizedString(@"address line one", @"WISH address2 box"));

        WISH_TF(contNumField,283,NSLocalizedString(@"contact number", @"WISH contact number box"));

        WISH_TF(emailField,316,NSLocalizedString(@"email address", @"WISH email box"));
        [emailField setKeyboardType:UIKeyboardTypeEmailAddress];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIBarButtonItem *setItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Submit", @"Store redeem") style:UIBarButtonItemStyleBordered target:self action:@selector(redeemSubmit)];

    pickerFirstItems = [[NSMutableArray alloc] initWithCapacity:50];
    for( NSUInteger i = 0 ; i < 20; i++ ){
        // TODO: States picker list
        [pickerFirstItems addObject:@"California"];
    }
    self.navigationItem.rightBarButtonItem = setItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

- (void) textFieldDidBeginEditing:(UITextField *)textField
{
    CGFloat yp = textField.frame.origin.y;

    [UIView animateWithDuration:0.3 animations:^{
        [(UIScrollView*)(self.view) setContentOffset:CGPointMake(0, yp-50)];
    }];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [UIView animateWithDuration:0.3 animations:^{
        [(UIScrollView*)(self.view) setContentOffset:CGPointMake(0, 0)];
    }];

    [textField resignFirstResponder];
    return NO;
}

#pragma mark -

- (void) comboAction:(id) sender
{
    actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil
                                     cancelButtonTitle:nil
                                destructiveButtonTitle:nil
                                     otherButtonTitles:nil];
    
    [actionSheet setActionSheetStyle:UIActionSheetStyleDefault];
    [actionSheet setBackgroundColor:[UIColor clearColor]];

    CGRect pickerFrame = CGRectMake(0, 40, 0, 0);

    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:pickerFrame];
    pickerView.showsSelectionIndicator = YES;
    pickerView.dataSource = self;
    pickerView.delegate = self;
    
    [actionSheet addSubview:pickerView];
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    [toolBar setItems:@[
     [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismissActionSheet)],
     [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
     [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(changeState:)]
     ]];
    [toolBar setBarStyle:UIBarStyleBlackOpaque];
    [toolBar setTranslucent:YES];
    [toolBar setOpaque:NO];
    [actionSheet addSubview:toolBar];
    
    // TODO:Previous selected items
    [pickerView selectRow:0 inComponent:0 animated:NO];
    
    [actionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
    [actionSheet setBounds:CGRectMake(0, 0, 320, 485)];

}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    selectedPicker = row;
}

- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return pickerFirstItems.count;
}

- (NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return pickerFirstItems[row];
}

- (void) dismissActionSheet
{
    [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
}

- (void) changeState:(id) sender
{
    [self dismissActionSheet];

    // TODO: something...
    [state setTextColor:[UIColor blackColor]];
    [state setText: pickerFirstItems[selectedPicker]];
}

#pragma mark -

- (void) redeemSubmit
{
    // TODO: something...
}

@end
