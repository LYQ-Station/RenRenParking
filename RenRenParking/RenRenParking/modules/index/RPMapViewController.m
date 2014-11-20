//
//  RPMapViewController.m
//  RenRenParking
//
//  Created by LiYongQiang on 14/10/27.
//  Copyright (c) 2014年 CoderFly. All rights reserved.
//

#import "RPMapViewController.h"
#import "PPMapView.h"
#import "PPMapSearchTableViewController.h"

@interface RPMapViewController () <PPMapViewDelegate,UIAlertViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) UIImageView *viewTopBar;
@property (nonatomic, strong) UILabel *lbAddress;
@property (nonatomic, strong) UIButton *btnScope;
@property (nonatomic, strong) UIImageView *viewBottomBar;
@property (nonatomic, strong) UIImageView *viewCenterPin;
@property (nonatomic, assign) PPMapView *mapView;

@property (nonatomic, assign) BOOL isAutoUpdateLocation;
@property (nonatomic, assign) int currentStatus;
@property (nonatomic, weak) NSDictionary *selectedServicePlace;
@property (nonatomic, strong) NSMutableArray *servicesPlaceArray;

@property (nonatomic, strong) UIView *viewSearchBar;
@property (nonatomic, strong) UITextField *tfMapSearch;
@property (nonatomic, strong) PPMapSearchTableViewController *mapSearchTableViewController;

@end

@implementation RPMapViewController

+ (UINavigationController *)navController:(id)delegate
{
    RPMapViewController *c = [[RPMapViewController alloc] initWithNibName:nil bundle:nil];
    c.delegate = delegate;
    
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:c];
    return nc;
}

- (void)dealloc
{
    _mapView.delegate = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _currentStatus = RPMapViewControllerStatusNone;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    [self setupLogoTheme];
    
        //
    _mapView = [PPMapView mapViewWithFrame:self.view.bounds];
    _mapView.mapView.userInteractionEnabled = YES;
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
    
        //center pin
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
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[top_bar(42.0)]"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:@{@"top_bar":_viewTopBar}]];
    
        //address label
    self.lbAddress = [[UILabel alloc] initWithFrame:CGRectZero];
    _lbAddress.translatesAutoresizingMaskIntoConstraints = NO;
    _lbAddress.font = FONT_NORMAL;
    _lbAddress.textAlignment = NSTextAlignmentCenter;
    _lbAddress.backgroundColor = [UIColor clearColor];
    _lbAddress.text = NSLocalizedString(@"定位中...", nil);
    [_viewTopBar addSubview:_lbAddress];
    
    UITapGestureRecognizer *g = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapAddressBar:)];
    [_lbAddress addGestureRecognizer:g];
    _lbAddress.userInteractionEnabled = YES;
    
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
    self.viewBottomBar = [[UIImageView alloc] initWithFrame:CGRectZero];
    _viewBottomBar.userInteractionEnabled = YES;
    _viewBottomBar.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_viewBottomBar];
    
    [_mapView startUpdatingLocation];
//    [self showSearchView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

