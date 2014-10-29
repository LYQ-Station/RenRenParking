//
//  RPFetchCarViewController.m
//  RenRenParking
//
//  Created by Vincent on 10/29/14.
//  Copyright (c) 2014 CoderFly. All rights reserved.
//

#import "RPFetchCarViewController.h"
#import "RPMapViewController.h"

@interface RPFetchCarViewController ()

@property (nonatomic, assign) id delegate;

@property (weak, nonatomic) IBOutlet UILabel *lbTitle1;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle2;
@property (weak, nonatomic) IBOutlet UIImageView *ivCar;

@end

@implementation RPFetchCarViewController

+ (UINavigationController *)navController
{
    RPFetchCarViewController *c = [[RPFetchCarViewController alloc] initWithNibName:nil bundle:nil];
    
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:c];
    return nc;
}

+ (UINavigationController *)navController:(id)delegate
{
    RPFetchCarViewController *c = [[RPFetchCarViewController alloc] initWithNibName:nil bundle:nil];
    c.delegate = delegate;
    
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:c];
    return nc;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupLogoTheme];
    
        //
    _lbTitle1.font = FONT_NORMAL;
    _lbTitle1.textColor = COLOR_TEXT_GRAY;
    
    _lbTitle2.font = FONT_NORMAL;
    _lbTitle2.textColor = COLOR_TEXT_GRAY;
    
    _ivCar.image = [UIImage imageNamed:@"fetch-placeholder"];
    
    UIImageView *viewBottomBar = [[UIImageView alloc] initWithFrame:CGRectZero];
    viewBottomBar.userInteractionEnabled = YES;
    viewBottomBar.translatesAutoresizingMaskIntoConstraints = NO;
    viewBottomBar.image = [[UIImage imageNamed:@"map-bottom-bar-bg-green"] resizableImageWithCapInsets:UIEdgeInsetsMake(20.0, 0, 0, 0)];
    [self.view addSubview:viewBottomBar];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[bot_bar]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:@{@"bot_bar":viewBottomBar}]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[bot_bar(81.0)]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:@{@"bot_bar":viewBottomBar}]];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.translatesAutoresizingMaskIntoConstraints = NO;
    [btn setTitle:NSLocalizedString(@"现在用车", nil) forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:COLOR_TEXT_GREEN forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(btnFetchCarClick) forControlEvents:UIControlEventTouchUpInside];
    [viewBottomBar addSubview:btn];
    
    [viewBottomBar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[btn_go]|"
                                                                           options:0
                                                                           metrics:nil
                                                                             views:@{@"btn_go":btn}]];
    
    [viewBottomBar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-6-[btn_go]|"
                                                                           options:0
                                                                           metrics:nil
                                                                             views:@{@"btn_go":btn}]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

- (void)btnFetchCarClick
{
    RPMapViewController *c = [[RPMapViewController alloc] initWithNibName:nil bundle:nil];
    c.delegate = _delegate;
    [self.navigationController pushViewController:c animated:YES];
    [c showFetchCarInfo];
}


@end
