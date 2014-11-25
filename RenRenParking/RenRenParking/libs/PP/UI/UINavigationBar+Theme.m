//
//  UINavigationBar+Theme.m
//  PigParking
//
//  Created by Vincent on 7/7/14.
//  Copyright (c) 2014 VincentStation. All rights reserved.
//

#import "UINavigationBar+Theme.h"

@implementation UINavigationBar (Theme)

- (void)setupTheme
{
    if ([self respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
    {
        if (IS_UP_THAN_IOS7)
        {
            [self setBackgroundImage:[UIImage imageNamed:@"nav-bar-full-bg"] forBarPosition:UIBarPositionTop barMetrics:UIBarMetricsDefault];
        }
        else
        {
            [self setBackgroundImage:[UIImage imageNamed:@"nav-bar-bg"] forBarMetrics:UIBarMetricsDefault];
        }
    }
    
    if ([self respondsToSelector:@selector(setShadowImage:)])
    {
        [self setShadowImage:[[UIImage alloc] init]];
    }
}

@end
