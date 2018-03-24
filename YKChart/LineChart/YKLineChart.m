//
//  YKLineChart.m
//  YKChart
//
//  Created by qiager on 2018/3/23.
//  Copyright © 2018年 yangka. All rights reserved.
//

#import "YKLineChart.h"

@interface YKLineChart (){
    
    CGRect _drawRect;
    CGFloat _topMargin;
    CGFloat _VerticalAxisWidth;
    CGFloat _HorizontalAxisHeight;
    
    UIView *_drawView;
    CGFloat _intervalHeight_Y;
    CGFloat _intervalWidth_X;
    
    UIView *_infoView;
    
    YKLineChartType _chartType;
    
}

@property (nonatomic, strong) YKHorizontalAxis* horizontalAxis;

@property (nonatomic, strong) YKVerticalAxis* verticalAxis;

@property (nonatomic, strong) NSArray *lines;

@end

@implementation YKLineChart

- (instancetype)initWithFrame:(CGRect)frame
               horizontalAxis:(YKHorizontalAxis*)horizontalAxis
                 verticalAxis:(YKVerticalAxis*)verticalAxis
                        lines:(NSArray*)lines
                         type:(YKLineChartType)type{
    self = [super initWithFrame:frame];
    if (self) {
        _topMargin = 30;
        _VerticalAxisWidth = 45;
        _HorizontalAxisHeight = 20;
        _chartType = type;
        
        [self resetWithHorizontalAxis:horizontalAxis verticalAxis:verticalAxis lines:lines];
    }
    return self;
}

- (void)resetWithHorizontalAxis:(YKHorizontalAxis*)horizontalAxis
               verticalAxis:(YKVerticalAxis*)verticalAxis
                      lines:(NSArray*)lines{
    
    if (_infoView) {
        [_infoView removeFromSuperview];
        _infoView = nil;
    }
    if (_drawView) {
        [_drawView removeFromSuperview];
        _drawView = nil;
    }
    
    _drawRect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 40);
    _drawView = [[UIView alloc] initWithFrame:_drawRect];
    [self addSubview:_drawView];
    
    _horizontalAxis = horizontalAxis;
    _verticalAxis = verticalAxis;
    _lines = [lines copy];
    
    [_verticalAxis setVerticalValuesWithMaxY:[self findMaxValue] minY:[self findMinValue]];
    if (_horizontalAxis.axisType == YKHorizontalAxisType_Number) {
        [_horizontalAxis setHorizontalValuesWithMaxY:[self findMaxValue] minY:[self findMinValue]];
    }
    [self drawVerticalAxis];
    [self drawHorizontalAxis];
    
    if (_chartType == YKLineChartType_Line) {
        [self drawLines];
    }else if (_chartType == YKLineChartType_Bar){
        [self drawBar];
    }
    
    [self drawInfo];
}

- (void)drawHorizontalAxis{
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = CGRectMake(_VerticalAxisWidth, _drawRect.size.height - _HorizontalAxisHeight, _drawRect.size.width - _VerticalAxisWidth, _HorizontalAxisHeight);
    [_drawView.layer addSublayer:shapeLayer];
    
    NSArray *values = _horizontalAxis.values;
    _intervalWidth_X = (_drawRect.size.width - _VerticalAxisWidth)/(values.count + 0.8);
    
    for (int i = 0; i < values.count; i++) {
    
        CGColorRef color= [UIColor lightGrayColor].CGColor;
        
        CATextLayer *textLayer = [CATextLayer layer];
        textLayer.frame = CGRectMake(_intervalWidth_X*(i+1) - 15, 5, 30, _HorizontalAxisHeight-5);
        if (_horizontalAxis.axisType == YKHorizontalAxisType_String) {
            textLayer.string = values[i];
        }else{
            textLayer.string = [NSString stringWithFormat:@"%.1f%%", [values[i] floatValue]];
        }
        textLayer.fontSize = 10;
        textLayer.alignmentMode = @"center";
        textLayer.foregroundColor = color;
        [shapeLayer addSublayer:textLayer];
    }
}

- (void)drawVerticalAxis{

    
    NSArray *values = _verticalAxis.values;
    _intervalHeight_Y = (_drawRect.size.height - _topMargin - _HorizontalAxisHeight)/(values.count - 1);
    
    for (int i = 0; i < values.count; i++) {
        
        CGFloat YValue = [values[i] floatValue];
        CGColorRef color= [UIColor lightGrayColor].CGColor;
    
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.frame = CGRectMake(0, _drawRect.size.height - _HorizontalAxisHeight - _intervalHeight_Y*(i), _drawRect.size.width, _intervalHeight_Y);
        shapeLayer.lineWidth = 1;
        shapeLayer.strokeColor = color;
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(_VerticalAxisWidth, 0)];
        [path addLineToPoint:CGPointMake(shapeLayer.frame.size.width - 10, 0)];
        shapeLayer.path = path.CGPath;
        [_drawView.layer addSublayer:shapeLayer];
        
        CATextLayer *textLayer = [CATextLayer layer];
        textLayer.frame = CGRectMake(0, -8, _VerticalAxisWidth, 17);
        textLayer.string = [NSString stringWithFormat:@"%.1f", YValue];
        textLayer.fontSize = 10;
        textLayer.alignmentMode = @"center";
        textLayer.foregroundColor = color;
        [shapeLayer addSublayer:textLayer];
    }
    
}

