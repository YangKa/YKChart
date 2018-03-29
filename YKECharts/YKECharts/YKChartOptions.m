//
//  YKChartOptions.m
//  StudyDemo
//
//  Created by qiager on 2018/3/28.
//  Copyright © 2018年 yangka. All rights reserved.
//

#import "YKChartOptions.h"
#import <objc/runtime.h>

@implementation YKChartOptions

YKPropSetFuncImplementation(YKChartOptions, NSDictionary*, title);
YKPropSetFuncImplementation(YKChartOptions, NSDictionary*, tooltip);
YKPropSetFuncImplementation(YKChartOptions, NSDictionary*, legend);
YKPropSetFuncImplementation(YKChartOptions, NSDictionary*, grid);
YKPropSetFuncImplementation(YKChartOptions, NSDictionary*, toolbox);
YKPropSetFuncImplementation(YKChartOptions, NSDictionary*, xAxis);
YKPropSetFuncImplementation(YKChartOptions, NSDictionary*, yAxis);
YKPropSetFuncImplementation(YKChartOptions, NSArray*, series);


- (NSDictionary*)convertToDic{
    return [self getObjectData:self];
}

- (NSDictionary*)getObjectData:(id)obj {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int propsCount;
    Class class = [obj class];
    do {
        objc_property_t *props = class_copyPropertyList(class, &propsCount);
        for (int i = 0;i < propsCount; i++) {
            objc_property_t prop = props[i];
            
            NSString *propName = [NSString stringWithUTF8String:property_getName(prop)];
            id value = [obj valueForKey:propName];
            if (value == nil) {
                value = [NSNull null];
                continue;
            } else {
                value = [self getObjectInternal:value];
            }
            [dic setObject:value forKey:propName];
        }
        free(props);
        class = [class superclass];
    } while (class != [NSObject class]);
    
    return dic;
}

- (id)getObjectInternal:(id)obj {
    if (   [obj isKindOfClass:[NSString class]]
        || [obj isKindOfClass:[NSNumber class]]
        || [obj isKindOfClass:[NSNull   class]] ) {
        return obj;
    }
    
    if ([obj isKindOfClass:[NSArray class]]) {
        NSArray *objarr = obj;
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:objarr.count];
        for (int i = 0;i < objarr.count; i++) {
            [arr setObject:[self getObjectInternal:[objarr objectAtIndex:i]] atIndexedSubscript:i];
        }
        return arr;
    }
    
    if ([obj isKindOfClass:[NSDictionary class]]) {
        NSDictionary *objdic = obj;
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:[objdic count]];
        for (NSString *key in objdic.allKeys) {
            [dic setObject:[self getObjectInternal:[objdic objectForKey:key]] forKey:key];
        }
        return dic;
    }
    return [self getObjectData:obj];
}

@end

@implementation YKSeriseItem
@end

