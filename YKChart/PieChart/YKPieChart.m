//
//  PieChart.m
//  YKChart
//
//  Created by qiager on 2018/3/23.
//  Copyright © 2018年 yangka. All rights reserved.
//

#import "YKPieChart.h"
#import "YKAngleTool.h"
#import "YKTouchResponderView.h"

@interface YKPieChart(){
    
    NSArray *_titles;
    NSArray *_values;
    NSMutableArray *_colors;
    
    float _totalValue;
    NSMutableArray *_angles;
    
    NSMutableArray *_pieLayers;
    NSInteger _showIndex;
    
    
    CGPoint _centerPoint;
    CGRect _circleRect;
}

@end

#define RandomColor [UIColor colorWithRed:(arc4random_uniform(255)/255.0) green:(arc4random_uniform(255)/255.0) blue:(arc4random_uniform(255)/255.0) alpha:1]

#define  OFFSet     20.0f
#define  Radius     self.frame.size.width*0.3
@implementation YKPieChart

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray*)titles values:(NSArray*)values colors:(NSArray*)colors;
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _titles = [titles copy];
        _values = [values copy];
        
        if ((_titles.count > 0 && _values.count > 0)
            &&_titles.count == _values.count) {
            
            if (colors.count < _titles.count) {
                _colors = [NSMutableArray array];
                for (int i = 0; i<_titles.count; i++) {
                    [_colors addObject:RandomColor];
                }
            }else{
                _colors = [NSMutableArray arrayWithArray:colors];
            }
            
            _centerPoint = CGPointMake(Radius, Radius);
            _circleRect = CGRectMake(self.frame.size.width/2-Radius, OFFSet, 2*Radius, 2*Radius);
            _totalValue = 0;
            _showIndex = -1;
            _pieLayers = [NSMutableArray array];
            
            [self draw];
            [self addContentContext];
            [self addResponderLayer];
        }
    }
    return self;
}

- (void)addResponderLayer{
    
    YKTouchResponderView *view = [[YKTouchResponderView alloc] initWithFrame:_circleRect];
    [self addSubview:view];
    
    view.touchBlock = ^(CGPoint point, float angle, float distance) {
        [self showInfoWithPoint:point angle:angle distance:distance];
    };
}

- (void)arrangeRatio{
    
    if (!_angles) {
        _angles = [NSMutableArray array];
    }
    [_angles removeAllObjects];
    
    for (NSNumber *number in _values) {
        _totalValue += number.floatValue;
    }
    
    float lastAngle = 0;
    [_angles addObject:[NSNumber numberWithFloat:lastAngle]];
    
    for (int i =0; i < _values.count; i++) {
        float value = [_values[i] floatValue];
        
        lastAngle += (value/_totalValue)*360;
        [_angles addObject:[NSNumber numberWithFloat:lastAngle]];
    }
}

- (void)draw{
    
    [self arrangeRatio];
    
    for (int i = 0; i< _titles.count; i++) {
        
        CGFloat startAngle = [YKAngleTool angleForValue:[_angles[i] floatValue]];
        CGFloat endAngle  = [YKAngleTool angleForValue:[_angles[i+1] floatValue]];
        
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.frame = _circleRect;
        shapeLayer.lineWidth = Radius;
        UIColor *color = _colors[i];
        shapeLayer.strokeColor = color.CGColor;
        [self.layer addSublayer:shapeLayer];
        
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:_centerPoint
                                                            radius:Radius/2
                                                        startAngle:startAngle
                                                          endAngle:endAngle
                                                         clockwise:YES];
        shapeLayer.path = path.CGPath;
        [_pieLayers addObject:shapeLayer];
    }
}


- (void)showInfoWithPoint:(CGPoint)point angle:(float)angle distance:(float)distance{

    
    if (_showIndex >= 0){
        CAShapeLayer *tempLayer = _pieLayers[_showIndex];
        for (CALayer *subLayer in tempLayer.sublayers) {
            [subLayer removeFromSuperlayer];
        }
        tempLayer.transform = CATransform3DIdentity;
        _showIndex = -1;
    }
    
    if (distance > Radius) return;

    float midAngle = 0;//use to move
    for (int i=1; i < _angles.count; i++) {
        
        if (angle*(180/M_PI) < [_angles[i] floatValue]) {
            _showIndex = i - 1;
            midAngle = [_angles[i-1] floatValue] + ([_angles[i] floatValue] - [_angles[i-1] floatValue])/2;
            break;
        }
    }
    
    //show info
    CAShapeLayer *shapeLayer = _pieLayers[_showIndex];
    [shapeLayer removeFromSuperlayer];
    [self.layer insertSublayer:shapeLayer atIndex:(unsigned)(self.layer.sublayers.count - 1)];
    float ratio = [_values[_showIndex] floatValue]/_totalValue;
    UIColor *color = _colors[_showIndex];
    
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.cornerRadius = 3;
    textLayer.masksToBounds = YES;
    textLayer.borderColor = color.CGColor;
    textLayer.borderWidth = 1;
    textLayer.backgroundColor = [UIColor whiteColor].CGColor;
    NSString *string = [NSString stringWithFormat:@"%@ %.1f %.1f%%", _titles[_showIndex], [_values[_showIndex]floatValue], ratio*100];
    textLayer.string = string;
    textLayer.fontSize = 10;
    textLayer.wrapped = YES;
    textLayer.alignmentMode = @"center";
    textLayer.foregroundColor = color.CGColor;
    [shapeLayer addSublayer:textLayer];
    
    CGSize size = CGSizeMake(60, 35);
    textLayer.frame = CGRectMake( point.x - size.width/2, point.y - size.height/2, size.width, size.height);
    
    CGPoint movePoint = [YKAngleTool positionForCenter:CGPointZero radius:OFFSet angle:[YKAngleTool angleForValue:midAngle]];
    shapeLayer.transform = CATransform3DTranslate(CATransform3DIdentity, movePoint.x, movePoint.y, 0);
}

- (void)addContentContext{
    
    CGRect contentRect = CGRectMake(0, CGRectGetMaxY(_circleRect), self.frame.size.width, self.frame.size.height - _circleRect.size.height);
    CGFloat margin  = 30;
    CGFloat originY = contentRect.origin.y + OFFSet;
    CGFloat width  = (contentRect.size.width - 2*margin)/2;
    
    NSUInteger rows = _titles.count/2+1;
    CGFloat height = (contentRect.size.height - 2*OFFSet)/rows;
    
    for (int index = 0; index < _titles.count; index++) {
        
        int row = index/2;
        int col = index%2;
        CGFloat Y = originY + height*row;

        UIView *cellView = [[UIView alloc] initWithFrame:CGRectMake((margin + width)*col, Y, width, height)];
        [self addSubview:cellView];
        
        UIView *colorView = [[UIView alloc] initWithFrame:CGRectMake(4, 4, height - 8, height - 8)];
        colorView.backgroundColor = _colors[index];
        [cellView addSubview:colorView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(height + 10, 0, width - height- 20, height)];
        float ratio = [_values[index] floatValue]/_totalValue;
        label.text = [NSString stringWithFormat:@"%@ %.1f %.1f%%", _titles[index], [_values[index]floatValue], ratio*100];;
        label.textColor = [UIColor grayColor];
        label.font = [UIFont systemFontOfSize:12];
        [cellView addSubview:label];
    }
}

@end
