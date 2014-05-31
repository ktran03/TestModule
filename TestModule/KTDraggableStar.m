//
//  KTDraggableStar.m
//  TestModule
//
//  Created by khanh tran on 2014-05-31.
//  Copyright (c) 2014 ktran03. All rights reserved.
//

#import "KTDraggableStar.h"

@implementation KTDraggableStar

#pragma mark - Init and lifecycle

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

#pragma mark - UIControl Methods

-(BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [super beginTrackingWithTouch:touch withEvent:event];
    return YES;
}

-(BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [super continueTrackingWithTouch:touch withEvent:event];
    CGPoint lastPointUserTouched = [touch locationInView:[self superview]];
    [self setCenter:lastPointUserTouched];
    return YES;
}

#pragma mark - Draw methods

-(void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [super endTrackingWithTouch:touch withEvent:event];
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    [[UIColor orangeColor] set];
    CGContextSetLineWidth(context,5.0f);
    CGContextMoveToPoint(context,self.frame.origin.x,self.frame.origin.y);
    CGContextAddLineToPoint(context,self.frame.size.width, 0);
    CGContextSetShadowWithColor(context, CGSizeMake(0, 0), 0, [UIColor grayColor].CGColor);
    CGContextStrokePath(context);
}

 
@end
