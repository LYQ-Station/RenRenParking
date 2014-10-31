//
//  RPIndexViewController.m
//  RenRenParking
//
//  Created by LiYongQiang on 14/10/23.
//  Copyright (c) 2014年 CoderFly. All rights reserved.
//

#import "RPIndexViewController.h"
#import "RPUserProfileTableViewController.h"
#import "RPOderListTableViewController.h"
#import "RPFeedbackViewController.h"
#import "RPSettingsTableViewController.h"
#import "RPMapViewController.h"
#import "PPMapView.h"

#import "RPFetchCarViewController.h"

@interface RPIndexViewController () <UITableViewDataSource, UITableViewDelegate, RPMapViewControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;

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
    
    [self setupLogoTheme];
    
    UITapGestureRecognizer *g = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapNavgatorBar:)];
    [self.navigationController.navigationBar addGestureRecognizer:g];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = COLOR_MAIN_BG_GRAY;
    [self.view addSubview:_tableView];
    
    UINavigationController *mc = [RPMapViewController navController:self];
    [self presentViewController:mc animated:NO completion:nil];
    
    RPMapViewController *c = (RPMapViewController *)[mc.viewControllers lastObject];
    [c showOuterInfo];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 51.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"idx-cell"];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"idx-cell"];
        cell.textLabel.backgroundColor = [UIColor clearColor];
    }
    
    if (0 == indexPath.row)
    {
        cell.imageView.image = [UIImage imageNamed:@"index-cell-icon0"];
        cell.textLabel.text = @"我的资料";
    }
    else if (1 == indexPath.row)
    {
        cell.imageView.image = [UIImage imageNamed:@"index-cell-icon1"];
        cell.textLabel.text = @"历史订单";
    }
    else if (2 == indexPath.row)
    {
        cell.imageView.image = [UIImage imageNamed:@"index-cell-icon2"];
        cell.textLabel.text = @"意见反馈";
    }
    else if (3 == indexPath.row)
    {
        cell.imageView.image = [UIImage imageNamed:@"index-cell-icon3"];
        cell.textLabel.text = @"设置";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (3 == indexPath.row)
    {
        return;
    }
    
    UIImageView *iv = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"table-cell-bg0"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)]];
    cell.backgroundView = iv;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (0 == indexPath.row)
    {
        RPUserProfileTableViewController *c = [[RPUserProfileTableViewController alloc] initWithStyle:UITableViewStylePlain];
        [self.navigationController pushViewController:c animated:YES];
    }
    else if (1 == indexPath.row)
    {
        RPOderListTableViewController *c = [[RPOderListTableViewController alloc] initWithStyle:UITableViewStylePlain];
        [self.navigationController pushViewController:c animated:YES];
    }
    else if (2 == indexPath.row)
    {
        RPFeedbackViewController *c = [[RPFeedbackViewController alloc] initWithNibName:nil bundle:nil];
        [self.navigationController pushViewController:c animated:YES];
    }
    else if (3 == indexPath.row)
    {
        RPSettingsTableViewController *c = [[RPSettingsTableViewController alloc] initWithStyle:UITableViewStylePlain];
        [self.navigationController pushViewController:c animated:YES];
    }
}

#pragma mark -

- (void)onTapNavgatorBar:(UITapGestureRecognizer *)gesture
{
    UINavigationController *mc = [RPMapViewController navController:self];
    [self presentViewController:mc animated:YES completion:nil];
    
    RPMapViewController *c = (RPMapViewController *)[mc.viewControllers lastObject];
    [c showOuterInfo];
}

#pragma mark -

- (void)mapViewControllerDidOrderSubmit:(RPMapViewController *)controller
{
    
}

- (void)mapViewControllerDidOrderCancel:(RPMapViewController *)controller
{
    
}

- (void)mapViewControllerDidDriverReceiveCar:(RPMapViewController *)controller
{
    [controller dismissViewControllerAnimated:NO completion:nil];
    
    UINavigationController *mc = [RPFetchCarViewController navController:self];
    [self presentViewController:mc animated:NO completion:nil];
}

- (void)mapViewControllerDidPaymentSuccess:(RPMapViewController *)controller
{
    [controller dismissViewControllerAnimated:NO completion:^{
        UINavigationController *mc = [RPMapViewController navController];
        [self presentViewController:mc animated:NO completion:nil];
        
        RPMapViewController *c = (RPMapViewController *)[mc.viewControllers lastObject];
        [c showOuterInfo];
    }];
}

@end
