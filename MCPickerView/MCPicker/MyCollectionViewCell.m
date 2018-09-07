//
//  MyCollectionViewCell.m
//  medicalConsultDoctor
//
//  Created by qinmuqiao on 2018/9/6.
//  Copyright © 2018年 MuYaQin. All rights reserved.
//

#import "MyCollectionViewCell.h"

@implementation MyCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //添加自己需要个子视图控件
        [self setUpAllChildView];
    }
    return self;
}
- (void)setUpAllChildView
{
    self.tLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.tLb.textAlignment = NSTextAlignmentCenter;
    self.tLb.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    [self addSubview:self.tLb];
}
- (void)layoutSubviews
{
    self.tLb.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}
@end
