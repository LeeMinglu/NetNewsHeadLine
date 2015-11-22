//
//  MLHomeLabel.m
//  NetNewsHeadLine
//
//  Created by 李明禄 on 15/11/22.
//  Copyright © 2015年 SocererGroup. All rights reserved.
//

#import "MLHomeLabel.h"

@implementation MLHomeLabel

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.font = [UIFont systemFontOfSize:20];
        self.textAlignment = NSTextAlignmentCenter;
        self.userInteractionEnabled = YES;
        self.scale = 0.0;
    }
    return self;
}

- (void)setScale:(CGFloat)scale {
    _scale = scale;
    
    self.textColor = [UIColor colorWithRed:scale green:0.0 blue:0.0 alpha:1.0];
    
    CGFloat miniScale = 0.6;
    
    CGFloat FScale = miniScale + scale * (1 - miniScale);
    
    self.transform = CGAffineTransformMakeScale(FScale, FScale);
    
    
}

@end
