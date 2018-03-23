//
//  PieChartController.m
//  YKChart
//
//  Created by qiager on 2018/3/23.
//  Copyright © 2018年 yangka. All rights reserved.
//

#import "PieChartController.h"
#import "YKPieChart.h"

@interface PieChartController ()

@end

@implementation PieChartController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    YKPieChart *pieChart = [[YKPieChart alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 400)
                                                   titles:@[@"科目一", @"科目二", @"科目三", @"科目四", @"科目五"]
                                                  values:@[@11, @55, @30, @20, @40]
                                                  colors:nil];
    pieChart.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:pieChart];
    
    
    //
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    button.backgroundColor = [UIColor blueColor];
    button.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height - 60);
    [button setTitle:@"Dismiss" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(dimisss) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)dimisss{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
