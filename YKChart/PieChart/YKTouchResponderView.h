//
//  TouchResponderView.h
//  YKChart
//
//  Created by qiager on 2018/3/23.
//  Copyright © 2018年 yangka. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YKTouchResponderView : UIView

@property (nonatomic, copy) void(^touchBlock)(CGPoint point, float angle, float distance);

@end
