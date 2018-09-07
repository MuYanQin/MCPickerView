//
//  MCPickerHeaderView.h
//  medicalConsultDoctor
//
//  Created by qinmuqiao on 2018/9/6.
//  Copyright © 2018年 MuYaQin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MCPickerHeaderView;
@protocol MCPickerHeaderViewDelegate<NSObject>
- (void)MCPickerHeaderView:(MCPickerHeaderView *)MCPickerHeaderView didSelcetIndex:(NSInteger )index;
@end
@interface MCPickerHeaderView : UIView
@property (nonatomic , weak) id<MCPickerHeaderViewDelegate> dalegate;
@property (nonatomic , strong) NSArray * dataArray;
@property (nonatomic , assign) BOOL  isLastRed;//最后一个时候是红色

- (void)setindex:(NSInteger )index;
@end
