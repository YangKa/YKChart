//
//  YKChartOptions.h
//  StudyDemo
//
//  Created by qiager on 2018/3/28.
//  Copyright © 2018年 yangka. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YKChartOptions : NSObject

@property (nonatomic, copy) NSDictionary *title;

@property (nonatomic, copy) NSDictionary* tooltip;

@property (nonatomic, copy) NSDictionary* legend;

@property (nonatomic, copy) NSDictionary* grid;

@property (nonatomic, copy) NSDictionary* toolbox;

@property (nonatomic, copy) NSDictionary* xAxis;

@property (nonatomic, copy) NSDictionary* yAxis;

@property (nonatomic, copy) NSArray* series;

- (NSDictionary*)convertToDic;

@end

@interface YKSeriseItem : NSObject

@property (nonatomic, copy) NSString* name;

@property (nonatomic, copy) NSString* type;

@property (nonatomic, copy) NSString* selectedMode;

@property (nonatomic, copy) NSArray* radius;

@property (nonatomic, copy) NSString* stack;

@property (nonatomic, copy) NSDictionary* label;

@property (nonatomic, copy) NSDictionary* labelLine;

@property (nonatomic, copy) NSArray*  data;

@end