- (void)showSearchView
{
    _lbAddress.hidden = YES;
    
    self.viewSearchBar = [[UIView alloc] initWithFrame:CGRectZero];
    _viewSearchBar.translatesAutoresizingMaskIntoConstraints = NO;
    [_viewTopBar addSubview:_viewSearchBar];
    
    [_viewTopBar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[srh_bar]-42-|"
                                                                        options:0
                                                                        metrics:nil
                                                                          views:@{@"srh_bar":_viewSearchBar}]];
    
    [_viewTopBar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[srh_bar(42.0)]"
                                                                        options:0
                                                                        metrics:nil
                                                                          views:@{@"srh_bar":_viewSearchBar}]];
    
    UIButton *btn_back = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_back.translatesAutoresizingMaskIntoConstraints = NO;
    [btn_back setImage:[UIImage imageNamed:@"idx-search-back"] forState:UIControlStateNormal];
    [btn_back addTarget:self action:@selector(btnQuitSearchClick) forControlEvents:UIControlEventTouchUpInside];
    [_viewSearchBar addSubview:btn_back];
    
    self.tfMapSearch = [[UITextField alloc] initWithFrame:CGRectZero];
    _tfMapSearch.translatesAutoresizingMaskIntoConstraints = NO;
    _tfMapSearch.delegate = self;
    _tfMapSearch.returnKeyType = UIReturnKeySearch;
    _tfMapSearch.clearButtonMode = UITextFieldViewModeAlways;
    [_viewSearchBar addSubview:_tfMapSearch];
    
    [_viewSearchBar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-17-[btn_back]-15-[tf_srh]|"
                                                                        options:0
                                                                        metrics:nil
                                                                          views:@{@"btn_back":btn_back,@"tf_srh":_tfMapSearch}]];
    
    [_viewSearchBar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[btn_back(42.0)]"
                                                                        options:0
                                                                        metrics:nil
                                                                          views:@{@"btn_back":btn_back}]];
    
    [_viewSearchBar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tf_srh(42.0)]"
                                                                        options:0
                                                                        metrics:nil
                                                                          views:@{@"tf_srh":_tfMapSearch}]];
    
    if (!_mapSearchTableViewController)
    {
        self.mapSearchTableViewController = [[PPMapSearchTableViewController alloc] initWithDelegate:self];
        _mapSearchTableViewController.tableView.frame = self.view.bounds;
        _mapSearchTableViewController.tableView.contentInset = UIEdgeInsetsMake(42, 0, 0, 0);
    }
    
    [self.view insertSubview:_mapSearchTableViewController.tableView belowSubview:_viewTopBar];
    
    [_tfMapSearch becomeFirstResponder];
}

- (void)hideSearchView
{
    _lbAddress.hidden = NO;
    
    if ([_tfMapSearch isFirstResponder]) [_tfMapSearch resignFirstResponder];
    
    [_tfMapSearch removeFromSuperview];
    [_viewSearchBar removeFromSuperview];
    self.tfMapSearch = nil;
    
    [_mapSearchTableViewController.view removeFromSuperview];
}

- (void)ppMapSearchTableViewContrllerDidSelectSearchResult:(PPMapSearchTableViewController *)controller item:(id)item
{
    [self hideSearchView];
    
    CLLocationCoordinate2D coor;
    
    if (PPMapSearchTableViewControllerModeMapSDKSearch == controller.mode)
    {
        coor = ((BMKPoiInfo *)item).pt;
    }
    
    [_mapView updateUserLocation:coor];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [_mapSearchTableViewController doMapSDKSearch:textField.text];
    
    return YES;
}

#pragma mark - mapview delegate

- (void)ppMapView:(PPMapView *)mapView didUpdateToLocation:(CLLocation *)newLocation
{
    _isAutoUpdateLocation = YES;
    
    [self loadServicePlace:newLocation.coordinate];
    
    [[_btnScope viewWithTag:101] removeFromSuperview];
    _btnScope.enabled = YES;
    [_btnScope setImage:[UIImage imageNamed:@"map-btn-location"] forState:UIControlStateNormal];
    
    [_mapView updateUserLocation:newLocation.coordinate];
    [mapView doGeoSearch:newLocation.coordinate];
    
    _isAutoUpdateLocation = NO;
}

- (void)ppMapView:(PPMapView *)mapView didSelectAnnotation:(PPMapAnnoation *)annotation
{
    
}

- (void)ppMapView:(PPMapView *)mapView didDeselectAnnotation:(PPMapAnnoation *)annotation
{
    
}

- (void)ppMapvViewRegionWillChange:(PPMapView *)mapView
{
    if (!_isAutoUpdateLocation)
    {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        
        for (NSLayoutConstraint *lc in self.view.constraints)
        {
            if (lc.firstAttribute == NSLayoutAttributeBottom && lc.secondItem == _viewBottomBar)
            {
                [self.view removeConstraint:lc];
            }
            
            if (lc.firstAttribute == NSLayoutAttributeBottom && lc.firstItem == _viewBottomBar)
            {
                [self.view removeConstraint:lc];
                break;
            }
        }
        
        NSLayoutConstraint *c = [NSLayoutConstraint constraintWithItem:_viewBottomBar
                                                             attribute:NSLayoutAttributeTop
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeTop
                                                            multiplier:1
                                                              constant:self.view.frame.size.height];
        
        [self.view addConstraint:c];
        
        [UIView animateWithDuration:UINavigationControllerHideShowBarDuration
                         animations:^{
                             [self.view layoutIfNeeded];
                         }];
    }
}

