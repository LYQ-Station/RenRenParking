//
//  RPIndexViewController.m
//  RenRenParking
//
//  Created by LiYongQiang on 14/10/23.
//  Copyright (c) 2014年 CoderFly. All rights reserved.
//

#import "RPIndexViewController.h"

@interface RPIndexViewController ()

@end

@implementation RPIndexViewController

+ (UINavigationController *)navController
{
    RPIndexViewController *c = [[RPIndexViewController alloc] initWithNibName:nil bundle:nil];
    
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:c];
    
    return nc;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupTheme];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
