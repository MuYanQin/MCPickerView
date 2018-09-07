//
//  MCPickerListView.h
//  medicalConsultDoctor
//
//  Created by qinmuqiao on 2018/9/6.
//  Copyright © 2018年 MuYaQin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MCPickerListView;
@class MCPickerModel;
@protocol MCPickerListViewDelegate<NSObject>
- (void)MCPickerListView:(MCPickerListView *)MCPickerListView didSelcetedValue:(MCPickerModel *)Value;
@end
@interface MCPickerListView : UIView

/**
 数据源
 */
@property (nonatomic , strong) NSArray * dataArray;

/**
 已选择的字符串
 */
@property (nonatomic , copy) NSString * selectText;
@property (nonatomic , weak) id<MCPickerListViewDelegate>  delegate;
@end
