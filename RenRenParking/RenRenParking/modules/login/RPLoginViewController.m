//
//  RPLoginViewController.m
//  RenRenParking
//
//  Created by LiYongQiang on 14/10/23.
//  Copyright (c) 2014年 CoderFly. All rights reserved.
//

#import "RPLoginViewController.h"
#import "RPFindPwdViewController.h"
#import "RPRegisterViewController.h"
#import "RPLoginModel.h"

@interface RPLoginViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *ivInputFields;
@property (weak, nonatomic) IBOutlet UITextField *tfMobile;
@property (weak, nonatomic) IBOutlet UITextField *tfPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;
@property (weak, nonatomic) IBOutlet UIButton *btnFindPwd;
@property (weak, nonatomic) IBOutlet UIButton *btnRegister;

@property (nonatomic, strong) void(^completeBlock)(id user, BOOL isCancelled);

@property (nonatomic, strong) RPLoginModel *model;

@end

@implementation RPLoginViewController

+ (UINavigationController *)navController:(id)delegate
{
    RPLoginViewController *c = [[RPLoginViewController alloc] initWithNibName:nil bundle:nil];
    c.delegate = delegate;
    
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:c];
    return nc;
}

+ (UINavigationController *)navControllerWithBlock:(void(^)(id user, BOOL isCancelled))block
{
    RPLoginViewController *c = [[RPLoginViewController alloc] initWithNibName:nil bundle:nil];
    c.completeBlock = block;
    
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:c];
    return nc;
}

- (void)dealloc
{
    [_model cancel];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonThemeItem:UIBarButtonThemeItemBack target:self action:@selector(btnBackClick)];
    
    [self setupLogoTheme];
    
    _btnSubmit.backgroundColor = COLOR_BTN_BG_GREEN;
    _btnSubmit.titleLabel.font = FONT_NORMAL;
    [_btnSubmit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btnSubmit setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    
    _btnFindPwd.titleLabel.font = FONT_NORMAL;
    [_btnFindPwd setTitleColor:COLOR_TEXT_GRAY forState:UIControlStateNormal];
    [_btnFindPwd setTitleColor:COLOR_TEXT_GREEN forState:UIControlStateHighlighted];
    
    _btnRegister.titleLabel.font = FONT_NORMAL;
    [_btnRegister setTitleColor:COLOR_TEXT_GRAY forState:UIControlStateNormal];
    [_btnRegister setTitleColor:COLOR_TEXT_GREEN forState:UIControlStateHighlighted];
    [_btnRegister setBackgroundImage:[[UIImage imageNamed:@"border-btn-bg-green"] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20)] forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_tfMobile resignFirstResponder];
    [_tfPassword resignFirstResponder];
}

#pragma mark -

- (void)btnBackClick
{
    if (_completeBlock)
    {
        _completeBlock(nil, YES);
    }
}

- (IBAction)btnLoginClick:(id)sender
{
    if (!_model)
    {
        self.model = [RPLoginModel model];
    }
    
    [self doLogin];
}

- (IBAction)btnFindPwdClick:(id)sender
{
    RPFindPwdViewController *c = [[RPFindPwdViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:c animated:YES];
}

- (IBAction)btnRegisterClick:(id)sender
{
    RPRegisterViewController *c = [[RPRegisterViewController alloc] initWithNibName:nil bundle:nil];
    [c setupTheme];
    [self.navigationController pushViewController:c animated:YES];
}

#pragma mark -

- (void)doLogin
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    __weak RPLoginViewController *myself = self;
    
    [_model doLogin:@{@"phone":_tfMobile.text,@"password":_tfPassword.text,@"app_ver":@"1.0",@"phone_type":@"1"}
           complete:^(id json, NSError *error) {
               [hud hide:YES];
               
               if (error)
               {
                   MBProgressHUD *hue_e = [MBProgressHUD showMessag:error.localizedDescription toView:nil];
                   [hue_e hide:YES afterDelay:1.5];
                   return;
               }
               
               myself.completeBlock(nil, NO);
           }];
}

@end
