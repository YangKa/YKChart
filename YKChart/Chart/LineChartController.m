
//
//  LineChartController.m
//  YKChart
//
//  Created by qiager on 2018/3/23.
//  Copyright © 2018年 yangka. All rights reserved.
//

#import "LineChartController.h"
#import "YKLineChart.h"

@interface LineChartController (){
    YKLineChart *lineChart;
}

@end

#define RandomColor [UIColor colorWithRed:(arc4random_uniform(255)/255.0) green:(arc4random_uniform(255)/255.0) blue:(arc4random_uniform(255)/255.0) alpha:1]

@implementation LineChartController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
   
    //
    
    [self addLineChart];
    //
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    button1.backgroundColor = [UIColor blueColor];
    button1.center = CGPointMake(100, self.view.frame.size.height - 60);
    [button1 setTitle:@"refresh" forState:UIControlStateNormal];
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


- (void)addLineChart{
    
    NSArray *list = @[@"一月", @"二月", @"三月", @"四月", @"五月", @"六月"];
    YKHorizontalAxis *HAxis = [[YKHorizontalAxis alloc] initWithAxisType:YKHorizontalAxisType_String
                                                              interValue:0
                                                                  values:list
                               ];
    
    YKVerticalAxis *VAxis = [[YKVerticalAxis alloc] initWithAxisType:YKVerticalAxisType_Percent
                                                          interValue:10];
    
    NSArray *names = @[@"科目一", @"科目二", @"科目三", @"科目四"];
    NSMutableArray *lines = [NSMutableArray array];
    for (int i = 0; i < names.count; i++) {
        
        NSMutableArray *points = [NSMutableArray array];
        for (int j = 0; j < list.count; j++) {
            YKPoint *point = [YKPoint linePointWithXValue:list[i] YValue:random()%100];
            [points addObject:point];
        }
        
        YKLine *line = [[YKLine alloc] initWithPoints:points name:names[i] color:RandomColor];
        [lines addObject:line];
    }
    
    lineChart = [[YKLineChart alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, 300)
                                    horizontalAxis:HAxis
                                      verticalAxis:VAxis
                                             lines:lines
                                              type:YKLineChartType_Line];
    lineChart.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:lineChart];
}

- (void)refresh{
    NSArray *list = @[@"一月", @"二月", @"三月", @"四月", @"五月"];
    YKHorizontalAxis *HAxis = [[YKHorizontalAxis alloc] initWithAxisType:YKHorizontalAxisType_String
                                                              interValue:0
                                                                  values:list
                               ];
    
    YKVerticalAxis *VAxis = [[YKVerticalAxis alloc] initWithAxisType:YKVerticalAxisType_Percent
                                                          interValue:10];
    
    NSArray *names = @[@"科目一", @"科目二", @"科目三"];
    NSMutableArray *lines = [NSMutableArray array];
    for (int i = 0; i < names.count; i++) {
        
        NSMutableArray *points = [NSMutableArray array];
        for (int j = 0; j < list.count; j++) {
            YKPoint *point = [YKPoint linePointWithXValue:list[i] YValue:random()%100];
            [points addObject:point];
        }
        
        YKLine *line = [[YKLine alloc] initWithPoints:points name:names[i] color:RandomColor];
        [lines addObject:line];
    }
    
    
    [lineChart resetWithHorizontalAxis:HAxis verticalAxis:VAxis lines:lines];
}


- (void)dimisss{
    [self dismissViewControllerAnimated:YES completion:nil];
}





@end
