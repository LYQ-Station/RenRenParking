//
//  RPFeedbackViewController.m
//  RenRenParking
//
//  Created by LiYongQiang on 14/10/26.
//  Copyright (c) 2014年 CoderFly. All rights reserved.
//

#import "RPFeedbackViewController.h"

@interface RPFeedbackViewController () <UITextFieldDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *tvContent;
@property (weak, nonatomic) IBOutlet UITextField *tfContact;
@property (weak, nonatomic) IBOutlet UIButton *btnTag0;
@property (weak, nonatomic) IBOutlet UIButton *btnTag1;
@property (weak, nonatomic) IBOutlet UIButton *btnTag2;
@property (weak, nonatomic) IBOutlet UIButton *btnTag3;
@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;
@property (nonatomic, assign) UIScrollView *scrollView;

@property (nonatomic, strong) NSMutableDictionary *labelsDict;

@end

@implementation RPFeedbackViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title = NSLocalizedString(@"意见反馈", nil);
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonThemeItem:UIBarButtonThemeItemBack target:self action:@selector(btnBackClick)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupTheme];
    
    self.scrollView = (UIScrollView *)self.view;
    
    _tvContent.font = FONT_NORMAL;
    _tvContent.delegate = self;
    
    _tfContact.font = FONT_NORMAL;
    _tfContact.delegate = self;
    _tfContact.background = [[UIImage imageNamed:@"feedback-input-bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 20, 0, 20)];
    _tfContact.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    _tfContact.leftViewMode = UITextFieldViewModeAlways;
    
    _btnTag0.titleLabel.font = FONT_NORMAL;
    [_btnTag0 setTitleColor:COLOR_TEXT_GRAY forState:UIControlStateNormal];
    [_btnTag0 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_btnTag0 setBackgroundImage:[[UIImage imageNamed:@"border-btn-bg-gray"] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20)] forState:UIControlStateNormal];
    [_btnTag0 setBackgroundImage:[[UIImage imageNamed:@"btn-bg-gray"] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20)] forState:UIControlStateSelected];
    
    _btnTag1.titleLabel.font = FONT_NORMAL;
    [_btnTag1 setTitleColor:COLOR_TEXT_GRAY forState:UIControlStateNormal];
    [_btnTag1 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_btnTag1 setBackgroundImage:[[UIImage imageNamed:@"border-btn-bg-gray"] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20)] forState:UIControlStateNormal];
    [_btnTag1 setBackgroundImage:[[UIImage imageNamed:@"btn-bg-gray"] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20)] forState:UIControlStateSelected];
    
    _btnTag2.titleLabel.font = FONT_NORMAL;
    [_btnTag2 setTitleColor:COLOR_TEXT_GRAY forState:UIControlStateNormal];
    [_btnTag2 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_btnTag2 setBackgroundImage:[[UIImage imageNamed:@"border-btn-bg-gray"] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20)] forState:UIControlStateNormal];
    [_btnTag2 setBackgroundImage:[[UIImage imageNamed:@"btn-bg-gray"] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20)] forState:UIControlStateSelected];
    
    _btnTag3.titleLabel.font = FONT_NORMAL;
    [_btnTag3 setTitleColor:COLOR_TEXT_GRAY forState:UIControlStateNormal];
    [_btnTag3 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_btnTag3 setBackgroundImage:[[UIImage imageNamed:@"border-btn-bg-gray"] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20)] forState:UIControlStateNormal];
    [_btnTag3 setBackgroundImage:[[UIImage imageNamed:@"btn-bg-gray"] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20)] forState:UIControlStateSelected];
    
    _btnSubmit.backgroundColor = COLOR_BTN_BG_GREEN;
    _btnSubmit.titleLabel.font = FONT_NORMAL;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    UITapGestureRecognizer *g = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapGesture:)];
    [self.view addGestureRecognizer:g];
    
    [UIView animateWithDuration:0.25f animations:^{
        _scrollView.contentInset = UIEdgeInsetsMake(-230.0f, 0.0f, 0.0f, 0.0f);
    }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.25f animations:^{
        _scrollView.contentInset = UIEdgeInsetsZero;
    }];
}

#pragma mark -

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    UITapGestureRecognizer *g = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapGesture:)];
    [self.view addGestureRecognizer:g];
    
    return YES;
}

#pragma mark -

- (void)btnBackClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnSuggestionClick:(UIButton *)sender
{
    if (sender.selected)
    {
        sender.selected = NO;
        
        if (101 == sender.tag)
        {
            [_labelsDict removeObjectForKey:@"101"];
        }
        else if (102 == sender.tag)
        {
            [_labelsDict removeObjectForKey:@"102"];
        }
        else if (103 == sender.tag)
        {
            [_labelsDict removeObjectForKey:@"103"];
        }
        else if (104 == sender.tag)
        {
            [_labelsDict removeObjectForKey:@"104"];
        }
    }
    else
    {
        sender.selected = YES;
        
        if (101 == sender.tag)
        {
            [_labelsDict setObject:@"101" forKey:@"地址错误"];
        }
        else if (102 == sender.tag)
        {
            [_labelsDict setObject:@"102" forKey:@"找不到地点"];
        }
        else if (103 == sender.tag)
        {
            [_labelsDict setObject:@"103" forKey:@"软件不稳定"];
        }
        else if (104 == sender.tag)
        {
            [_labelsDict setObject:@"104" forKey:@"改进建议"];
        }
    }
}

- (void)onTapGesture:(UITapGestureRecognizer *)g
{
    [self.view removeGestureRecognizer:g];
    
    [_tvContent resignFirstResponder];
    [_tfContact resignFirstResponder];
}

@end
