//
//  UIViewController+Theme.m
//  PigParking
//
//  Created by Vincent on 7/7/14.
//  Copyright (c) 2014 VincentStation. All rights reserved.
//

#import "UIViewController+Theme.h"

@implementation UIViewController (Theme)

- (void)setupTheme
{
    UINavigationItem *item = self.navigationItem;
    
    UILabel *title_lab = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 200.0, 44.0)];
    title_lab.tag = 101;
    title_lab.backgroundColor = [UIColor clearColor];
    title_lab.text = self.title;
    title_lab.textAlignment = NSTextAlignmentCenter;
    title_lab.textColor = [UIColor whiteColor];
    title_lab.font = [UIFont boldSystemFontOfSize:17.0f];
    item.titleView = title_lab;
    
    self.view.backgroundColor = [UIColor colorWithRed:0.96f green:0.96f blue:0.96f alpha:1.0f];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
    {
        [self setEdgesForExtendedLayout:0];
    }
    
    if (self.navigationController)
    {
        [self.navigationController.navigationBar setupTheme];
    }
}

- (void)setupLogoTheme
{
    UINavigationItem *item = self.navigationItem;
    
    UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navbar-logo"]];
    item.titleView = iv;
    
    self.view.backgroundColor = [UIColor colorWithRed:0.96f green:0.96f blue:0.96f alpha:1.0f];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
    {
        [self setEdgesForExtendedLayout:0];
    }
    
    if (self.navigationController)
    {
        [self.navigationController.navigationBar setupTheme];
    }
}

- (void)resetTitle:(NSString *)title
{
    UILabel *lb = (UILabel *)self.navigationItem.titleView;
    lb.text = title;
}

@end
