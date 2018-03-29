//
//  YKLinePoint.m
//  YKChart
//
//  Created by qiager on 2018/3/23.
//  Copyright © 2018年 yangka. All rights reserved.
//

#import "YKLine.h"

@interface YKLine ()

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) UIColor *color;

@property (nonatomic, copy) NSArray *pointList;

@end


@implementation YKLine

- (instancetype)initWithPoints:(NSArray*)point name:(NSString*)name  color:(UIColor*)color
{
    self = [super init];
    if (self) {
        _color = color;
        _name = [name copy];
        _pointList = [point copy];
    }
    return self;
}

- (float)maxValue{
    
    YKPoint *point = [_pointList firstObject];
    __block float value = point.YAxisValue;
    [_pointList enumerateObjectsUsingBlock:^(YKPoint *point, NSUInteger idx, BOOL * _Nonnull stop) {
        if (point.YAxisValue > value) {
            value = point.YAxisValue;
        }
    }];
    
    return value;
}

- (float)minValue{
    YKPoint *point = [_pointList firstObject];
    __block float value = point.YAxisValue;
    [_pointList enumerateObjectsUsingBlock:^(YKPoint *point, NSUInteger idx, BOOL * _Nonnull stop) {
        if (point.YAxisValue < value) {
            value = point.YAxisValue;
        }
    }];
    
    return value;
}

@end

#pragma mark -
@interface YKPoint ()

@property (nonatomic) id XAxisValue;

@property (nonatomic) float YAxisValue;

@end

@implementation YKPoint

+ (instancetype)linePointWithXValue:(id)XValue  YValue:(float)YValue{
    
    YKPoint *point = [[YKPoint alloc] init];
    point.XAxisValue = XValue;
    point.YAxisValue = YValue;
    
    return point;
}

@end
