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

@interface RPLoginViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *ivInputFields;
@property (weak, nonatomic) IBOutlet UITextField *tfMobile;
@property (weak, nonatomic) IBOutlet UITextField *tfPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;
@property (weak, nonatomic) IBOutlet UIButton *btnFindPwd;
@property (weak, nonatomic) IBOutlet UIButton *btnRegister;

@end

@implementation RPLoginViewController

+ (UINavigationController *)navController:(id)delegate
{
    RPLoginViewController *c = [[RPLoginViewController alloc] initWithNibName:nil bundle:nil];
    c.delegate = delegate;
    
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:c];
    return nc;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupLogoTheme];
    
    _btnSubmit.backgroundColor = COLOR_BTN_BG_GREEN;
    _btnSubmit.titleLabel.font = FONT_NORMAL;
    
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

- (IBAction)btnFindPwdClick:(id)sender
{
    RPFindPwdViewController *c = [[RPFindPwdViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:c animated:YES];
}

- (IBAction)btnRegisterClick:(id)sender
{
    RPRegisterViewController *c = [[RPRegisterViewController alloc] initWithNibName:nil bundle:nil];
    c.title = NSLocalizedString(@"注册新用户", nil);
    [c setupTheme];
    [self.navigationController pushViewController:c animated:YES];
}

@end
