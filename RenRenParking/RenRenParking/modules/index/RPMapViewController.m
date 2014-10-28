//
//  RPMapViewController.m
//  RenRenParking
//
//  Created by LiYongQiang on 14/10/27.
//  Copyright (c) 2014年 CoderFly. All rights reserved.
//

#import "RPMapViewController.h"
#import "PPMapView.h"

@interface RPMapViewController ()

@property (nonatomic, strong) UIImageView *viewTopBar;
@property (nonatomic, strong) UILabel *lbAddress;
@property (nonatomic, strong) UIButton *btnLocation;
@property (nonatomic, strong) UIImageView *viewBottomBar;
@property (nonatomic, assign) PPMapView *mapView;

@end

@implementation RPMapViewController

+ (UINavigationController *)navController
{
    RPMapViewController *c = [[RPMapViewController alloc] initWithNibName:nil bundle:nil];
    
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:c];
    return nc;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupLogoTheme];
    
    _mapView = [PPMapView mapViewWithFrame:self.view.bounds];
    _mapView.mapView.userInteractionEnabled = YES;
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
    
        //top bar
    self.viewTopBar = [[UIImageView alloc] initWithFrame:CGRectZero];
    _viewTopBar.userInteractionEnabled = YES;
    _viewTopBar.translatesAutoresizingMaskIntoConstraints = NO;
    _viewTopBar.image = [[UIImage imageNamed:@"map-addr-bar-bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 42.0)];
    [self.view addSubview:_viewTopBar];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[top_bar]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:@{@"top_bar":_viewTopBar}]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[top_bar(42.0)]"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:@{@"top_bar":_viewTopBar}]];
    
        //address label
    self.lbAddress = [[UILabel alloc] initWithFrame:CGRectZero];
    _lbAddress.translatesAutoresizingMaskIntoConstraints = NO;
    _lbAddress.font = FONT_NORMAL;
    _lbAddress.textAlignment = NSTextAlignmentCenter;
    _lbAddress.backgroundColor = [UIColor clearColor];
    _lbAddress.text = @"深圳市南山区科技园源兴科技大厦";
    [_viewTopBar addSubview:_lbAddress];
    
    [_viewTopBar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[lb_addr]-42-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:@{@"lb_addr":_lbAddress}]];
    
    [_viewTopBar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[lb_addr(42.0)]"
                                                                        options:0
                                                                        metrics:nil
                                                                          views:@{@"lb_addr":_lbAddress}]];
    
        //location button
    self.btnLocation = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnLocation.translatesAutoresizingMaskIntoConstraints = NO;
    [_btnLocation setImage:[UIImage imageNamed:@"map-btn-location"] forState:UIControlStateNormal];
    [_viewTopBar addSubview:_btnLocation];
    
    [_viewTopBar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[btn_loc(42)]|"
                                                                        options:0
                                                                        metrics:nil
                                                                          views:@{@"btn_loc":_btnLocation}]];
    
    [_viewTopBar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[btn_loc(42.0)]"
                                                                        options:0
                                                                        metrics:nil
                                                                          views:@{@"btn_loc":_btnLocation}]];
    
    
        //bottom bar
//    self.viewBottomBar = [[UIImageView alloc] initWithFrame:CGRectZero];
//    _viewBottomBar.userInteractionEnabled = YES;
//    _viewBottomBar.translatesAutoresizingMaskIntoConstraints = NO;
//    _viewBottomBar.image = [[UIImage imageNamed:@"map-bottom-bar-bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(20.0, 0, 0, 0)];
//    [self.view addSubview:_viewBottomBar];
//    
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[bot_bar]|"
//                                                                      options:0
//                                                                      metrics:nil
//                                                                        views:@{@"bot_bar":_viewBottomBar}]];
//    
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[bot_bar(81.0)]|"
//                                                                      options:0
//                                                                      metrics:nil
//                                                                        views:@{@"bot_bar":_viewBottomBar}]];
    
    [self showOuterInfo];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - mapview delegate

- (void)ppMapView:(PPMapView *)mapView didUpdateToLocation:(CLLocation *)newLocation
{
    
}

