//
//  ViewController.m
//  YKECharts
//
//  Created by qiager on 2018/3/28.
//  Copyright © 2018年 yangka. All rights reserved.
//

#import "ViewController.h"

#import "YKEChartsView.h"

@interface ViewController ()<YKEChartsDelegate>{
    YKEChartsView *lineChartView;
    YKEChartsView *pieNestChartView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    
    lineChartView = [[YKEChartsView alloc] initWithFrame:CGRectMake(0, 30, self.view.frame.size.width, 300) delegate:self];
    [lineChartView drawChartWithOptions:[self options]];
    [self.view addSubview:lineChartView];
    
    
    pieNestChartView = [[YKEChartsView alloc] initWithFrame:CGRectMake(0, 350, self.view.frame.size.width, 250) delegate:self];
    [pieNestChartView drawChartWithOptions:[self option1]];
    [self.view addSubview:pieNestChartView];
    
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    button1.backgroundColor = [UIColor blueColor];
    button1.center = CGPointMake(100, self.view.frame.size.height - 60);
    [button1 setTitle:@"refresh" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(refresh) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
}

- (void)refresh{
     [lineChartView drawChartWithOptions:[self option1]];
     [pieNestChartView drawChartWithOptions:[self options]];
}

//line
- (NSDictionary*)options{
    
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
    
    //--------------------
    
    YKChartOptions *options = YKObject(YKChartOptions)
    .titleSet(@{@"text": @"折线图堆叠"})
    .tooltipSet(@{@"trigger":@"axis"})
    .legendSet(@{@"orient": @"horizontal",
                 @"y": @"bottom",
                 @"data":@[@"邮件营销",@"联盟广告",@"视频广告",@"直接访问",@"搜索引擎"]})
    .gridSet(@{@"left": @"3%",
               @"right": @"4%",
               @"bottom": @"8%",
               @"containLabel": @true})
    .toolboxSet(@{@"feature":@{@"saveImage":@{}}})
    .xAxisSet(@{@"type": @"category",
                @"boundaryGap": @false,
                @"data": @[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"]})
    .yAxisSet(@{@"type":@"value"})
    .seriesSet(@[item, item1, item2, item3, item4]);
    
    return [options convertToDic];
}


//pie-nest
- (NSDictionary*)option1{
    
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
    
    YKChartOptions *options = YKObject(YKChartOptions)
    .titleSet(@{@"text": @"嵌套环形图"})
    .tooltipSet( @{@"trigger":@"item",
                   @"formatter":@"{a} <br/>{b}: {c} ({d}%)"})
    .legendSet(@{@"orient": @"horizontal",
                 @"y": @"bottom",
                 @"data":@[@"直达",@"营销广告",@"搜索引擎",@"邮件营销",@"联盟广告",@"视频广告",@"百度",@"谷歌",@"必应",@"其他"]})
    .seriesSet(@[item, item1]);
    
    return [options convertToDic];
}

#pragma mark - 绘制完成
- (void)didDrawFinishedForChartView:(YKEChartsView *)chartView{
    NSLog(@"绘制完成");
}

@end

