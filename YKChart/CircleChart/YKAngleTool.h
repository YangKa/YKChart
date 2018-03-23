//
//  AngleTool.h
//  StudyDemo
//
//  Created by qiager on 2018/3/22.
//  Copyright © 2018年 yangka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YKAngleTool : NSObject

+ (CGFloat)angleForValue:(CGFloat)value;

+ (CGPoint)positionForCenter:(CGPoint)center radius:(CGFloat)radius angle:(CGFloat)angle;

@end
