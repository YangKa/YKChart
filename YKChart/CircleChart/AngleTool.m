//
//  AngleTool.m
//  StudyDemo
//
//  Created by qiager on 2018/3/22.
//  Copyright © 2018年 yangka. All rights reserved.
//

#import "AngleTool.h"

@implementation AngleTool

+ (CGFloat)angleForValue:(CGFloat)value{
    value = 360 + (value - 90);
    return value*(M_PI/180);
}

+ (CGPoint)positionForCenter:(CGPoint)center radius:(CGFloat)radius angle:(CGFloat)angle{
    CGFloat x = radius*cosf(angle);
    CGFloat y = radius*sinf(angle);
    
    return CGPointMake(center.x + x, center.y + y);
}

@end
