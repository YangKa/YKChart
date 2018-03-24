//
//  YKHorizontalAxis.h
//  YKChart
//
//  Created by qiager on 2018/3/23.
//  Copyright © 2018年 yangka. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, YKHorizontalAxisType){
    YKHorizontalAxisType_Number,
    YKHorizontalAxisType_String
};

@interface YKHorizontalAxis : NSObject

@property (nonatomic, readonly, assign)  YKHorizontalAxisType axisType;

@property (nonatomic, readonly, assign) float intervalValue;

@property (nonatomic, readonly, assign) float minValue;

@property (nonatomic, readonly, assign) float maxValue;

@property (nonatomic, readonly, copy) NSArray *values;

- (instancetype)initWithAxisType:(YKHorizontalAxisType)type interValue:(float)intervalValue;

- (instancetype)initWithAxisType:(YKHorizontalAxisType)type interValue:(float)intervalValue values:(NSArray*)values;

- (void)setHorizontalValuesWithMaxY:(float)maxY minY:(float)minY;

@end
