//
//  YKLinePoint.h
//  YKChart
//
//  Created by qiager on 2018/3/23.
//  Copyright © 2018年 yangka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YKLine : NSObject

@property (nonatomic, readonly) UIColor *color;

@property (nonatomic, readonly, copy) NSString *name;

@property (nonatomic, readonly) NSArray *pointList;

- (instancetype)initWithPoints:(NSArray*)point name:(NSString*)name color:(UIColor*)color;

- (float)maxValue;

- (float)minValue;

@end


@interface YKPoint : NSObject

@property (nonatomic, readonly) id XAxisValue;

@property (nonatomic, readonly) float YAxisValue;

+ (instancetype)linePointWithXValue:(id)XValue  YValue:(float)YValue;

@end
