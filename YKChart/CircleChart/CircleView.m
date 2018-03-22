//
//  CircleView.m
//  StudyDemo
//
//  Created by qiager on 2018/3/22.
//  Copyright © 2018年 yangka. All rights reserved.
//

#import "CircleView.h"
#import "PieView.h"
#import "LoopView.h"

@interface CircleView(){
    
    CGRect _drawRect;
    CGRect _contentRect;
}

//data
@property (nonatomic, copy) NSArray *pieList;

@property (nonatomic, copy) NSArray *loopList;

//color
@property (nonatomic, strong) NSMutableArray *pieColors;

@property (nonatomic, strong) NSMutableArray *loopColors;

@end

#define RandomColor [UIColor colorWithRed:(arc4random_uniform(255)/255.0) green:(arc4random_uniform(255)/255.0) blue:(arc4random_uniform(255)/255.0) alpha:1]

@implementation CircleView

- (instancetype)initWithFrame:(CGRect)frame pieList:(NSArray*)pieList pieColors:(NSArray*)pieColors loopList:(NSArray*)loopList loopColors:(NSArray*)loopColors
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat radius = frame.size.width*0.6;
        _drawRect = CGRectMake((frame.size.width - radius)/2, 40, radius, radius);
        _contentRect = CGRectMake(0, _drawRect.size.height, frame.size.width, frame.size.height - _drawRect.size.height);
    
        [self resetPieList:pieList pieColors:pieColors loopList:loopList loopColors:loopColors];
    }
    return self;
}

- (void)resetPieList:(NSArray*)pieList pieColors:(NSArray*)pieColors loopList:(NSArray*)loopList loopColors:(NSArray*)loopColors{
    //pie
    if (!pieColors || pieColors.count == 0) {
        _pieColors  = [NSMutableArray array];
    }else{
        _pieColors = [pieColors copy];
    }
    _pieList = [pieList copy];
    
    //loop
    if (!loopColors || loopColors.count == 0) {
        _loopColors  = [NSMutableArray array];
    }else{
        _loopColors = [loopColors copy];
    }
    _loopList = [loopList copy];
}

- (void)resetData{
    CGFloat pieTotal = 0;
    if (_pieList > 0){
        
        for (int i = 0; i<_pieList.count; i++) {
            DataModel *model = _pieList[i];
            pieTotal += model.value;
        }
        
        [_pieList enumerateObjectsUsingBlock:^(DataModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
            NSLog(@"----_pieList");
            model.total = pieTotal;
        }];
    }
    NSLog(@"pieTotal=%f", pieTotal);
    
    CGFloat loopTotal = 0;
    if (_loopList.count > 0){
        for (int i = 0; i<_loopList.count; i++) {
            DataModel *model = _loopList[i];
            loopTotal += model.value;
        }
        
        [_loopList enumerateObjectsUsingBlock:^(DataModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
            model.total = loopTotal;
            NSLog(@"----_loopList");
        }];
    }
    
    NSLog(@"loopTotal=%f", loopTotal);
    
    //colors
    if (_pieColors.count == 0) {
        for (int i = 0; i<_pieList.count; i++) {
            [_pieColors addObject:RandomColor];
        }
    }
    if (_loopColors.count == 0){
        for (int i = 0; i<_loopList.count; i++) {
            [_loopColors addObject:RandomColor];
        }
    }
}

- (void)display{
    
    for (UIView *subview in self.subviews) {
        [subview removeFromSuperview];
    }
    [self resetData];
    
    //draw chart
    [self addDrawContext];
    //draw text
    [self addContentContext];
}


- (void)addDrawContext{
    
    LoopView *loopView = [[LoopView alloc] initWithFrame:_drawRect lineWidth:30 models:_loopList colors:_loopColors];
    [self addSubview:loopView];
    
    CGFloat radius = _drawRect.size.width/2 - 50;
    CGRect pieRect = CGRectMake(CGRectGetMidX(_drawRect) - radius, CGRectGetMidY(_drawRect) - radius, 2*radius, 2*radius);
    
    PieView *pieView = [[PieView alloc] initWithFrame:pieRect models:_pieList colors:_pieColors];
    [self addSubview:pieView];
}

- (void)addContentContext{
    
    NSMutableArray *models = [NSMutableArray arrayWithArray:_pieList];
    [models addObjectsFromArray:_loopList];
    
    NSMutableArray *colors = [NSMutableArray arrayWithArray:_pieColors];
    [colors addObjectsFromArray:_loopColors];
    
    NSUInteger rows = models.count/2 + models.count%2;
    CGFloat margin  = 30;
    CGFloat originY = CGRectGetMaxY(_drawRect) + 20;
    CGFloat width  = (_contentRect.size.width - margin)/2;
    CGFloat height = (_contentRect.size.height - 80)/rows;
    
    for (int row = 0; row < rows; row++) {
        
        CGFloat Y = originY + height*row;
        for ( int j =0 ; j < 2; j++) {
            
            NSUInteger index = 2*row + j;
            DataModel *model = models[index];
            UIView *cellView = [[UIView alloc] initWithFrame:CGRectMake((margin + width)*j, Y, width, height)];
            [self addSubview:cellView];
            
            UIView *colorView = [[UIView alloc] initWithFrame:CGRectMake(2, 2, height - 4, height - 4)];
            colorView.backgroundColor = colors[index];
            [cellView addSubview:colorView];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(height + 10, 0, width - height- 20, height)];
            label.text = [NSString stringWithFormat:@"%@ %.1f %.1f%%",model.name, model.value, model.ratio*100];
            label.textColor = [UIColor grayColor];
            label.font = [UIFont systemFontOfSize:12];
            [cellView addSubview:label];
        }
    }
}

@end





