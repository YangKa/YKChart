//
//  DataModel.m
//  StudyDemo
//
//  Created by qiager on 2018/3/22.
//  Copyright © 2018年 yangka. All rights reserved.
//

#import "YKDataModel.h"

@implementation YKDataModel

- (CGFloat)ratio{
    if (self.value == 0 || self.total == 0) {
        return 0.0;
    }
    
    return self.value/self.total;
}

- (CGFloat)angle{
    
    return  self.ratio*360;
}

@end