- (void)ppMapViewRegionDidChange:(PPMapView *)mapView
{
    if (!_isAutoUpdateLocation)
    {
        NSDictionary *d = [self servicePlaceForCoordinate:mapView.mapView.centerCoordinate];
        
        if (!d)
        {
            [self showOuterInfo];
        }
        else
        {
            self.selectedServicePlace = d;
            [self showInnerInfo];
        }
        
        [self.view layoutIfNeeded];
        
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        
        for (NSLayoutConstraint *lc in self.view.constraints)
        {
            if (lc.firstAttribute == NSLayoutAttributeTop && lc.firstItem == _viewBottomBar)
            {
                [self.view removeConstraint:lc];
                break;
            }
        }
        
        [UIView animateWithDuration:UINavigationControllerHideShowBarDuration
                         animations:^{
                             NSLayoutConstraint *c = [NSLayoutConstraint constraintWithItem:_viewBottomBar
                                                                                  attribute:NSLayoutAttributeBottom
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:self.view
                                                                                  attribute:NSLayoutAttributeBottom
                                                                                 multiplier:1
                                                                                   constant:0];
                             
                             [self.view addConstraint:c];
                             
                             [self.view layoutIfNeeded];
                         }
                         completion:^(BOOL finished) {
                             
                             if (finished)
                             {
                                 [mapView doGeoSearch:mapView.mapView.centerCoordinate];
                             }
                         }];
    }
    else
    {
        [mapView doGeoSearch:mapView.mapView.centerCoordinate];
        
        NSDictionary *d = [self servicePlaceForCoordinate:mapView.mapView.centerCoordinate];
        
        if (!d)
        {
            [self showOuterInfo];
        }
        else
        {
            if ([d[@"id"] intValue] != [_selectedServicePlace[@"id"] intValue])
            {
                self.selectedServicePlace = d;
                [self showInnerInfo];
            }
        }
    }
    
    _isAutoUpdateLocation = NO;
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

- (void)btnQuitSearchClick
{
    [self hideSearchView];
}

- (void)onTapAddressBar:(UITapGestureRecognizer *)gesture
{
    [self showSearchView];
}

#pragma mark - 服务区外

- (void)showOuterInfo
{
    if (_currentStatus == RPMapViewControllerStatusOuterInfo)
    {
        return;
    }
    
    _currentStatus = RPMapViewControllerStatusOuterInfo;
    
    for (NSLayoutConstraint *lc in self.view.constraints)
    {
        if (lc.firstItem == _viewBottomBar || lc.secondItem == _viewBottomBar)
        {
            [self.view removeConstraint:lc];
        }
    }
    
    [_viewBottomBar removeConstraints:_viewBottomBar.constraints];
    [_viewBottomBar.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _viewBottomBar.image = [[UIImage imageNamed:@"map-bottom-bar-bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(20.0, 0, 0, 0)];
    
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
    _isAutoUpdateLocation = YES;
    
    CLLocationCoordinate2D coor = CLLocationCoordinate2DMake(22.58028, 113.87549);
    
    [self loadServicePlace:coor];
    [_mapView updateUserLocation:coor];
//    [self showInnerInfo];
}

#pragma mark - 服务区内

- (void)showInnerInfo
{
    _currentStatus = RPMapViewControllerStatusInnerInfo;
    
    for (NSLayoutConstraint *lc in self.view.constraints)
    {
        if (lc.firstItem == _viewBottomBar || lc.secondItem == _viewBottomBar)
        {
            [self.view removeConstraint:lc];
        }
    }
    
    [_viewBottomBar removeConstraints:_viewBottomBar.constraints];
    [_viewBottomBar.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _viewBottomBar.image = [[UIImage imageNamed:@"map-bottom-bar-bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(20.0, 0, 0, 0)];
    
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
    
    [charge_str appendAttributedString:[[NSAttributedString alloc] initWithString:_selectedServicePlace[@"charge"]
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
    NSMutableAttributedString *time_str = [[NSMutableAttributedString alloc] initWithString:_selectedServicePlace[@"wait_time"]
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
        
        if (_delegate && [_delegate respondsToSelector:@selector(mapViewControllerDidOrderSubmit:)])
        {
            [_delegate performSelector:@selector(mapViewControllerDidOrderSubmit:) withObject:self];
        }
    });
}

#pragma mark - 等待接车

- (void)showDriverInfo
{
    if (_currentStatus == RPMapViewControllerStatusDriverInfo)
    {
        return;
    }
    
    _currentStatus = RPMapViewControllerStatusDriverInfo;
    
    for (NSLayoutConstraint *lc in self.view.constraints)
    {
        if (lc.firstItem == _viewBottomBar || lc.secondItem == _viewBottomBar)
        {
            [self.view removeConstraint:lc];
        }
    }
    
    [_viewBottomBar removeConstraints:_viewBottomBar.constraints];
    [_viewBottomBar.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _viewBottomBar.image = [[UIImage imageNamed:@"map-bottom-bar-bg2"] resizableImageWithCapInsets:UIEdgeInsetsMake(20.0, 125.0, 0, 10.0)];
    
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
    
    
        //TODO: receive car ---------------------
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (_delegate && [_delegate respondsToSelector:@selector(mapViewControllerDidDriverReceiveCar:)])
        {
            [_delegate performSelector:@selector(mapViewControllerDidDriverReceiveCar:) withObject:self];
        }
    });
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
        
        if (_delegate && [_delegate respondsToSelector:@selector(mapViewControllerDidOrderCancel:)])
        {
            [_delegate performSelector:@selector(mapViewControllerDidOrderCancel:) withObject:self];
        }
    });
}

#pragma mark - 我要取车

- (void)showFetchCarInfo
{
    if (_currentStatus == RPMapViewControllerStatusFetchCarInfo)
    {
        return;
    }
    
    _currentStatus = RPMapViewControllerStatusFetchCarInfo;
    
    for (NSLayoutConstraint *lc in self.view.constraints)
    {
        if (lc.firstItem == _viewBottomBar || lc.secondItem == _viewBottomBar)
        {
            [self.view removeConstraint:lc];
        }
    }
    
    [_viewBottomBar removeConstraints:_viewBottomBar.constraints];
    [_viewBottomBar.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _viewBottomBar.image = [[UIImage imageNamed:@"map-bottom-bar-bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(20.0, 0, 0, 0)];
    
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
    [btn_back addTarget:self action:@selector(btnCancelFetchCarClick) forControlEvents:UIControlEventTouchUpInside];
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

#pragma mark - 支付

- (void)showPaymentInfo
{
    if (_currentStatus == RPMapViewControllerStatusPaymentInfo)
    {
        return;
    }
    
    _currentStatus = RPMapViewControllerStatusPaymentInfo;
    
    for (NSLayoutConstraint *lc in self.view.constraints)
    {
        if (lc.firstItem == _viewBottomBar || lc.secondItem == _viewBottomBar)
        {
            [self.view removeConstraint:lc];
        }
    }
    
    [_viewBottomBar removeConstraints:_viewBottomBar.constraints];
    [_viewBottomBar.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _viewBottomBar.image = [[UIImage imageNamed:@"map-bottom-bar-bg2"] resizableImageWithCapInsets:UIEdgeInsetsMake(20.0, 125.0, 0, 10.0)];
    
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
    
    {
        charge_str = [[NSMutableAttributedString alloc] initWithString:@"¥ "
                                                            attributes:@{NSForegroundColorAttributeName:COLOR_TEXT_GREEN,
                                                                         NSFontAttributeName:[UIFont systemFontOfSize:14.0]}];
        
        [charge_str appendAttributedString:[[NSAttributedString alloc] initWithString:@"89"
                                                                           attributes:@{NSForegroundColorAttributeName:COLOR_TEXT_GREEN,
                                                                                        NSFontAttributeName:[UIFont systemFontOfSize:25.0]}]];
        
        [charge_str appendAttributedString:[[NSAttributedString alloc] initWithString:@" 元"
                                                                           attributes:@{NSForegroundColorAttributeName:COLOR_TEXT_GREEN,
                                                                                        NSFontAttributeName:[UIFont systemFontOfSize:14.0]}]];
        
        [btn setAttributedTitle:charge_str forState:UIControlStateHighlighted];
    }
    
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
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"支付", nil)
                                                 message:NSLocalizedString(@"是否支付本次泊车的费用？", nil)
                                                delegate:self
                                       cancelButtonTitle:NSLocalizedString(@"取消", nil)
                                       otherButtonTitles:NSLocalizedString(@"确认", nil), nil];
    av.tag = 101;
    [av show];
}

#pragma mark -

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (101 == alertView.tag)
    {
        if (0 == buttonIndex)
        {
            return;
        }
        
        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = NSLocalizedString(@"支付成功！", nil);
        [self.view addSubview:hud];
        [hud show:YES];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hide:YES];
            
            if (_delegate && [_delegate respondsToSelector:@selector(mapViewControllerDidPaymentSuccess:)])
            {
                [_delegate performSelector:@selector(mapViewControllerDidPaymentSuccess:) withObject:self];
            }
        });
    }
}

#pragma mark -

- (void)loadServicePlace:(CLLocationCoordinate2D)userCoordinate
{
    self.servicesPlaceArray = [NSMutableArray array];
    
    [_servicesPlaceArray addObject:@{@"id":@"1",
                                     @"wait_time":@"10",
                                     @"charge":@"15",
                                     @"coordinates":@[[NSValue valueWithMKCoordinate:CLLocationCoordinate2DMake(22.590291,113.871609)],
                                                      [NSValue valueWithMKCoordinate:CLLocationCoordinate2DMake(22.586019,113.876819)],
                                                      [NSValue valueWithMKCoordinate:CLLocationCoordinate2DMake(22.58335,113.873909)],
                                                      [NSValue valueWithMKCoordinate:CLLocationCoordinate2DMake(22.585085,113.869669)],
                                                      [NSValue valueWithMKCoordinate:CLLocationCoordinate2DMake(22.584618,113.866686)],
                                                      [NSValue valueWithMKCoordinate:CLLocationCoordinate2DMake(22.586453,113.864207)]
                                                      ]
                                     }];
    
    [_servicesPlaceArray addObject:@{@"id":@"2",
                                     @"wait_time":@"16",
                                     @"charge":@"13",
                                     @"coordinates":@[[NSValue valueWithMKCoordinate:CLLocationCoordinate2DMake(22.582516,113.86065)],
                                                      [NSValue valueWithMKCoordinate:CLLocationCoordinate2DMake(22.578711,113.865249)],
                                                      [NSValue valueWithMKCoordinate:CLLocationCoordinate2DMake(22.575608,113.861907)],
                                                      [NSValue valueWithMKCoordinate:CLLocationCoordinate2DMake(22.579145,113.85756)]
                                                      ]
                                     }];
    
    [_servicesPlaceArray addObject:@{@"id":@"3",
                                     @"wait_time":@"20",
                                     @"charge":@"18",
                                     @"coordinates":@[[NSValue valueWithMKCoordinate:CLLocationCoordinate2DMake(22.583483,113.871609)],
                                                      [NSValue valueWithMKCoordinate:CLLocationCoordinate2DMake(22.579379,113.879838)],
                                                      [NSValue valueWithMKCoordinate:CLLocationCoordinate2DMake(22.576142,113.876927)],
                                                      [NSValue valueWithMKCoordinate:CLLocationCoordinate2DMake(22.580146,113.871753)]
                                                      ]
                                     }];
    
    [_mapView showAroundServicePlace:_servicesPlaceArray];
}

#pragma mark -

- (NSDictionary *)servicePlaceForCoordinate:(CLLocationCoordinate2D)coordinate
{
    for (NSDictionary *d in _servicesPlaceArray)
    {
        NSArray *arr = d[@"coordinates"];
        
        CLLocationCoordinate2D *cs = (CLLocationCoordinate2D *)malloc(sizeof(CLLocationCoordinate2D) * arr.count);
        CLLocationCoordinate2D *cs_p = cs;
        
        for (NSValue *v in arr)
        {
            *cs_p = [v MKCoordinateValue];
            cs_p++;
        }
        
        if ([_mapView isInPolygon:cs forCoordinate:coordinate count:arr.count])
        {
            free(cs);
            return d;
        }
        
        free(cs);
    }
    
    return nil;
}

@end
