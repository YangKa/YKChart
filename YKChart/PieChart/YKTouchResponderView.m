
//
//  TouchResponderView.m
//  YKChart
//
//  Created by qiager on 2018/3/23.
//  Copyright © 2018年 yangka. All rights reserved.
//

#import "YKTouchResponderView.h"



@implementation YKTouchResponderView


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    
    CGPoint point1 = [[touches anyObject] locationInView:self];
    
    BOOL isLeft = point1.x  < self.frame.size.width/2;
    CGPoint center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    CGPoint point2 = CGPointMake(self.frame.size.width/2, 0);
    float a = distanceForPoints(center, point1);
    float b = distanceForPoints(center, point2);
    float c = distanceForPoints(point2, point1);
    
    float angle = acosf( (a*a + b*b -c*c)/(2*a*b) );
    if (isLeft) {
        angle = 2*M_PI - angle;
    }
    
    if (self.touchBlock) {
        self.touchBlock(point1, angle, a);
    }
    
}

float distanceForPoints(CGPoint point1, CGPoint point2){
    return sqrtf((point1.x-point2.x)*(point1.x-point2.x) + (point1.y-point2.y)*(point1.y-point2.y));
}

@end
