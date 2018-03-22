//
//  CircleChartController.m
//  YKChart
//
//  Created by qiager on 2018/3/22.
//  Copyright © 2018年 yangka. All rights reserved.
//

#import "CircleChartController.h"
#import "CircleView.h"

@interface CircleChartController ()

@end

@implementation CircleChartController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    NSMutableArray *list1 = [NSMutableArray array];
    NSArray *values = @[@60, @50, @100, @40, @10];
    NSArray *titles = @[@"分类一", @"分类二", @"分类三", @"分类四", @"分类五"];
    for (int i =0; i<values.count; i++) {
        DataModel *model = [[DataModel alloc] init];
        model.name = titles[i];
        model.value = [values[i] floatValue];
        [list1 addObject:model];
    }
    
    CircleView *circleView = [[CircleView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width)
                                                       pieList:list1
                                                     pieColors:nil
                                                      loopList:list1
                                                    loopColors:nil];
    circleView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:circleView];
    
    [circleView display];
    
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
