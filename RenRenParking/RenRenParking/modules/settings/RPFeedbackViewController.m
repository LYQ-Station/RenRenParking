//
//  RPFeedbackViewController.m
//  RenRenParking
//
//  Created by LiYongQiang on 14/10/26.
//  Copyright (c) 2014年 CoderFly. All rights reserved.
//

#import "RPFeedbackViewController.h"

@interface RPFeedbackViewController ()

@property (weak, nonatomic) IBOutlet UITextView *tvContent;
@property (weak, nonatomic) IBOutlet UITextField *tfContact;
@property (weak, nonatomic) IBOutlet UIButton *btnTag0;
@property (weak, nonatomic) IBOutlet UIButton *btnTag1;
@property (weak, nonatomic) IBOutlet UIButton *btnTag2;
@property (weak, nonatomic) IBOutlet UIButton *btnTag3;
@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;

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
    
    _tvContent.font = FONT_NORMAL;
    _tfContact.font = FONT_NORMAL;
    
    _btnTag0.titleLabel.font = FONT_NORMAL;
    [_btnTag0 setTitleColor:COLOR_TEXT_GRAY forState:UIControlStateNormal];
    [_btnTag0 setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [_btnTag0 setBackgroundImage:[[UIImage imageNamed:@"border-btn-bg-gray"] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20)] forState:UIControlStateNormal];
    [_btnTag0 setBackgroundImage:[[UIImage imageNamed:@"btn-bg-gray"] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20)] forState:UIControlStateSelected];
    
    _btnTag1.titleLabel.font = FONT_NORMAL;
    [_btnTag1 setTitleColor:COLOR_TEXT_GRAY forState:UIControlStateNormal];
    [_btnTag1 setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [_btnTag1 setBackgroundImage:[[UIImage imageNamed:@"border-btn-bg-gray"] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20)] forState:UIControlStateNormal];
    [_btnTag1 setBackgroundImage:[[UIImage imageNamed:@"btn-bg-gray"] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20)] forState:UIControlStateSelected];
    
    _btnTag2.titleLabel.font = FONT_NORMAL;
    [_btnTag2 setTitleColor:COLOR_TEXT_GRAY forState:UIControlStateNormal];
    [_btnTag2 setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [_btnTag2 setBackgroundImage:[[UIImage imageNamed:@"border-btn-bg-gray"] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20)] forState:UIControlStateNormal];
    [_btnTag2 setBackgroundImage:[[UIImage imageNamed:@"btn-bg-gray"] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20)] forState:UIControlStateSelected];
    
    _btnTag3.titleLabel.font = FONT_NORMAL;
    [_btnTag3 setTitleColor:COLOR_TEXT_GRAY forState:UIControlStateNormal];
    [_btnTag3 setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
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

- (void)btnBackClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
