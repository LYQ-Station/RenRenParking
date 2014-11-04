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
#import "RPLoginViewController.h"
#import "PPMapView.h"

#import "RPFetchCarViewController.h"

@interface RPDragGestureRecognizer ()

@property (nonatomic, assign) CGFloat beginY;
@property (nonatomic, readwrite) UIGestureRecognizerState state;
@property (nonatomic, assign) id target;
@property (nonatomic, assign) SEL selector;

@end

@implementation RPDragGestureRecognizer

- (void)addTarget:(id)target action:(SEL)action
{
    self.target = target;
    self.selector = action;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *t = [touches anyObject];
    CGPoint p = [t locationInView:t.window];
    _beginY = p.y;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *t = [touches anyObject];
    CGPoint p = [t locationInView:t.window];
    
    _offsetY = p.y - _beginY;
    
    if (_target)
    {
        [_target performSelector:_selector withObject:self];
    }
}

@end


@interface RPIndexViewController () <UITableViewDataSource, UITableViewDelegate, RPMapViewControllerDelegate>

@property (nonatomic, strong) RPMapViewController *mapViewController;
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
    
        //
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = COLOR_MAIN_BG_GRAY;
    [self.view addSubview:_tableView];
    
        //map view controller
    self.mapViewController = [[RPMapViewController alloc] initWithNibName:nil bundle:nil];
    _mapViewController.delegate = self;
    [_mapViewController viewDidLoad];
    [_mapViewController viewWillAppear:NO];
    [self.view addSubview:_mapViewController.view];
    [_mapViewController viewDidAppear:YES];
    [_mapViewController showOuterInfo];
    
        //bottom bar
    UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"index-up-arrow"]];
    iv.translatesAutoresizingMaskIntoConstraints = NO;
    iv.userInteractionEnabled = YES;
    [self.view addSubview:iv];
    
    RPDragGestureRecognizer *dg = [[RPDragGestureRecognizer alloc] init];
    [dg addTarget:self action:@selector(onDragHandelArrow:)];
    [iv addGestureRecognizer:dg];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:iv
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1
                                                           constant:0]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[iv]-20-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:@{@"iv":iv}]];
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
        cell.textLabel.text = NSLocalizedString(@"我的资料", nil);
    }
    else if (1 == indexPath.row)
    {
        cell.imageView.image = [UIImage imageNamed:@"index-cell-icon1"];
        cell.textLabel.text = NSLocalizedString(@"历史订单", nil);
    }
    else if (2 == indexPath.row)
    {
        cell.imageView.image = [UIImage imageNamed:@"index-cell-icon2"];
        cell.textLabel.text = NSLocalizedString(@"意见反馈", nil);
    }
    else if (3 == indexPath.row)
    {
        cell.imageView.image = [UIImage imageNamed:@"index-cell-icon3"];
        cell.textLabel.text = NSLocalizedString(@"设置", nil);
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
        UINavigationController *nc = [RPLoginViewController navControllerWithBlock:^(id user, BOOL isCancelled) {
            if (isCancelled)
            {
                [self.navigationController dismissViewControllerAnimated:YES completion:nil];
                return ;
            }
            
            RPUserProfileTableViewController *c = [[RPUserProfileTableViewController alloc] initWithStyle:UITableViewStylePlain];
            [self.navigationController pushViewController:c animated:NO];
            
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        }];
        
        [self.navigationController presentViewController:nc animated:YES completion:nil];
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
//    UINavigationController *mc = [RPMapViewController navController:self];
//    [self presentViewController:mc animated:YES completion:nil];
//    
//    RPMapViewController *c = (RPMapViewController *)[mc.viewControllers lastObject];
//    [c showOuterInfo];
    
    if (_mapViewController.view.superview)
    {
        [_mapViewController.view removeFromSuperview];
    }
    else
    {
        [self.view addSubview:_mapViewController.view];
    }
}

- (void)onDragHandelArrow:(RPDragGestureRecognizer *)gesture
{
    NSLog(@"yyyy");
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
//        UINavigationController *mc = [RPMapViewController navController];
//        [self presentViewController:mc animated:NO completion:nil];
//        
//        RPMapViewController *c = (RPMapViewController *)[mc.viewControllers lastObject];
//        [c showOuterInfo];
        
        [_mapViewController showOuterInfo];
    }];
}

@end
