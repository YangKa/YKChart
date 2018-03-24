//
//  ViewController.m
//  YKChart
//
//  Created by qiager on 2018/3/22.
//  Copyright © 2018年 yangka. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>{
    NSArray *_chartClassList;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    _chartClassList = @[@{@"name":@"图表一",
                          @"class":@"CircleChartController"
                          },
                        @{@"name":@"图表二",
                          @"class":@"PieChartController"
                          },
                        @{@"name":@"图表三",
                          @"class":@"LineChartController"
                          },
                        @{@"name":@"图表四",
                          @"class":@"BarChartController"
                          }];
    [self addTableView];
}

- (void)addTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _chartClassList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.textLabel.text  = [_chartClassList[indexPath.row] objectForKey:@"name"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *className =  [_chartClassList[indexPath.row] objectForKey:@"class"];
    [self presentClass:NSClassFromString(className)];
   
}

- (void)presentClass:(Class)class{
    UIViewController *VC = [[class alloc] init];
    [self presentViewController:VC animated:YES completion:nil];
}


@end