- (void)ppMapView:(PPMapView *)mapView didSelectAnnotation:(PPMapAnnoation *)annotation
{
    
}

- (void)ppMapView:(PPMapView *)mapView didDeselectAnnotation:(PPMapAnnoation *)annotation
{
    
}

#pragma mark -

- (void)showOuterInfo
{
    [_viewBottomBar removeFromSuperview];
    self.viewBottomBar = nil;
    
    self.viewBottomBar = [[UIImageView alloc] initWithFrame:CGRectZero];
    _viewBottomBar.userInteractionEnabled = YES;
    _viewBottomBar.translatesAutoresizingMaskIntoConstraints = NO;
    _viewBottomBar.image = [[UIImage imageNamed:@"map-bottom-bar-bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(20.0, 0, 0, 0)];
    [self.view addSubview:_viewBottomBar];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[bot_bar]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:@{@"bot_bar":_viewBottomBar}]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[bot_bar(81.0)]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:@{@"bot_bar":_viewBottomBar}]];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.translatesAutoresizingMaskIntoConstraints = NO;
    [btn setTitle:NSLocalizedString(@"带我去最近的服务点", nil) forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:COLOR_TEXT_GREEN forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(btnGoServiceStationClick:) forControlEvents:UIControlEventTouchUpInside];
    [_viewBottomBar addSubview:btn];
    
    [_viewBottomBar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[btn_go]|"
                                                                           options:0
                                                                           metrics:nil
                                                                             views:@{@"btn_go":btn}]];
    
    [_viewBottomBar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-6-[btn_go]|"
                                                                           options:0
                                                                           metrics:nil
                                                                             views:@{@"btn_go":btn}]];
}

- (void)btnGoServiceStationClick:(UIButton *)sender
{
    [self showInnerInfo];
}

#pragma mark -

