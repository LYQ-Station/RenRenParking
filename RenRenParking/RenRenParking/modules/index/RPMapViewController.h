//
//  RPMapViewController.h
//  RenRenParking
//
//  Created by LiYongQiang on 14/10/27.
//  Copyright (c) 2014年 CoderFly. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    RPMapViewControllerModeParking,
    RPMapViewControllerModeFetchCar
} RPMapViewControllerMode;

typedef enum {
    RPMapViewControllerStatusNone,
    RPMapViewControllerStatusOuterInfo,
    RPMapViewControllerStatusInnerInfo,
    RPMapViewControllerStatusDriverInfo,
    RPMapViewControllerStatusFetchCarInfo,
    RPMapViewControllerStatusPaymentInfo
} RPMapViewControllerStatus;

@interface RPMapViewController : UIViewController

//@property (nonatomic, readwrite) UINavigationController *navigationController;
@property (nonatomic, readwrite) UINavigationController *navController;
@property (nonatomic, assign) id delegate;
@property (nonatomic, assign) RPMapViewControllerMode mode;

+ (UINavigationController *)navController:(id)delegate;

- (void)updateLocation;

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
