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
@interface ViewController ()<MCPickerViewDelegate>
@property (nonatomic , strong)  __block NSMutableArray *province;
@property (nonatomic , strong)  __block NSMutableArray *city;
@property (nonatomic , strong)  __block NSMutableArray *town;
@end

@implementation ViewController
{
    MCPickerView *picker;
    MCPickerView *picker1;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"方式1" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor purpleColor];
    [button addTarget:self action:@selector(click2One) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 100, self.view.frame.size.width, 40);
    [self.view addSubview:button];
    
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setTitle:@"方式2" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button1.backgroundColor = [UIColor purpleColor];
    [button1 addTarget:self action:@selector(click2Two) forControlEvents:UIControlEventTouchUpInside];
    button1.frame = CGRectMake(0, 170, self.view.frame.size.width, 40);
    [self.view addSubview:button1];
    

}
- (void)click2Two
{
    //初始化数据
    self.province = [NSMutableArray array];
    for (int i=0; i<10; i++) {
        MCPickerModel *model = [[MCPickerModel alloc]init];
        model.name = [NSString stringWithFormat:@"安徽省%d",i];
        model.pid = @"123";
        [self.province addObject:model];
    }

    //
    picker = [[MCPickerView alloc]initWithFrame:self.view.bounds];
    //无默认值的采用如下方式
    picker.dataArray = self.province;
    picker.delegate = self;
    picker.totalLevel = 3;//共有3层数据
    picker.titleText = @"选择地区";
    [self.view addSubview:picker];
}
- (void)click2One
{
    
    //初始化数据
    self.province = [NSMutableArray array];
    for (int i=0; i<10; i++) {
        MCPickerModel *model = [[MCPickerModel alloc]init];
        model.name = [NSString stringWithFormat:@"安徽省%d",i];
        model.pid = @"123";
        [self.province addObject:model];
    }
    self.city = [NSMutableArray array];
    for (int i=0; i<5; i++) {
        MCPickerModel *model = [[MCPickerModel alloc]init];
        model.name = [NSString stringWithFormat:@"合肥市%d",i];
        model.pid = @"123";
        [self.city addObject:model];
    }
    
    //
    picker = [[MCPickerView alloc]initWithFrame:self.view.bounds];
    //初始化有默认值的采用如下方式
    [picker setData:self.province selectText:@"安徽省1"];
    [picker setData:self.city selectText:@"合肥市3"];
    picker.delegate = self;
    picker.totalLevel = 3;//共有3层数据
    picker.titleText = @"选择地区";
    [self.view addSubview:picker];
}

- (void)MCPickerView:(MCPickerView *)MCPickerView complete:(NSString *)complete
{
    NSLog(@"===%@",complete);
}
- (void)MCPickerView:(MCPickerView *)MCPickerView didSelcetedRow:(NSInteger)Row value:(MCPickerModel *)value
{
    if (Row == 0) {
        __block NSMutableArray *models = [NSMutableArray array];
        for (int i=0; i<5; i++) {
            MCPickerModel *model = [[MCPickerModel alloc]init];
            model.name = [NSString stringWithFormat:@"合肥市%d",i];
            model.pid = @"123";
            [models addObject:model];
        }
        picker.dataArray = models;
    }else if(Row == 1){
        __block NSMutableArray *models = [NSMutableArray array];
        for (int i=0; i<5; i++) {
            MCPickerModel *model = [[MCPickerModel alloc]init];
            model.name = [NSString stringWithFormat:@"蜀山区%d",i];
            model.pid = @"123";
            [models addObject:model];
        }
        picker.dataArray = models;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
