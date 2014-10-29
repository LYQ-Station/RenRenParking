//
//  RPMapViewController.m
//  RenRenParking
//
//  Created by LiYongQiang on 14/10/27.
//  Copyright (c) 2014年 CoderFly. All rights reserved.
//

#import "RPMapViewController.h"
#import "PPMapView.h"

@interface RPMapViewController () <PPMapViewDelegate>

@property (nonatomic, strong) UIImageView *viewTopBar;
@property (nonatomic, strong) UILabel *lbAddress;
@property (nonatomic, strong) UIButton *btnScope;
@property (nonatomic, strong) UIImageView *viewBottomBar;
@property (nonatomic, strong) UIImageView *viewCenterPin;
@property (nonatomic, assign) PPMapView *mapView;

@end

@implementation RPMapViewController

+ (UINavigationController *)navController
{
    RPMapViewController *c = [[RPMapViewController alloc] initWithNibName:nil bundle:nil];
    
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:c];
    return nc;
}

- (void)loadView
{
    CGRect win_s = [UIScreen mainScreen].bounds;
    
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, win_s.size.width, win_s.size.height-20.0f-44.0f)];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    [self setupLogoTheme];
    
    _mapView = [PPMapView mapViewWithFrame:self.view.bounds];
    _mapView.mapView.userInteractionEnabled = YES;
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
    
        //
    self.viewCenterPin = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"map-center-pin"]];
    _viewCenterPin.center = CGPointMake(self.view.bounds.size.width*0.5, self.view.bounds.size.height*0.5);
    [self.view addSubview:_viewCenterPin];
    
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
    self.btnScope = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnScope.translatesAutoresizingMaskIntoConstraints = NO;
    [_btnScope setImage:[UIImage imageNamed:@"map-btn-location"] forState:UIControlStateNormal];
    [_btnScope addTarget:self action:@selector(btnScopeClick:) forControlEvents:UIControlEventTouchUpInside];
    [_viewTopBar addSubview:_btnScope];
    
    [_viewTopBar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[btn_loc(42)]|"
                                                                        options:0
                                                                        metrics:nil
                                                                          views:@{@"btn_loc":_btnScope}]];
    
    [_viewTopBar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[btn_loc(42.0)]"
                                                                        options:0
                                                                        metrics:nil
                                                                          views:@{@"btn_loc":_btnScope}]];
    
    
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
    
    [_mapView startUpdatingLocation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - mapview delegate

- (void)ppMapView:(PPMapView *)mapView didUpdateToLocation:(CLLocation *)newLocation
{
    [[_btnScope viewWithTag:101] removeFromSuperview];
    _btnScope.enabled = YES;
    [_btnScope setImage:[UIImage imageNamed:@"map-btn-location"] forState:UIControlStateNormal];
    
}

- (void)ppMapView:(PPMapView *)mapView didSelectAnnotation:(PPMapAnnoation *)annotation
{
    
}

- (void)ppMapView:(PPMapView *)mapView didDeselectAnnotation:(PPMapAnnoation *)annotation
{
    
}

- (void)ppMapViewRegionDidChange:(PPMapView *)mapView
{
    [mapView doGeoSearch:mapView.mapView.centerCoordinate];
}

- (void)ppMapView:(PPMapView *)mapView onGetReverseGeoCodeAddress:(NSString *)address
{
    _lbAddress.text = address;
}

#pragma mark -

- (void)btnScopeClick:(UIButton *)sender
{
    [sender setImage:nil forState:UIControlStateNormal];
    sender.enabled = NO;
    
    UIActivityIndicatorView *av = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    av.tag = 101;
    av.center = CGPointMake(21, 21);
    [sender addSubview:av];
    [av startAnimating];
    
    [_mapView performSelector:@selector(startUpdatingLocation) withObject:nil afterDelay:1.0];
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
    NSMutableAttributedString *charge_str = [[NSMutableAttributedString alloc] initWithString:@"¥ "
                                                                                  attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],
                                                                                               NSFontAttributeName:[UIFont systemFontOfSize:14.0]}];
    
    [charge_str appendAttributedString:[[NSAttributedString alloc] initWithString:@"99"
                                                                      attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],
                                                                                   NSFontAttributeName:[UIFont systemFontOfSize:25.0]}]];
    
    [charge_str appendAttributedString:[[NSAttributedString alloc] initWithString:@" 元"
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
    
    [time_str appendAttributedString:[[NSAttributedString alloc] initWithString:@" 分钟"
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
    [btn addTarget:self action:@selector(btnCancelOderClick) forControlEvents:UIControlEventTouchUpInside];
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
//    UIImageView *avator = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"test-driver"]];
//    avator.frame = CGRectMake(17, 5, 80, 80);
//    [_viewBottomBar addSubview:avator];
    
    UIImage *im = [UIImage imageNamed:@"test-driver"];
    UIButton *btn_avator = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_avator.frame = CGRectMake(17, 5, 80, 80);
    [btn_avator setImage:im forState:UIControlStateNormal];
    [btn_avator addTarget:self action:@selector(btnAvatorClick) forControlEvents:UIControlEventTouchUpInside];
    [_viewBottomBar addSubview:btn_avator];
    
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
    
    [time_str appendAttributedString:[[NSAttributedString alloc] initWithString:@" 分钟"
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

- (void)btnAvatorClick
{
    NSURL *url = [NSURL URLWithString:@"tel://10000"];
    if (![[UIApplication sharedApplication] canOpenURL:url])
    {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:nil
                                                     message:NSLocalizedString(@"此设备不支持电话功能", nil)
                                                    delegate:nil
                                           cancelButtonTitle:nil
                                           otherButtonTitles:NSLocalizedString(@"返回", nil), nil];
        [av show];
        return;
    }
    
    [[UIApplication sharedApplication] openURL:url];
}

- (void)btnCancelOderClick
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = NSLocalizedString(@"你的订单已取消。", nil);
    [self.view addSubview:hud];
    [hud show:YES];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [hud hide:YES];
        
        [self showInnerInfo];
    });
}

#pragma mark -

- (void)showFetchCarInfo
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
    [btn setTitle:NSLocalizedString(@"在这取车", nil) forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:COLOR_TEXT_GREEN forState:UIControlStateHighlighted];
    btn.backgroundColor = COLOR_BTN_BG_GREEN;
    [btn addTarget:self action:@selector(btnFetchCarClick) forControlEvents:UIControlEventTouchUpInside];
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
                                                              multiplier:0.3
                                                                constant:0]];
    
        //
    UIButton *btn_back = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_back.translatesAutoresizingMaskIntoConstraints = NO;
    [btn_back setImage:[UIImage imageNamed:@"fetch-btn-back-bg"] forState:UIControlStateNormal];
    [_viewBottomBar addSubview:btn_back];
    
    [_viewBottomBar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[btn_back(31)]"
                                                                           options:0
                                                                           metrics:nil
                                                                             views:@{@"btn_back":btn_back}]];
    
    [_viewBottomBar addConstraint:[NSLayoutConstraint constraintWithItem:btn_back
                                                               attribute:NSLayoutAttributeCenterY
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:_viewBottomBar
                                                               attribute:NSLayoutAttributeCenterY
                                                              multiplier:1
                                                                constant:0]];
    
        //
    UILabel *lb2 = [[UILabel alloc] initWithFrame:CGRectZero];
    lb2.translatesAutoresizingMaskIntoConstraints = NO;
    lb2.font = FONT_NORMAL;
    lb2.textAlignment = NSTextAlignmentCenter;
    lb2.textColor = [UIColor whiteColor];
    lb2.text = NSLocalizedString(@"等待", nil);
    lb2.backgroundColor = [UIColor clearColor];
    [_viewBottomBar addSubview:lb2];
    
        //
    NSMutableAttributedString *time_str = [[NSMutableAttributedString alloc] initWithString:@"15"
                                                                                 attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],
                                                                                              NSFontAttributeName:[UIFont systemFontOfSize:25.0]}];
    
    [time_str appendAttributedString:[[NSAttributedString alloc] initWithString:@" 分钟"
                                                                     attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],
                                                                                  NSFontAttributeName:[UIFont systemFontOfSize:14.0]}]];
    
    UILabel *lb_time = [[UILabel alloc] initWithFrame:CGRectZero];
    lb_time.translatesAutoresizingMaskIntoConstraints = NO;
    lb_time.textAlignment = NSTextAlignmentCenter;
    lb_time.attributedText = time_str;
    lb_time.backgroundColor = [UIColor clearColor];
    [_viewBottomBar addSubview:lb_time];
    
    [_viewBottomBar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-6-[btn_back(30)]-0-[lb_time_t]-0-[btn_go]|"
                                                                           options:0
                                                                           metrics:nil
                                                                             views:@{@"btn_back":btn_back,@"lb_time_t":lb2,@"btn_go":btn}]];
    
    [_viewBottomBar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-6-[btn_back(30)]-0-[lb_time]-0-[btn_go]|"
                                                                           options:0
                                                                           metrics:nil
                                                                             views:@{@"btn_back":btn_back,@"lb_time":lb_time,@"btn_go":btn}]];
    
    [_viewBottomBar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-16-[lb_time_t]-3-[lb_time]"
                                                                           options:0
                                                                           metrics:nil
                                                                             views:@{@"lb_time_t":lb2,@"lb_time":lb_time}]];
}

