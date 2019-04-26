//
//  MVPickerView.m
//  medicalConsultDoctor
//
//  Created by qinmuqiao on 2018/9/6.
//  Copyright © 2018年 MuYaQin. All rights reserved.
//

#import "MCPickerView.h"
#import "MCPickerListView.h"
#import "MCPickerHeaderView.h"
#import "MCPickerModel.h"
static NSInteger const headerHeight = 30;//headerView的高度
static NSInteger const ScrollViewY = 70;//ScrollViewY Y坐标起始位
static NSInteger const PickerViewHeight = 350;//

@interface MCPickerView ()<MCPickerListViewDelegate,MCPickerHeaderViewDelegate,MCPickerHeaderViewDelegate,UIScrollViewDelegate>
@property (nonatomic , strong) UIScrollView * ScrollView;
@property (nonatomic , strong) UILabel * TitleLb;
@property (nonatomic , strong) MCPickerHeaderView *header;
@property (nonatomic , strong) NSMutableArray * headerDataArray;//装有title的数组
@property (nonatomic , strong) NSMutableArray * listViewArray;//装有listView的数组
@property (nonatomic , strong) NSMutableArray * dataArrays;//装有数据数组的数组
@end
@implementation MCPickerView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.alpha = 0;
        self.headerDataArray = [NSMutableArray array];
        self.listViewArray = [NSMutableArray array];
        self.dataArrays = [NSMutableArray array];
        [self initForm];
    }
    return self;
}
- (void)initForm
{
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 1;
    }];
    
    UIView * BGView = [[UIView alloc]initWithFrame:self.bounds];
    BGView.backgroundColor = [UIColor blackColor];
    BGView.alpha = 0.5;
    [self addSubview:BGView];
    
    UIView *ContentView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 350 - MCBottomDistance, self.frame.size.width, 350)];
    ContentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:ContentView];
    
    self.TitleLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 10,self.frame.size.width , 15)];
    self.TitleLb.textColor = [UIColor grayColor];
    self.TitleLb.textAlignment = NSTextAlignmentCenter;
    self.TitleLb.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    [ContentView addSubview:self.TitleLb];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(self.frame.size.width - 60, 0, 60, 40);
    [button setImage:[UIImage imageNamed:@"MCClose"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(hiddenClick) forControlEvents:UIControlEventTouchUpInside];
    [ContentView addSubview:button];
    
    self.header = [[MCPickerHeaderView alloc]initWithFrame:CGRectMake(0, 40, self.frame.size.width, headerHeight)];
    self.header.backgroundColor = [UIColor whiteColor];
    self.header.dalegate = self;
    self.header.dataArray = @[@"请选择"];
    self.header.isLastRed = YES;
    [ContentView addSubview:self.header];
    
    [ContentView  addSubview:self.ScrollView];
}
//scrollview滑动结束
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int index = (int)(scrollView.contentOffset.x/self.frame.size.width);
    [self.header setindex:index];
}
//headerView头部点击
- (void)MCPickerHeaderView:(MCPickerHeaderView *)MCPickerHeaderView didSelcetIndex:(NSInteger)index
{
    [self.ScrollView setContentOffset:CGPointMake(self.frame.size.width*index,0) animated:YES];
}
//listView列表点击
- (void)MCPickerListView:(MCPickerListView *)MCPickerListView didSelcetedValue:(MCPickerModel *)value
{
    self.dataArrays  = [self.dataArrays subarrayWithRange:NSMakeRange(0, MCPickerListView.tag + 1)].mutableCopy;
    self.headerDataArray  = [self.headerDataArray subarrayWithRange:NSMakeRange(0, MCPickerListView.tag)].mutableCopy;
    [self.headerDataArray addObject:value.name];
    [self.headerDataArray addObject:@"请选择"];
    
    NSMutableArray<MCPickerModel *> * array;
    if ([self.delegate respondsToSelector:@selector(MCPickerView:didSelcetedTier:selcetedValue:)]) {
        array =  [self.delegate MCPickerView:self didSelcetedTier:MCPickerListView.tag selcetedValue:value];
        if (array.count>0) {
            self.dataArray = array;
        }
    }
    if (array.count ==0 ) {
        [self.headerDataArray removeLastObject];
        [self hiddenClick];
    }
    if (array.count ==0 && [self.delegate respondsToSelector:@selector(MCPickerView:completeArray:completeStr:)]) {
        [self.delegate MCPickerView:self completeArray:self.headerDataArray completeStr:[self.headerDataArray componentsJoinedByString:@""]];
    }
    self.header.dataArray = self.headerDataArray;
}
- (UIScrollView *)ScrollView
{
    if (!_ScrollView) {
        _ScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,ScrollViewY, self.frame.size.width, PickerViewHeight  - ScrollViewY)];
        _ScrollView.pagingEnabled = YES;
        _ScrollView.delegate = self;
    }
    return _ScrollView;
}
- (void)setDataArray:(NSArray<MCPickerModel *> *)dataArray
{
    [self manageDataArray:dataArray selectText:@""];
}
- (void)setTitleText:(NSString *)titleText
{
    self.TitleLb.text = titleText;
}
- (void)setData:(NSArray<MCPickerModel *> *)dataArray selectText:(NSString *)Text
{
    [self.headerDataArray addObject:Text];
    [self.headerDataArray removeObject:@"请选择"];
    self.header.dataArray = self.headerDataArray;
    [self manageDataArray:dataArray selectText:Text];
}
- (void)manageDataArray:(NSArray *)dataArray  selectText:(NSString *)Text
{
    [self.dataArrays addObject:dataArray];
    
    MCPickerListView * ListView = [[MCPickerListView alloc]initWithFrame:CGRectMake((self.frame.size.width *(self.dataArrays.count - 1)),0,self.frame.size.width, PickerViewHeight  - ScrollViewY)];
    ListView.delegate = self;
    ListView.tag = self.dataArrays.count - 1;
    ListView.selectText = Text;
    ListView.dataArray = dataArray;
    [self.ScrollView addSubview:ListView];
    self.ScrollView.contentSize = CGSizeMake(self.frame.size.width *self.dataArrays.count, 0);
    [self.ScrollView setContentOffset:CGPointMake((self.frame.size.width *(self.dataArrays.count - 1)),0) animated:YES];
    NSArray *tempArray = self.listViewArray.copy;
    [tempArray enumerateObjectsUsingBlock:^(MCPickerListView * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx >= self.dataArrays.count-1) {
            [obj removeFromSuperview];
            [self.listViewArray removeObject:obj];
        }
    }];
    [self.listViewArray addObject:ListView];
    
}
- (void)hiddenClick
{
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
@end
