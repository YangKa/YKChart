//
//  YKECharts.h
//  StudyDemo
//
//  Created by qiager on 2018/3/28.
//  Copyright © 2018年 yangka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YKChartOptions.h"

@class YKECharts;
@protocol YKEChartsDelegate <NSObject>
- (void)didDrawFinishedForChartView:(YKECharts*)chartView;
@end

@interface YKECharts : UIView

- (instancetype)initWithFrame:(CGRect)frame delegate:(id<YKEChartsDelegate>)delegate;

- (void)drawChartWithOptions:(NSDictionary*)optionDic;

- (void)refreshChartWithOptions:(NSDictionary*)optionDic;

@end
