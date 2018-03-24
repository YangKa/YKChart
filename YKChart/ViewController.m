//
//  ViewController.m
//  YKChart
//
//  Created by qiager on 2018/3/22.
//  Copyright © 2018年 yangka. All rights reserved.
//

#import "ViewController.h"
#import "CircleChartController.h"
#import "PieChartController.h"
#import "LineChartController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self addTableView];
}

- (void)addTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 200) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"图表一";
    }else if (indexPath.row == 1){
        cell.textLabel.text = @"图表二";
    }else if (indexPath.row == 2){
        cell.textLabel.text = @"图表三";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        CircleChartController *chartVC1 = [[CircleChartController alloc] init];
        [self presentViewController:chartVC1 animated:YES completion:nil];
    }else if (indexPath.row == 1){
        PieChartController *chartVC2 = [[PieChartController alloc] init];
        [self presentViewController:chartVC2 animated:YES completion:nil];
    }else if (indexPath.row == 2){
        LineChartController *chartVC3 = [[LineChartController alloc] init];
        [self presentViewController:chartVC3 animated:YES completion:nil];
    }
   
}


@end