- (void)showInnerInfo
{
    [_viewBottomBar removeFromSuperview];
    self.viewBottomBar = nil;
    
    self.viewBottomBar = [[UIImageView alloc] initWithFrame:CGRectZero];
    _viewBottomBar.userInteractionEnabled = YES;
    _viewBottomBar.translatesAutoresizingMaskIntoConstraints = NO;
    _viewBottomBar.image = [[UIImage imageNamed:@"map-bottom-bar-bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(20.0, 0, 0, 0)];
    [self.view addSubview:_viewBottomBar];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[bot_bar]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:@{@"bot_bar":_viewBottomBar}]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[bot_bar(81.0)]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:@{@"bot_bar":_viewBottomBar}]];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.translatesAutoresizingMaskIntoConstraints = NO;
    [btn setTitle:NSLocalizedString(@"确认预约", nil) forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:COLOR_TEXT_GREEN forState:UIControlStateHighlighted];
    btn.backgroundColor = COLOR_BTN_BG_GREEN;
    [btn addTarget:self action:@selector(btnGetService:) forControlEvents:UIControlEventTouchUpInside];
    [_viewBottomBar addSubview:btn];
    
    [_viewBottomBar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[btn_go]|"
                                                                           options:0
                                                                           metrics:nil
                                                                             views:@{@"btn_go":btn}]];
    
    [_viewBottomBar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-6-[btn_go]|"
                                                                           options:0
                                                                           metrics:nil
                                                                             views:@{@"btn_go":btn}]];
    
    [_viewBottomBar addConstraint:[NSLayoutConstraint constraintWithItem:btn
                                                    attribute:NSLayoutAttributeWidth
                                                    relatedBy:NSLayoutRelationEqual
                                                       toItem:_viewBottomBar
                                                    attribute:NSLayoutAttributeWidth
                                                   multiplier:0.5
                                                     constant:0]];
    
    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectZero];
    lb.translatesAutoresizingMaskIntoConstraints = NO;
    lb.textAlignment = NSTextAlignmentCenter;
    lb.textColor = [UIColor whiteColor];
    lb.font = FONT_NORMAL;
    lb.text = NSLocalizedString(@"费用", nil);
    lb.backgroundColor = [UIColor clearColor];
    [_viewBottomBar addSubview:lb];
    
    UILabel *lb2 = [[UILabel alloc] initWithFrame:CGRectZero];
    lb2.translatesAutoresizingMaskIntoConstraints = NO;
    lb2.font = FONT_NORMAL;
    lb2.textAlignment = NSTextAlignmentCenter;
    lb2.textColor = [UIColor whiteColor];
    lb2.text = NSLocalizedString(@"等待", nil);
    lb2.backgroundColor = [UIColor clearColor];
    [_viewBottomBar addSubview:lb2];
    
    [_viewBottomBar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[lb_charge_t(lb_time_t)]-0-[lb_time_t]-0-[btn_go]|"
                                                                           options:0
                                                                           metrics:nil
                                                                             views:@{@"lb_charge_t":lb,@"lb_time_t":lb2,@"btn_go":btn}]];
    
        //
    NSMutableAttributedString *charge_str = [[NSMutableAttributedString alloc] initWithString:@"¥"
                                                                                  attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],
                                                                                               NSFontAttributeName:[UIFont systemFontOfSize:14.0]}];
    
    [charge_str appendAttributedString:[[NSAttributedString alloc] initWithString:@"99"
                                                                      attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],
                                                                                   NSFontAttributeName:[UIFont systemFontOfSize:25.0]}]];
    
    [charge_str appendAttributedString:[[NSAttributedString alloc] initWithString:@"元"
                                                                      attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],
                                                                                   NSFontAttributeName:[UIFont systemFontOfSize:14.0]}]];
    
    UILabel *lb_charge = [[UILabel alloc] initWithFrame:CGRectZero];
    lb_charge.translatesAutoresizingMaskIntoConstraints = NO;
    lb_charge.textAlignment = NSTextAlignmentCenter;
    lb_charge.attributedText = charge_str;
    lb_charge.backgroundColor = [UIColor clearColor];
    [_viewBottomBar addSubview:lb_charge];
    
        //
    NSMutableAttributedString *time_str = [[NSMutableAttributedString alloc] initWithString:@"15"
                                                                                 attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],
                                                                                              NSFontAttributeName:[UIFont systemFontOfSize:25.0]}];
    
    [time_str appendAttributedString:[[NSAttributedString alloc] initWithString:@"分钟"
                                                                     attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],
                                                                                  NSFontAttributeName:[UIFont systemFontOfSize:14.0]}]];
    
    UILabel *lb_time = [[UILabel alloc] initWithFrame:CGRectZero];
    lb_time.translatesAutoresizingMaskIntoConstraints = NO;
    lb_time.textAlignment = NSTextAlignmentCenter;
    lb_time.attributedText = time_str;
    lb_time.backgroundColor = [UIColor clearColor];
    [_viewBottomBar addSubview:lb_time];
    
    [_viewBottomBar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[lb_charge_t(lb_time_t)]-0-[lb_time_t]-0-[btn_go]|"
                                                                           options:0
                                                                           metrics:nil
                                                                             views:@{@"lb_charge_t":lb,@"lb_time_t":lb2,@"btn_go":btn}]];
    
    [_viewBottomBar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[lb_charge(lb_time)]-0-[lb_time]-0-[btn_go]|"
                                                                           options:0
                                                                           metrics:nil
                                                                             views:@{@"lb_charge":lb_charge,@"lb_time":lb_time,@"btn_go":btn}]];
    
    [_viewBottomBar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-16-[lb_charge_t]-3-[lb_charge]"
                                                                           options:0
                                                                           metrics:nil
                                                                             views:@{@"lb_charge_t":lb,@"lb_charge":lb_charge}]];
    
    [_viewBottomBar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-16-[lb_time_t]-3-[lb_time]"
                                                                           options:0
                                                                           metrics:nil
                                                                             views:@{@"lb_time_t":lb2,@"lb_time":lb_time}]];
}

- (void)btnGetService:(UIButton *)sender
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = NSLocalizedString(@"正在寻找司机，请等待...", nil);
    [self.view addSubview:hud];
    [hud show:YES];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [hud hide:YES];
        
        [self showDriverInfo];
    });
}

#pragma mark -

