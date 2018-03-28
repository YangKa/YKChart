//
//  ViewController.m
//  YKECharts
//
//  Created by qiager on 2018/3/28.
//  Copyright © 2018年 yangka. All rights reserved.
//

#import "ViewController.h"

#import "YKECharts.h"

@interface ViewController ()<YKEChartsDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    
    YKECharts *chartView = [[YKECharts alloc] initWithFrame:CGRectMake(0, 30, self.view.frame.size.width, 300) delegate:self];
    [chartView drawChartWithOptions:[self options]];
    [self.view addSubview:chartView];
    
    
    YKECharts *chartView1 = [[YKECharts alloc] initWithFrame:CGRectMake(0, 350, self.view.frame.size.width, 250) delegate:self];
    [chartView1 drawChartWithOptions:[self option1]];
    [self.view addSubview:chartView1];
    
}

- (void)didDrawFinishedForChartView:(YKECharts *)chartView{
    NSLog(@"绘制完成");
}


- (NSDictionary*)options{
    
    YKChartOptions *options = [[YKChartOptions alloc] init];
    
    options.title = @{@"text": @"折线图堆叠"};
    options.tooltip = @{@"trigger":@"axis"};
    options.legend = @{@"orient": @"horizontal",
                       @"y": @"bottom",
                       @"data":@[@"邮件营销",@"联盟广告",@"视频广告",@"直接访问",@"搜索引擎"]};
    options.grid = @{@"left": @"3%",
                     @"right": @"4%",
                     @"bottom": @"8%",
                     @"containLabel": @true};
    options.toolbox = @{@"feature":@{@"saveImage":@{}}};
    options.xAxis = @{@"type": @"category",
                      @"boundaryGap": @false,
                      @"data": @[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"]};
    options.yAxis = @{@"type":@"value"};
    
    YKSeriseItem *item = [[YKSeriseItem alloc] init];
    item.name = @"邮件营销";
    item.type = @"line";
    item.stack = @"总量";
    item.data  = @[@120, @132, @101, @134, @90, @230, @210];
    
    YKSeriseItem *item1 = [[YKSeriseItem alloc] init];
    item1.name = @"联盟广告";
    item1.type = @"line";
    item1.stack = @"总量";
    item1.data  = @[@220, @182, @191, @234, @290, @330, @310];
    
    YKSeriseItem *item2 = [[YKSeriseItem alloc] init];
    item2.name = @"视频广告";
    item2.type = @"line";
    item2.stack = @"总量";
    item2.data  = @[@150, @232, @201, @154, @190, @330, @410];
    
    YKSeriseItem *item3 = [[YKSeriseItem alloc] init];
    item3.name = @"直接访问";
    item3.type = @"line";
    item3.stack = @"总量";
    item3.data  = @[@320, @332, @301, @334, @390, @330, @320];
    
    YKSeriseItem *item4 = [[YKSeriseItem alloc] init];
    item4.name = @"搜索引擎";
    item4.type = @"line";
    item4.stack = @"总量";
    item4.data  = @[@820, @932, @901, @934, @1290, @1330, @1320];
    
    options.series = @[item, item1, item2, item3, item4];
    
    return [options convertToDic];
}



- (NSDictionary*)option1{
    
    
    YKChartOptions *options = [[YKChartOptions alloc] init];
    
    options.title = @{@"text": @"嵌套环形图"};
    options.tooltip = @{@"trigger":@"item",
                        @"formatter":@"{a} <br/>{b}: {c} ({d}%)"};
    options.legend = @{@"orient": @"horizontal",
                       @"y": @"bottom",
                       @"data":@[@"直达",@"营销广告",@"搜索引擎",@"邮件营销",@"联盟广告",@"视频广告",@"百度",@"谷歌",@"必应",@"其他"]};
    
    YKSeriseItem *item = [[YKSeriseItem alloc] init];
    item.name = @"访问来源";
    item.type = @"pie";
    item.selectedMode = @"single";
    item.radius = @[@0, @"35%"];
    item.label = @{@"normal":@{@"position":@"inner"}};
    item.labelLine = @{@"normal":@{@"show":@false}};
    item.data  = @[@{@"value":@335, @"name":@"直达", @"selected":@true},
                   @{@"value":@679, @"name":@"营销广告"},
                   @{@"value":@1548, @"name":@"搜索引擎"}];
    
    YKSeriseItem *item1 = [[YKSeriseItem alloc] init];
    item1.name = @"访问来源";
    item1.type = @"pie";
    item1.radius = @[@"45%", @"55%"];
    item1.label = @{@"normal":@{@"formatter":@" {b|{b}:}{c}  {per|{d}%}  ",
                                @"backgroundColor": @"#eee",
                                @"borderColor": @"#aaa",
                                @"borderWidth": @1,
                                @"borderRadius": @4,
                                @"rich": @{
                                        @"a": @{
                                                @"color": @"#999",
                                                @"lineHeight": @22,
                                                @"align": @"center"
                                                },
                                        @"hr": @{
                                                @"borderColor": @"#aaa",
                                                @"width": @"100%",
                                                @"borderWidth": @0.5,
                                                @"height": @0
                                                },
                                        @"b": @{
                                                @"fontSize": @13,
                                                @"lineHeight": @20
                                                },
                                        @"per": @{
                                                @"color": @"#eee",
                                                @"backgroundColor": @"#334455",
                                                @"padding": @[@2, @4],
                                                @"borderRadius": @2
                                                }
                                        }
                                }
                    };
    item1.data  = @[@{@"value":@335, @"name":@"直达"},
                    @{@"value":@310, @"name":@"邮件营销"},
                    @{@"value":@234, @"name":@"联盟广告"},
                    @{@"value":@135, @"name":@"视频广告"},
                    @{@"value":@1048, @"name":@"百度"},
                    @{@"value":@251, @"name":@"谷歌"},
                    @{@"value":@147, @"name":@"必应"},
                    @{@"value":@102, @"name":@"其他"}];
    
    
    options.series = @[item, item1];
    
    return [options convertToDic];
}



@end

