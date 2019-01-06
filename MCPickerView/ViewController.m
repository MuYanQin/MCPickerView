//
//  ViewController.m
//  MCPickerView
//
//  Created by qinmuqiao on 2018/9/7.
//  Copyright © 2018年 MuYaQin. All rights reserved.
//

#import "ViewController.h"
#import "MCPickerView.h"
#import "MCPickerModel.h"
#import "MJExtension.h"

@interface ViewController ()<MCPickerViewDelegate>
@property (nonatomic , strong) MCPickerView *picker ;
@property (nonatomic , strong) NSMutableArray * pro;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"选择地址";
    self.pro = [NSMutableArray array];
    __weak typeof(self)weakSelf = self;
    NSString *path = [[NSBundle mainBundle]pathForResource:@"addr" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    NSArray *jsonArray = [[NSJSONSerialization JSONObjectWithData:data options:kNilOptions|NSJSONWritingPrettyPrinted error:nil] mutableCopy];
    [jsonArray enumerateObjectsUsingBlock:^(NSDictionary * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [weakSelf.pro addObject:[MCPickerModel mj_objectWithKeyValues:obj]];
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"方式1" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor purpleColor];
    [button addTarget:self action:@selector(click2One) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 100, self.view.frame.size.width, 40);
    [self.view addSubview:button];
    
}
- (void)MCPickerView:(MCPickerView *)MCPickerView completeArray:(NSMutableArray<MCPickerModel *> *)comArray completeStr:(NSString *)comStr
{
    
}
- (NSMutableArray<MCPickerModel *> *)MCPickerView:(MCPickerView *)MCPickerView didSelcetedTier:(NSInteger)tier selcetedValue:(MCPickerModel *)value
{
    __block NSMutableArray *tempTown = [NSMutableArray array];
    [value.child enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [tempTown addObject:[MCPickerModel mj_objectWithKeyValues:obj]];
    }];
    return tempTown;
}
- (void)click2One
{
    self.picker  =[[MCPickerView alloc]initWithFrame:self.view.bounds];
    self.picker.delegate = self;
    self.picker.titleText = @"选择区域";
    self.picker.dataArray = self.pro;
    [self.view addSubview:self.picker];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
