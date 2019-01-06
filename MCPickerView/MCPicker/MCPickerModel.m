//
//  MCPickerModel.m
//  medicalConsultDoctor
//
//  Created by qinmuqiao on 2018/9/6.
//  Copyright © 2018年 MuYaQin. All rights reserved.
//

#import "MCPickerModel.h"

@implementation MCPickerModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"pid" : @"id"//前边的是你想用的key，后边的是返回的key
             };
}
@end
