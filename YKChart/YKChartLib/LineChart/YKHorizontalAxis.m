//
//  YKHorizontalAxis.m
//  YKChart
//
//  Created by qiager on 2018/3/23.
//  Copyright © 2018年 yangka. All rights reserved.
//

#import "YKHorizontalAxis.h"

@interface YKHorizontalAxis ()

@property (nonatomic, assign) YKHorizontalAxisType axisType;

@property (nonatomic, assign) float intervalValue;

@property (nonatomic, assign) float minValue;

@property (nonatomic, assign) float maxValue;

@property (nonatomic, copy) NSArray *values;

@end

@implementation YKHorizontalAxis

- (instancetype)initWithAxisType:(YKHorizontalAxisType)type interValue:(float)intervalValue{
    return [self initWithAxisType:type interValue:intervalValue values:nil];
}

- (instancetype)initWithAxisType:(YKHorizontalAxisType)type interValue:(float)intervalValue values:(NSArray*)values
{
    self = [super init];
    if (self) {
        
        _axisType = type;
        _intervalValue = intervalValue;
        
        if (type == YKHorizontalAxisType_String) {
            _values = [values copy];
        }
        
    }
    return self;
}

- (void)setHorizontalValuesWithMaxY:(float)maxY minY:(float)minY{
    
    if (_axisType == YKHorizontalAxisType_String) return;
    
    _maxValue = (int)(maxY/_intervalValue + 1 )*_intervalValue;
    _minValue = (int)(minY/_intervalValue - 1 )*_intervalValue;
    if (_minValue <0 ) _minValue =0;
    
    NSMutableArray *values = [NSMutableArray array];
    float value = _minValue;
    while (value <= _maxValue) {
        [values addObject:[NSNumber numberWithFloat:value]];
        value += _intervalValue;
    }
    _values = [values copy];
}


@end
