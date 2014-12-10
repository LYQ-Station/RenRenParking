//
//  RPNewPasswordViewController.m
//  RenRenParking
//
//  Created by LiYongQiang on 14/10/24.
//  Copyright (c) 2014年 CoderFly. All rights reserved.
//

#import "RPNewPasswordViewController.h"
#import "RPLoginModel.h"

@interface RPNewPasswordViewController ()

@property (weak, nonatomic) IBOutlet UITextField *tfNewPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;

@property (nonatomic, strong) RPLoginModel *model;

@end

@implementation RPNewPasswordViewController

- (void)dealloc
{
    [_model cancel];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title = NSLocalizedString(@"忘记密码", nil);
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"取消", nil) target:self action:@selector(btnBackClick)];
        
        self.model = [RPLoginModel model];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupTheme];
    
    _btnSubmit.backgroundColor = COLOR_BTN_BG_DARK_GRAY;
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

#pragma mark -

- (void)doResetPwd
{
    MBProgressHUD *hud = [MBProgressHUD showLoadingMessage:@"重置密码中..." toView:nil];
    
    [_model doResetNewPassword:@{@"user_token":_token,@"password":_tfNewPassword.text}
                      complete:^(NSError *error) {
                          [hud hide:NO];
                          
                          if (error)
                          {
                              [MBProgressHUD showError:error.localizedDescription toView:nil];
                              return ;
                          }
                          
                          [self btnBackClick];
                      }];
}

@end
