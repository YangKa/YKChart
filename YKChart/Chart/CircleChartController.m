//
//  CircleChartController.m
//  YKChart
//
//  Created by qiager on 2018/3/22.
//  Copyright © 2018年 yangka. All rights reserved.
//

#import "CircleChartController.h"
#import "YKCircleView.h"

@interface CircleChartController (){
    YKCircleView *circleView;
}

@end

@implementation CircleChartController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    NSMutableArray *list1 = [NSMutableArray array];
    NSArray *values = @[@60, @50, @100, @40, @10];
    NSArray *titles = @[@"分类一", @"分类二", @"分类三", @"分类四", @"分类五"];
    for (int i =0; i<values.count; i++) {
        YKDataModel *model = [[YKDataModel alloc] init];
        model.name = titles[i];
        model.value = [values[i] floatValue];
        [list1 addObject:model];
    }
    
    circleView = [[YKCircleView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width)
                                                       pieList:list1
                                                     pieColors:nil
                                                      loopList:list1
                                                    loopColors:nil];
    circleView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:circleView];
    
    [circleView display];
    
    //
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    button1.backgroundColor = [UIColor blueColor];
    button1.center = CGPointMake(100, self.view.frame.size.height - 60);
    [button1 setTitle:@"Dismiss" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(refresh) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    button.backgroundColor = [UIColor blueColor];
    button.center = CGPointMake(self.view.frame.size.width - 100, self.view.frame.size.height - 60);
    [button setTitle:@"Dismiss" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(dimisss) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)refresh{
    NSMutableArray *list1 = [NSMutableArray array];
    NSArray *values = @[@10, @20, @40, @30];
    NSArray *titles = @[@"课程一", @"课程二", @"分课程三", @"课程四"];
    for (int i =0; i<values.count; i++) {
        YKDataModel *model = [[YKDataModel alloc] init];
        model.name = titles[i];
        model.value = [values[i] floatValue];
        [list1 addObject:model];
    }
    [circleView resetPieList:list1 pieColors:nil loopList:list1 loopColors:nil];
}


- (void)dimisss{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
