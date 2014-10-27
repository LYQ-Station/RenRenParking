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

- (void)showServiceInfo
{
    
}

@end
