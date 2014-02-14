//
//  lineView.m
//  Hasuitter
//
//  Created by 大野 篤史 on 2014/01/31.
//  Copyright (c) 2014年 Atsushi Ohno. All rights reserved.
//

#import "LineView.h"

@implementation LineView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.window.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)drawRect:(CGRect)rect
{
    CGRect line = rect;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(context, 1, 1, 1, 1);
    CGContextFillRect(context, CGRectMake(0, 0, 1000, 1000));
    
    CGContextSetRGBStrokeColor(context, 0.1, 0.1, 0.1, 0.2);
    CGContextSetLineWidth(context, 1);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, line.origin.x, line.origin.y);
    //CGContextMoveToPoint(context, line.origin.x + 300, line.origin.y);
    CGContextAddLineToPoint(context, line.origin.x + 1000, line.origin.y);
    //CGContextStrokePath(context);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathStroke);
}

@end
