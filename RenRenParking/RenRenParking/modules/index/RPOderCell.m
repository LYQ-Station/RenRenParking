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
@property (weak, nonatomic) IBOutlet UILabel *lbDate;
@property (weak, nonatomic) IBOutlet UILabel *lbStatus;
@property (weak, nonatomic) IBOutlet UILabel *lbContent;
@property (weak, nonatomic) IBOutlet UILabel *lbCharge;

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
    _ivBackground.image = [[UIImage imageNamed:@"idx-order-cell-bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 25, 5, 25)];
    
    _lbDate.textColor = COLOR_TEXT_LIGHT_GRAY;
    _lbStatus.textColor = COLOR_TEXT_LIGHT_GRAY;
    _lbContent.textColor = COLOR_TEXT_GRAY;
    _lbCharge.textColor = [UIColor colorWithRed:0.99 green:0.70 blue:0.17 alpha:1.0];
}

- (void)layoutSubviews
{
    _lbDate.text = _labelDateText;
    _lbStatus.text = _labelStatusText;
    _lbContent.numberOfLines = 2;
    _lbContent.text = [NSString stringWithFormat:@"停车时间：%@\n预约地点：%@", _labelTimeText, _labelPlaceText];
    
    UIColor *color_yellow = [UIColor colorWithRed:0.99 green:0.70 blue:0.17 alpha:1.0];
    
    NSMutableAttributedString *charge_str = [[NSMutableAttributedString alloc] initWithString:@"¥ "
                                                                                   attributes:@{NSForegroundColorAttributeName:color_yellow,
                                                                                                NSFontAttributeName:[UIFont systemFontOfSize:14.0]}];
    
    [charge_str appendAttributedString:[[NSAttributedString alloc] initWithString:_labelChargeText
                                                                       attributes:@{NSForegroundColorAttributeName:color_yellow,
                                                                                    NSFontAttributeName:[UIFont systemFontOfSize:25.0]}]];
    
    [charge_str appendAttributedString:[[NSAttributedString alloc] initWithString:@" 元"
                                                                       attributes:@{NSForegroundColorAttributeName:color_yellow,
                                                                                    NSFontAttributeName:[UIFont systemFontOfSize:14.0]}]];
    
    _lbCharge.attributedText = charge_str;
}

@end