- (void)drawLines{
    
    CGFloat verticalAxisHeight = _drawRect.size.height - _HorizontalAxisHeight - _topMargin;
    CGFloat verticalInterval = _verticalAxis.maxValue - _verticalAxis.minValue;
    
    for (int  i =0 ; i < _lines.count; i++) {
        YKLine *line = _lines[i];
        
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.frame = CGRectMake(_VerticalAxisWidth, 0, _drawRect.size.width - _VerticalAxisWidth, _drawRect.size.height - _HorizontalAxisHeight);
        shapeLayer.lineWidth = 2;
        shapeLayer.fillColor = nil;
        shapeLayer.lineJoin = kCALineJoinRound;
        shapeLayer.strokeColor = line.color.CGColor;
        [_drawView.layer addSublayer:shapeLayer];
        
        
        NSArray *points = line.pointList;
        UIBezierPath *path = [UIBezierPath bezierPath];
        for (int j = 0; j < points.count; j++) {
            YKPoint *point  = points[j];
            NSLog(@"%f", point.YAxisValue);
            CGFloat pointY = shapeLayer.frame.size.height - ((point.YAxisValue - _verticalAxis.minValue)/verticalInterval)*verticalAxisHeight;
            CGFloat pointX = _intervalWidth_X*(j+1);
            CGPoint location = CGPointMake(pointX, pointY);
            if (j == 0) {
                [path moveToPoint:location];
            }else{
                [path addLineToPoint:location];
            }
            
            CAShapeLayer *layer = [CAShapeLayer layer];
            layer.frame = CGRectMake(location.x - 2, location.y - 2, 3, 3);
            layer.lineWidth = 2;
            layer.fillColor = self.isHollow? [UIColor whiteColor].CGColor:line.color.CGColor;
            layer.strokeColor = line.color.CGColor;
            [shapeLayer addSublayer:layer];
            layer.path= [UIBezierPath bezierPathWithArcCenter:CGPointMake(2, 2) radius:3 startAngle:0 endAngle:2*M_PI clockwise:YES].CGPath;
    
        }
        shapeLayer.path = path.CGPath;
    }
}

- (void)drawBar{
    
    CGFloat barWidth = (_intervalWidth_X - 10)/_lines.count;
    barWidth = (barWidth > 30) ? 30:barWidth;
    CGFloat originX = _intervalWidth_X - barWidth*_lines.count;
    CGFloat verticalAxisHeight = _drawRect.size.height - _HorizontalAxisHeight - _topMargin;
    CGFloat verticalInterval = _verticalAxis.maxValue - _verticalAxis.minValue;
    
    for (int  index =0 ; index < _horizontalAxis.values.count; index++) {
       
        for (int i = 0; i < _lines.count; i++) {
            YKLine *line = _lines[i];
            YKPoint *point  = line.pointList[index];
            
            CGFloat barHeight = ((point.YAxisValue - _verticalAxis.minValue)/verticalInterval)*verticalAxisHeight;
            CGFloat  Y = _drawRect.size.height - barHeight - _HorizontalAxisHeight;
            CGFloat  X  = _intervalWidth_X/2 + _intervalWidth_X*index + originX + barWidth*i;
            
            CALayer *layer = [CALayer layer];
            layer.frame = CGRectMake(_VerticalAxisWidth + X, Y, barWidth, barHeight);
            layer.backgroundColor = line.color.CGColor;
            [_drawView.layer addSublayer:layer];
            
        }
    }
}

- (void)drawInfo{
    
    _infoView = [[UIView alloc] initWithFrame:CGRectMake(_VerticalAxisWidth, _drawRect.size.height, self.frame.size.width - _VerticalAxisWidth, self.frame.size.height - _drawRect.size.height)];
    [self addSubview:_infoView];
    
    CGFloat originX = 0;
    for (int i = 0; i < _lines.count; i++) {
        YKLine *line = _lines[i];
        
        CALayer *layer =  [CALayer layer];
        layer.backgroundColor = line.color.CGColor;
        layer.frame = CGRectMake(originX, 20, 20, 15);
        [_infoView.layer addSublayer:layer];
        
        CATextLayer *textLayer = [CATextLayer layer];
        CGFloat width = [line.name sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]}].width;
        textLayer.frame = CGRectMake(originX + 25, 20, width, 15);
        textLayer.string = line.name;
        textLayer.fontSize = 10;
        textLayer.alignmentMode = @"center";
        textLayer.foregroundColor = [UIColor blackColor].CGColor;
        [_infoView.layer addSublayer:textLayer];
        
        originX += width +30;
    }
}

- (CGFloat)findMaxValue{
    YKLine *line = [_lines firstObject];
    __block float value = line.maxValue;
    [_lines enumerateObjectsUsingBlock:^(YKLine *line, NSUInteger idx, BOOL * _Nonnull stop) {
        if (line.maxValue > value) {
            value = line.maxValue;
        }
    }];
    
    return value;
}

- (CGFloat)findMinValue{
    YKLine *line = [_lines firstObject];
    __block float value = line.minValue;
    [_lines enumerateObjectsUsingBlock:^(YKLine *line, NSUInteger idx, BOOL * _Nonnull stop) {
        if (line.minValue < value) {
            value = line.minValue;
        }
    }];
    
    return value;
}

@end