- (void)showDriverInfo
{
    [_viewBottomBar removeFromSuperview];
    self.viewBottomBar = nil;
    
    self.viewBottomBar = [[UIImageView alloc] initWithFrame:CGRectZero];
    _viewBottomBar.userInteractionEnabled = YES;
    _viewBottomBar.translatesAutoresizingMaskIntoConstraints = NO;
    _viewBottomBar.image = [[UIImage imageNamed:@"map-bottom-bar-bg2"] resizableImageWithCapInsets:UIEdgeInsetsMake(20.0, 125.0, 0, 10.0)];
    [self.view addSubview:_viewBottomBar];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[bot_bar]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:@{@"bot_bar":_viewBottomBar}]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[bot_bar(88.0)]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:@{@"bot_bar":_viewBottomBar}]];
    
        //
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.translatesAutoresizingMaskIntoConstraints = NO;
    btn.titleLabel.numberOfLines = 2;
    btn.backgroundColor = [UIColor colorWithRed:0.33 green:0.36 blue:0.49 alpha:1.0];
    [btn setTitle:NSLocalizedString(@"取消\n订单", nil) forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:COLOR_TEXT_GREEN forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(btnGoServiceStationClick:) forControlEvents:UIControlEventTouchUpInside];
    [_viewBottomBar addSubview:btn];
    
    [_viewBottomBar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[btn_go(82)]|"
                                                                           options:0
                                                                           metrics:nil
                                                                             views:@{@"btn_go":btn}]];
    
    [_viewBottomBar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-12-[btn_go]|"
                                                                           options:0
                                                                           metrics:nil
                                                                             views:@{@"btn_go":btn}]];
    
        //
    UIImageView *avator = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"test-driver"]];
    avator.frame = CGRectMake(17, 5, 80, 80);
    [_viewBottomBar addSubview:avator];
    
        //
    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectZero];
    lb.translatesAutoresizingMaskIntoConstraints = NO;
    lb.textAlignment = NSTextAlignmentCenter;
    lb.textColor = [UIColor whiteColor];
    lb.font = FONT_NORMAL;
    lb.text = NSLocalizedString(@"等待", nil);
    lb.backgroundColor = [UIColor clearColor];
    [_viewBottomBar addSubview:lb];
    
    [_viewBottomBar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[lb_time_t(111)]"
                                                                           options:0
                                                                           metrics:nil
                                                                             views:@{@"lb_time_t":lb}]];
    
    [_viewBottomBar addConstraint:[NSLayoutConstraint constraintWithItem:lb
                                                               attribute:NSLayoutAttributeCenterX
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:_viewBottomBar
                                                               attribute:NSLayoutAttributeCenterX
                                                              multiplier:1
                                                                constant:0]];
    
        //
    NSMutableAttributedString *time_str = [[NSMutableAttributedString alloc] initWithString:@"15"
                                                                                 attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],
                                                                                              NSFontAttributeName:[UIFont systemFontOfSize:25.0]}];
    
    [time_str appendAttributedString:[[NSAttributedString alloc] initWithString:@"分钟"
                                                                     attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],
                                                                                  NSFontAttributeName:[UIFont systemFontOfSize:14.0]}]];
    
    UILabel *lb_time = [[UILabel alloc] initWithFrame:CGRectZero];
    lb_time.translatesAutoresizingMaskIntoConstraints = NO;
    lb_time.textAlignment = NSTextAlignmentCenter;
    lb_time.attributedText = time_str;
    lb_time.backgroundColor = [UIColor clearColor];
    [_viewBottomBar addSubview:lb_time];
    
    [_viewBottomBar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[lb_time(111)]"
                                                                           options:0
                                                                           metrics:nil
                                                                             views:@{@"lb_time":lb_time}]];
    
    [_viewBottomBar addConstraint:[NSLayoutConstraint constraintWithItem:lb_time
                                                               attribute:NSLayoutAttributeCenterX
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:_viewBottomBar
                                                               attribute:NSLayoutAttributeCenterX
                                                              multiplier:1
                                                                constant:0]];
    
    [_viewBottomBar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-21-[lb_time_t]-3-[lb_time]"
                                                                           options:0
                                                                           metrics:nil
                                                                             views:@{@"lb_time_t":lb,@"lb_time":lb_time}]];
}

@end
