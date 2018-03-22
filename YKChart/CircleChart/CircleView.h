//
//  CircleView.h
//  StudyDemo
//
//  Created by qiager on 2018/3/22.
//  Copyright © 2018年 yangka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataModel.h"


@interface CircleView : UIView

- (instancetype)initWithFrame:(CGRect)frame
                      pieList:(NSArray*)pieList
                    pieColors:(NSArray*)pieColors
                     loopList:(NSArray*)loopList
                   loopColors:(NSArray*)loopColors;
- (void)display;

@end
