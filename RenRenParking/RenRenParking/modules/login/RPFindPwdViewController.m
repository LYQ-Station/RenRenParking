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
                complete:^(id json, NSError *error) {
                    if (error)
                    {
                        MBProgressHUD *hue_e = [MBProgressHUD showMessag:error.localizedDescription toView:nil];
                        [hue_e hide:YES afterDelay:1.5];
                        return;
                    }
                }];
}

- (IBAction)btnNextStepClick:(id)sender
{
    RPNewPasswordViewController *c = [[RPNewPasswordViewController alloc] initWithNibName:nil bundle:nil];
    c.mobile = _tfMobile.text;
    [self.navigationController pushViewController:c animated:YES];
}

@end
