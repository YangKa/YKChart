//
//  YKChartOptions.h
//  StudyDemo
//
//  Created by qiager on 2018/3/28.
//  Copyright © 2018年 yangka. All rights reserved.
//

#import <Foundation/Foundation.h>


#define YKObject(objectName) [[objectName alloc]init]


#define YKPropStatementAndFuncStatement(propertyModifier,className, propertyPointerType, propertyName)                  \
@property(nonatomic,propertyModifier)propertyPointerType  propertyName;                                                 \
- (className * (^) (propertyPointerType propertyName)) propertyName##Set;



#define YKPropSetFuncImplementation(className, propertyPointerType, propertyName)                                       \
- (className * (^) (propertyPointerType propertyName))propertyName##Set{                                                \
return ^(propertyPointerType propertyName) {                                                                            \
_##propertyName = propertyName;                                                                                         \
return self;                                                                                                            \
};                                                                                                                      \
}

@interface YKChartOptions : NSObject

YKPropStatementAndFuncStatement(copy, YKChartOptions, NSDictionary*, title);
YKPropStatementAndFuncStatement(copy, YKChartOptions, NSDictionary*, tooltip);
YKPropStatementAndFuncStatement(copy, YKChartOptions, NSDictionary*, legend);
YKPropStatementAndFuncStatement(copy, YKChartOptions, NSDictionary*, grid);

YKPropStatementAndFuncStatement(copy, YKChartOptions, NSDictionary*, toolbox);
YKPropStatementAndFuncStatement(copy, YKChartOptions, NSDictionary*, xAxis);
YKPropStatementAndFuncStatement(copy, YKChartOptions, NSDictionary*, yAxis);
YKPropStatementAndFuncStatement(copy, YKChartOptions, NSArray*, series);

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
