//
//  YKLineChart.h
//  YKChart
//
//  Created by qiager on 2018/3/23.
//  Copyright © 2018年 yangka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YKLine.h"
#import "YKVerticalAxis.h"
#import "YKHorizontalAxis.h"


typedef NS_ENUM(NSUInteger, YKLineChartType){
    YKLineChartType_Line,
    YKLineChartType_Bar
};

@interface YKLineChart : UIView

//the point is hollow
@property (nonatomic , assign) BOOL isHollow;


- (instancetype)initWithFrame:(CGRect)frame
               horizontalAxis:(YKHorizontalAxis*)horizontalAxis
                 verticalAxis:(YKVerticalAxis*)verticalAxis
                        lines:(NSArray*)lines
                         type:(YKLineChartType)type;


- (void)resetWithHorizontalAxis:(YKHorizontalAxis*)horizontalAxis
                   verticalAxis:(YKVerticalAxis*)verticalAxis
                          lines:(NSArray*)lines;

@end
