//
//  RPRegisterViewController.m
//  RenRenParking
//
//  Created by LiYongQiang on 14/10/23.
//  Copyright (c) 2014年 CoderFly. All rights reserved.
//

#import "RPRegisterViewController.h"
#import "RPLoginModel.h"

@interface RPRegisterViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *tfMobile;
@property (weak, nonatomic) IBOutlet UITextField *tfVcode;
@property (weak, nonatomic) IBOutlet UITextField *tfCarNumber;
@property (weak, nonatomic) IBOutlet UITextField *tfPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;
@property (weak, nonatomic) IBOutlet UIButton *btnVcode;

@property (nonatomic, assign) UIScrollView *scrollView;
@property (nonatomic, assign) CGFloat viewOffsetY;

@property (nonatomic, strong) RPLoginModel *model;

@end

@implementation RPRegisterViewController

- (void)dealloc
{
    [_model cancel];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title = NSLocalizedString(@"注册新用户", nil);
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"取消", nil) target:self action:@selector(btnBackClick)];
        
        self.model = [RPLoginModel model];
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
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillHideNotification
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification *note) {
                                                      if (_viewOffsetY != 0.0)
                                                      {
                                                          CGPoint p = self.view.center;
                                                          p.y += -1.0 * _viewOffsetY;
                                                          
                                                          [UIView animateWithDuration:0.25
                                                                           animations:^{
                                                                               self.view.center = p;
                                                                           } completion:^(BOOL finished) {
                                                                               _viewOffsetY = 0.0;
                                                                           }];
                                                      }
                                                  }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (_tfPassword == textField && _viewOffsetY == 0.0)
    {
        _viewOffsetY = -30.0;
        
        CGPoint p = self.view.center;
        p.y += _viewOffsetY;
        
        [UIView animateWithDuration:0.25
                         animations:^{
                             self.view.center = p;
                         } completion:^(BOOL finished) {
                             
                         }];
        return;
    }
    
    if (_tfPassword != textField && _viewOffsetY != 0.0)
    {
        CGPoint p = self.view.center;
        p.y += -1.0 * _viewOffsetY;
        
        [UIView animateWithDuration:0.25
                         animations:^{
                             self.view.center = p;
                         } completion:^(BOOL finished) {
                             _viewOffsetY = 0.0;
                         }];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark -

- (void)btnBackClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnVcodeClick:(UIButton *)sender
{
    NSString *err_txt = [RPLoginModel validateMobile:_tfMobile.text];
    if (err_txt)
    {
        [MBProgressHUD showError:err_txt toView:nil];
        return;
    }
    
    MBProgressHUD *hud = [MBProgressHUD showLoadingMessage:@"获取验证码中..." toView:self.view];
    
    [_model fetchSMSCode:@{@"phone":_tfMobile.text,@"access_token":@"vincentstation"}
                complete:^(NSError *error) {
                    [hud hide:YES];
                    
                    if (error)
                    {
                        [MBProgressHUD showError:error.localizedDescription toView:nil];
                        return;
                    }
                    
                    [MBProgressHUD showSuccess:NSLocalizedString(@"验证码已发送", nil) toView:nil];
                }];
}

- (IBAction)btnSubmitClick:(UIButton *)sender
{
    [self doRegister];
}

- (void)doRegister
{
    NSString *err_txt = [RPLoginModel validateMobile:_tfMobile.text];
    if (err_txt)
    {
        [MBProgressHUD showError:err_txt toView:nil];
        return;
    }
    
    err_txt = [RPLoginModel validateVCode:_tfVcode.text];
    if (err_txt)
    {
        [MBProgressHUD showError:err_txt toView:nil];
        return;
    }
    
    err_txt = [RPLoginModel validatePassword:_tfPassword.text];
    if (err_txt)
    {
        [MBProgressHUD showError:err_txt toView:nil];
        return;
    }
    
    __weak RPRegisterViewController *myself = self;
    MBProgressHUD *hud = [MBProgressHUD showLoadingMessage:@"注册中..." toView:self.view];
    
    [_model doRegister:@{@"phone":_tfMobile.text,@"password":_tfPassword.text,@"car_no":_tfCarNumber.text,@"vcode":_tfVcode.text}
              complete:^(id json, NSError *error) {
                  [hud hide:YES];
                  if (error)
                  {
                      [MBProgressHUD showError:error.localizedDescription toView:nil];
                      return ;
                  }
                  
                  [MBProgressHUD showSuccess:NSLocalizedString(@"注册成功！", nil) toView:nil];
                  
                  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                      [myself btnBackClick];
                  });
              }];
    
//    [_model checkVcode:@{@"phone":_tfMobile.text,@"vcode":_tfVcode.text}
//              complete:^(id json, NSError *error) {
//                  [hud hide:YES];
//                  
//                  if (error)
//                  {
//                      [MBProgressHUD showError:error.localizedDescription toView:nil];
//                      return ;
//                  }
//                  
//                  [_model doRegister:@{@"phone":_tfMobile.text,@"password":_tfPassword.text,@"car_no":_tfCarNumber.text,@"vcode":_tfVcode.text}
//                            complete:^(id json, NSError *error) {
//                                if (error)
//                                {
//                                    [MBProgressHUD showError:error.localizedDescription toView:nil];
//                                    return ;
//                                }
//                            }];
//              }];
}

@end
