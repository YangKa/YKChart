//
//  PieChart.h
//  YKChart
//
//  Created by qiager on 2018/3/23.
//  Copyright © 2018年 yangka. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YKPieChart : UIView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray*)titles values:(NSArray*)values colors:(NSArray*)colors;

- (void)resetTitles:(NSArray*)titles values:(NSArray*)values colors:(NSArray*)colors;


@end
