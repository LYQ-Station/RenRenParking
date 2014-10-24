//
//  UIBarButtonItem+Theme.m
//  PigParking
//
//  Created by Vincent on 7/7/14.
//  Copyright (c) 2014 VincentStation. All rights reserved.
//

#import "UIBarButtonItem+Theme.h"

@implementation UIBarButtonItem (Theme)

- (id)initWithBarButtonThemeItem:(UIBarButtonThemeItem)item target:(id)target action:(SEL)action
{
    UIImage *img = nil;
//    UIImage *img_h = nil;
    
    switch (item)
    {
        case UIBarButtonThemeItemOK:
            img = [UIImage imageNamed:@"nav-item-ok"];
            break;
            
        case UIBarButtonThemeItemBack:
            img = [UIImage imageNamed:@"nav-item-back"];
            break;
            
        case UIBarButtonThemeItemSave:
            img = [UIImage imageNamed:@"nav-item-save"];
            break;
            
        case UIBarButtonThemeItemList:
            img = [UIImage imageNamed:@"nav-item-list"];
            break;
            
        case UIBarButtonThemeItemFilter:
            img = [UIImage imageNamed:@"nav-item-filter"];
            break;
            
        case UIBarButtonThemeItemUp:
            img = [UIImage imageNamed:@"nav-item-up"];
            break;
            
        case UIBarButtonThemeItemClear:
            img = [UIImage imageNamed:@"nav-item-clear"];
            break;
    }
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.bounds = CGRectMake(0.0f, 0.0f, img.size.width, img.size.height);
    [btn setImage:img forState:UIControlStateNormal];
    [btn setImage:img forState:UIControlStateHighlighted];
    btn.enabled = YES;
    
    self = [self initWithCustomView:btn];
    
    return self;
}

- (id)initWithTitle:(NSString *)title target:(id)target action:(SEL)action
{
    CGFloat fs = 0.0;
    CGSize s = [title sizeWithFont:FONT_NORMAL minFontSize:10.0 actualFontSize:&fs forWidth:100 lineBreakMode:NSLineBreakByWordWrapping];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.bounds = CGRectMake(0.0f, 0.0f, s.width+20.0, s.height);
    btn.titleLabel.font = FONT_NORMAL;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:COLOR_TEXT_GREEN forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    btn.enabled = YES;
    
    self = [self initWithCustomView:btn];
    
    return self;
}

@end
