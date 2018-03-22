//
//  LoopView.m
//  StudyDemo
//
//  Created by qiager on 2018/3/22.
//  Copyright © 2018年 yangka. All rights reserved.
//

#import "LoopView.h"
#import "AngleTool.h"
#import "DataModel.h"

@interface LoopView(){
    
    CGFloat _lineWidth;
    NSArray *_models;
    NSArray *_colors;
}

@end


@implementation LoopView

- (instancetype)initWithFrame:(CGRect)frame lineWidth:(CGFloat)lineWidth models:(NSArray*)models colors:(NSArray*)colors
{
    self = [super initWithFrame:frame];
    if (self) {
        _lineWidth = lineWidth;
        _models = [models copy];
        _colors = [colors copy];
        
        if (_models.count >0 && _colors.count >0) {
            [self draw];
        }
        
    }
    return self;
}

- (void)draw{
    
    CGPoint center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    CGFloat radius = self.frame.size.width/2 - _lineWidth/4;
    
    CGFloat start = 0;
    for (int i = 0; i < _models.count; i++) {
        
        DataModel *model = _models[i];
        
        CGFloat startAngle = [AngleTool angleForValue:start];
        start += model.angle;
        CGFloat endAngle  = [AngleTool angleForValue:start];
        
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.frame = self.bounds;
        shapeLayer.lineWidth = _lineWidth;
        UIColor *color = _colors[i];
        shapeLayer.strokeColor = color.CGColor;
        shapeLayer.fillColor = nil;
        [self.layer addSublayer:shapeLayer];
        

        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center
                                                            radius:radius - _lineWidth/2
                                                        startAngle:startAngle
                                                          endAngle:endAngle
                                                         clockwise:YES];
        shapeLayer.path = path.CGPath;
        
        CGFloat angle = startAngle + (endAngle - startAngle)/2;
        BOOL isLeft = ( angle > 7.853982);
        
        //折线
        CGPoint point1 = [AngleTool positionForCenter:center radius:radius angle:angle];
        CAShapeLayer *lineLayer = [CAShapeLayer layer];
        lineLayer.frame = CGRectMake(point1.x - 15, point1.y - 15, 30, 30);
        lineLayer.fillColor = nil;
         lineLayer.strokeColor = color.CGColor;
        [self.layer addSublayer:lineLayer];
        
        UIBezierPath *path1 = [UIBezierPath bezierPath];
        [path1 moveToPoint:CGPointMake(15, 15)];
        
        CGPoint point2 = [AngleTool positionForCenter:CGPointMake(15, 15) radius:12 angle:angle];
        [path1 addLineToPoint:point2];
        if (isLeft) {
            [path1 addLineToPoint:CGPointMake(point2.x - 15 , point2.y)];
        }else{
            [path1 addLineToPoint:CGPointMake(point2.x + 15, point2.y)];
        }
        lineLayer.path = path1.CGPath;
        
        //边框
        CATextLayer *textLayer = [CATextLayer layer];
        textLayer.cornerRadius = 3;
        textLayer.masksToBounds = YES;
        textLayer.backgroundColor = color.CGColor;
        NSString *string = [NSString stringWithFormat:@"%@ %.1f %.1f%%",model.name, model.value, model.ratio*100];
        textLayer.string = string;
        textLayer.fontSize = 9;
        textLayer.wrapped = YES;
        textLayer.alignmentMode = @"center";
        textLayer.foregroundColor = [UIColor whiteColor].CGColor;
        [shapeLayer addSublayer:textLayer];
        
        CGPoint point4 = [AngleTool positionForCenter:center radius:radius+15 angle:angle];
        if (isLeft) {
            CGPoint point5 = CGPointMake(point4.x - 20, point4.y);
            textLayer.frame = CGRectMake(point5.x - 55, point5.y - 13, 55, 26);
        }else{
            CGPoint point5 = CGPointMake(point4.x + 20, point4.y);
            textLayer.frame = CGRectMake(point5.x, point5.y - 13, 55, 26);
        }
    }
}

@end

