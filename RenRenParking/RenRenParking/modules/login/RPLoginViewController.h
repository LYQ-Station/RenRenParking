//
//  RPLoginViewController.h
//  RenRenParking
//
//  Created by LiYongQiang on 14/10/23.
//  Copyright (c) 2014年 CoderFly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RPLoginViewController : UIViewController

@property (nonatomic, assign) id delegate;

+ (UINavigationController *)navController:(id)delegate;

@end

@protocol RPLoginViewControllerDelegate <NSObject>

@optional
- (void)loginViewControllerDidSuccess:(RPLoginViewController *)controller;

- (void)loginViewControllerDidCancel:(RPLoginViewController *)controller;

@end
