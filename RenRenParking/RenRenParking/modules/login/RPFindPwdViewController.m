//
//  RPFindPwdViewController.m
//  RenRenParking
//
//  Created by Vincent on 10/24/14.
//  Copyright (c) 2014 CoderFly. All rights reserved.
//

#import "RPFindPwdViewController.h"
#import "RPNewPasswordViewController.h"
#import "RPLoginModel.h"

@interface RPFindPwdViewController ()

@property (weak, nonatomic) IBOutlet UITextField *tfMobile;
@property (weak, nonatomic) IBOutlet UITextField *tfPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnNextStep;
@property (weak, nonatomic) IBOutlet UIButton *btnVcode;

@property (nonatomic, strong) RPLoginModel *model;

@end

@implementation RPFindPwdViewController

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
    
    _btnNextStep.backgroundColor = COLOR_BTN_BG_DARK_GRAY;
    _btnNextStep.titleLabel.font = FONT_NORMAL;
    
    _btnVcode.backgroundColor = [UIColor colorWithRed:0.18f green:0.20f blue:0.25f alpha:1.0f];
    _btnVcode.titleLabel.font = FONT_NORMAL;
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

- (IBAction)btnVcodeClick:(id)sender
{
    [_model fetchSMSCode:@{@"phone":_tfMobile.text}
                complete:^(NSError *error) {
                    if (error)
                    {
                        [MBProgressHUD showError:error.localizedDescription toView:nil];
                        return ;
                    }
                }];
}

- (IBAction)btnNextStepClick:(id)sender
{
    if (0 == _tfMobile.text.length || 0 == _tfPassword.text.length)
    {
        [MBProgressHUD showError:@"请填写手机号码和验证码." toView:nil];
        return;
    }
    
    [self doValidateVcode];
}

#pragma mark -

- (void)doValidateVcode
{
    MBProgressHUD *hud = [MBProgressHUD showLoadingMessage:@"验证中..." toView:self.view];
    
    [_model checkVcode:@{@"phone":_tfMobile.text,@"code":_tfPassword.text}
              complete:^(id json, NSError *error) {
                  [hud hide:NO];
                  if (error)
                  {
                      [MBProgressHUD showError:error.localizedDescription toView:nil];
                      return ;
                  }
                  
                  RPNewPasswordViewController *c = [[RPNewPasswordViewController alloc] initWithNibName:nil bundle:nil];
                  c.token = json;
                  [self.navigationController pushViewController:c animated:YES];
              }];
}

@end
