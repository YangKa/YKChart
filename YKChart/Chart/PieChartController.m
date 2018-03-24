//
//  PieChartController.m
//  YKChart
//
//  Created by qiager on 2018/3/23.
//  Copyright © 2018年 yangka. All rights reserved.
//

#import "PieChartController.h"
#import "YKPieChart.h"

@interface PieChartController (){
    YKPieChart *pieChart;
}

@end

@implementation PieChartController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    pieChart = [[YKPieChart alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 400)
                                                   titles:@[@"科目一", @"科目二", @"科目三", @"科目四", @"科目五"]
                                                  values:@[@11, @55, @30, @20, @40]
                                                  colors:nil];
    pieChart.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:pieChart];
    
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

    [pieChart resetTitles:@[@"课程一", @"课程二", @"课程三", @"课程四"]
                   values:@[@21, @35, @40, @20]
                   colors:nil];
}


- (void)dimisss{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
