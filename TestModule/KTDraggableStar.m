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
        self.backgroundColor = [UIColor clearColor];
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

-(void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [super endTrackingWithTouch:touch withEvent:event];
}

#pragma mark - Draw methods
- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    CGRect frame = self.frame;
    CGContextRef context = UIGraphicsGetCurrentContext();
    [[UIColor yellowColor] set];
    
    CGContextMoveToPoint(context,0,frame.size.height);
    CGContextAddLineToPoint(context,frame.size.width/2, 0);
    CGContextAddLineToPoint(context,frame.size.width, frame.size.height);
    CGContextAddLineToPoint(context,0, frame.size.height/3.0);
    CGContextAddLineToPoint(context,frame.size.width, frame.size.height/3.0);
    CGContextAddLineToPoint(context,0, frame.size.height);
    CGContextFillPath(context);
    
}

 
@end
