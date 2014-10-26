//
//  RPOderCell.m
//  RenRenParking
//
//  Created by LiYongQiang on 14/10/25.
//  Copyright (c) 2014年 CoderFly. All rights reserved.
//

#import "RPOderCell.h"

@interface RPOderCell ()

@property (weak, nonatomic) IBOutlet UIImageView *ivBackground;

@end

@implementation RPOderCell

+ (CGFloat)height
{
    return 117.0;
}

+ (RPOderCell *)cell
{
    return [[[NSBundle mainBundle] loadNibNamed:@"RPOderCell" owner:self options:nil] objectAtIndex:0];
}

- (void)awakeFromNib
{
//    _ivBackground.image = [[UIImage imageNamed:@"idx-order-cell-bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 25, 5, 25)];
}

@end
