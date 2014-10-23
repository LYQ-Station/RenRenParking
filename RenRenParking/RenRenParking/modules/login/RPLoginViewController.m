//
//  RPLoginViewController.m
//  RenRenParking
//
//  Created by LiYongQiang on 14/10/23.
//  Copyright (c) 2014年 CoderFly. All rights reserved.
//

#import "RPLoginViewController.h"

@interface RPLoginViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *ivInputFields;
@property (weak, nonatomic) IBOutlet UITextField *tfMobile;
@property (weak, nonatomic) IBOutlet UITextField *tfPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;

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
    
    [self setupTheme];
    
    _btnSubmit.backgroundColor = COLOR_BTN_BG_GREEN;
    _btnSubmit.titleLabel.font = FONT_NORMAL;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
