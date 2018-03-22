//
//  PieView.m
//  StudyDemo
//
//  Created by qiager on 2018/3/22.
//  Copyright © 2018年 yangka. All rights reserved.
//

#import "PieView.h"
#import "AngleTool.h"
#import "DataModel.h"

@interface PieView(){
    
    NSArray *_models;
    NSArray *_colors;
}

@end

CGFloat angleForValue(CGFloat value) {
    value = 360 + (value - 90);
    return value*(M_PI/180);
}

CGPoint positionForCenter(CGPoint center, CGFloat radius, CGFloat angle){
    CGFloat x = radius*cosf(angle);
    CGFloat y = radius*sinf(angle);
    
    return CGPointMake(center.x + x, center.y + y);
}

@implementation PieView

- (instancetype)initWithFrame:(CGRect)frame models:(NSArray*)models colors:(NSArray*)colors
{
    self = [super initWithFrame:frame];
    if (self) {
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
    CGFloat radius = self.frame.size.width/2;
    
    
    CGFloat start = 0;
    for (int i = 0; i< _models.count; i++) {
       
        DataModel *model = _models[i];
    
        CGFloat startAngle = [AngleTool angleForValue:start];
        start += model.angle;
        CGFloat endAngle  = [AngleTool angleForValue:start];
        
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.frame = self.bounds;
        shapeLayer.lineWidth = radius;
        UIColor *color = _colors[i];
        shapeLayer.strokeColor = color.CGColor;
        [self.layer addSublayer:shapeLayer];

        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center
                                                            radius:radius/2
                                                        startAngle:startAngle
                                                          endAngle:endAngle
                                                         clockwise:YES];
        shapeLayer.path = path.CGPath;
        
        NSLog(@"%f  %f", startAngle, endAngle);
        
        //name
        CGFloat angle = startAngle + (endAngle - startAngle)/2;
        CGPoint point = [AngleTool positionForCenter:center radius:radius*0.5 angle:angle];

        CATextLayer *textLayer = [CATextLayer layer];
        textLayer.string = model.name;
        textLayer.fontSize = 9;
        textLayer.wrapped = YES;
        textLayer.alignmentMode = @"center";
        textLayer.frame = CGRectMake(point.x - 30 , point.y - 15, 60, 30);
        [shapeLayer addSublayer:textLayer];
    }
}

@end
