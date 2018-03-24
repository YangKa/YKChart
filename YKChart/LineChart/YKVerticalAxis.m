//
//  YKVerticalAxis.m
//  YKChart
//
//  Created by qiager on 2018/3/23.
//  Copyright © 2018年 yangka. All rights reserved.
//

#import "YKVerticalAxis.h"

@interface YKVerticalAxis ()

@property (nonatomic, assign) YKVerticalAxisType axisType;

@property (nonatomic, assign) float intervalValue;

@property (nonatomic, assign) float minValue;

@property (nonatomic, assign) float maxValue;

@property (nonatomic, copy) NSArray *values;@end

@implementation YKVerticalAxis

- (instancetype)initWithAxisType:(YKVerticalAxisType)type interValue:(float)intervalValue
{
    self = [super init];
    if (self) {
        
        _axisType = type;
        _intervalValue = intervalValue;
    }
    return self;
}

- (void)setVerticalValuesWithMaxY:(float)maxY minY:(float)minY{
    
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
