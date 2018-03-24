//
//  YKVerticalAxis.h
//  YKChart
//
//  Created by qiager on 2018/3/23.
//  Copyright © 2018年 yangka. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSUInteger, YKVerticalAxisType){
    YKVerticalAxisType_Number,
    YKVerticalAxisType_Percent
};

@interface YKVerticalAxis : NSObject

@property (nonatomic, readonly, assign)  YKVerticalAxisType axisType;

@property (nonatomic, readonly, assign) float intervalValue;

@property (nonatomic, readonly, assign) float minValue;

@property (nonatomic, readonly, assign) float maxValue;

@property (nonatomic, readonly, copy) NSArray *values;

- (instancetype)initWithAxisType:(YKVerticalAxisType)type interValue:(float)intervalValue;

- (void)setVerticalValuesWithMaxY:(float)maxY minY:(float)minY;

@end