- (void)btnCancelFetchCarClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)btnFetchCarClick
{
    [self showPaymentInfo];
}

#pragma mark -

- (void)showPaymentInfo
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
    NSMutableAttributedString *charge_str = [[NSMutableAttributedString alloc] initWithString:@"¥ "
                                                                                   attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],
                                                                                                NSFontAttributeName:[UIFont systemFontOfSize:14.0]}];
    
    [charge_str appendAttributedString:[[NSAttributedString alloc] initWithString:@"89"
                                                                       attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],
                                                                                    NSFontAttributeName:[UIFont systemFontOfSize:25.0]}]];
    
    [charge_str appendAttributedString:[[NSAttributedString alloc] initWithString:@" 元"
                                                                       attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],
                                                                                    NSFontAttributeName:[UIFont systemFontOfSize:14.0]}]];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.translatesAutoresizingMaskIntoConstraints = NO;
    btn.titleLabel.numberOfLines = 2;
    btn.backgroundColor = [UIColor colorWithRed:0.33 green:0.36 blue:0.49 alpha:1.0];
    [btn setAttributedTitle:charge_str forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:COLOR_TEXT_GREEN forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(btnPayClick:) forControlEvents:UIControlEventTouchUpInside];
    [_viewBottomBar addSubview:btn];
    
    [_viewBottomBar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[btn_go(82)]|"
                                                                           options:0
                                                                           metrics:nil
                                                                             views:@{@"btn_go":btn}]];
    
    [_viewBottomBar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-12-[btn_go]|"
                                                                           options:0
                                                                           metrics:nil
                                                                             views:@{@"btn_go":btn}]];
    
    UIImage *im = [UIImage imageNamed:@"test-driver"];
    UIButton *btn_avator = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_avator.frame = CGRectMake(17, 5, 80, 80);
    [btn_avator setImage:im forState:UIControlStateNormal];
    [btn_avator addTarget:self action:@selector(btnAvatorClick) forControlEvents:UIControlEventTouchUpInside];
    [_viewBottomBar addSubview:btn_avator];
    
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
    
    [time_str appendAttributedString:[[NSAttributedString alloc] initWithString:@" 分钟"
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

- (void)btnPayClick:(UIButton *)sender
{
    
}

@end
