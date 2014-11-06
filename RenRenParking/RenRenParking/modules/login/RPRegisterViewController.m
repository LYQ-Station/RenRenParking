//
//  RPRegisterViewController.m
//  RenRenParking
//
//  Created by LiYongQiang on 14/10/23.
//  Copyright (c) 2014年 CoderFly. All rights reserved.
//

#import "RPRegisterViewController.h"

@interface RPRegisterViewController ()

@property (weak, nonatomic) IBOutlet UITextField *tfMobile;
@property (weak, nonatomic) IBOutlet UITextField *tfVcode;
@property (weak, nonatomic) IBOutlet UITextField *tfCarNumber;
@property (weak, nonatomic) IBOutlet UITextField *tfPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;
@property (weak, nonatomic) IBOutlet UIButton *btnVcode;

@property (nonatomic, assign) UIScrollView *scrollView;

@end

@implementation RPRegisterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title = NSLocalizedString(@"注册新用户", nil);
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"取消", nil) target:self action:@selector(btnBackClick)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    self.scrollView = (UIScrollView *)self.view;
//    CGSize s = [UIScreen mainScreen].bounds.size;
//    _scrollView.frame = CGRectMake(0, 0, s.width, s.height);
//    _scrollView.contentSize = CGSizeMake(s.width, s.height);
    
    _btnVcode.backgroundColor = [UIColor colorWithRed:0.18f green:0.20f blue:0.25f alpha:1.0f];
    _btnVcode.titleLabel.font = FONT_NORMAL;
    [_btnVcode setTitleColor:COLOR_TEXT_GREEN forState:UIControlStateHighlighted];
    
    _btnSubmit.backgroundColor = COLOR_BTN_BG_DARK_GRAY;
    _btnSubmit.titleLabel.font = FONT_NORMAL;
    [_btnSubmit setTitleColor:COLOR_TEXT_GREEN forState:UIControlStateHighlighted];
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
