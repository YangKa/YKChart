//
//  DataModel.h
//  StudyDemo
//
//  Created by qiager on 2018/3/22.
//  Copyright © 2018年 yangka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YKDataModel : NSObject

@property (nonatomic, copy) NSString* name;

@property (nonatomic, assign) CGFloat value;

@property (nonatomic, assign) CGFloat total;


@property (nonatomic, readonly, assign) CGFloat ratio;

@property (nonatomic, readonly, assign) CGFloat angle;

@end

