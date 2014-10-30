//
//  RPMapViewController.h
//  RenRenParking
//
//  Created by LiYongQiang on 14/10/27.
//  Copyright (c) 2014年 CoderFly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RPMapViewController : UIViewController

@property (nonatomic, assign) id delegate;

+ (UINavigationController *)navController;

+ (UINavigationController *)navController:(id)delegate;

- (void)showOuterInfo;

- (void)showFetchCarInfo;

- (void)showPaymentInfo;

@end

@protocol RPMapViewControllerDelegate <NSObject>

@optional
- (void)mapViewControllerDidOrderSubmit:(RPMapViewController *)controller;

- (void)mapViewControllerDidOrderCancel:(RPMapViewController *)controller;

- (void)mapViewControllerDidDriverReceiveCar:(RPMapViewController *)controller;

- (void)mapViewControllerDidPaymentSuccess:(RPMapViewController *)controller;

@end
