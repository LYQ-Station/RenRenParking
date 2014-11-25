//
//  RPFetchCarViewController.h
//  RenRenParking
//
//  Created by Vincent on 10/29/14.
//  Copyright (c) 2014 CoderFly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RPFetchCarViewController : UIViewController

+ (UINavigationController *)navController:(id)delegate;

//@property (nonatomic, readwrite) UINavigationController *navigationController;
@property (nonatomic, assign) id delegate;

@end
