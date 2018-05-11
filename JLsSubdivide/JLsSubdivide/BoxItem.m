//
//  BoxItem.m
//  JLsPraystation
//
//  Created by Georg Duemlein on 14/04/18.
//  Copyright © 2018 Georg Duemlein. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>
#import "BoxItem.h"
#import "CGVectorAdditions.h"

@implementation BoxItem

+ (instancetype) BoxItemWithA:(CGPoint)a andB:(CGPoint)b andC:(CGPoint)c andD:(CGPoint)d
{
    BoxItem *item = [[BoxItem alloc] initWithA:a andB:b andC:c andD:d];
    return item;
}

- (id) initWithA:(CGPoint)a andB:(CGPoint)b andC:(CGPoint)c andD:(CGPoint)d
{
    self = [super init];
    if (self)
    {
        self.a = a;
        self.b = b;
        self.c = c;
        self.d = d;
        

        self.colors = [NSMutableArray arrayWithCapacity:(4)];
        [self.colors addObject:[NSColor colorWithCalibratedRed:0.1
                                                         green:0.1
                                                          blue:0.1
                                                         alpha:1]];
        [self.colors addObject:[NSColor colorWithCalibratedRed:1
                                                         green:1
                                                          blue:1
                                                         alpha:1]];
        [self.colors addObject:[NSColor colorWithCalibratedRed:97.0 / 255.0
                                                         green:35.0 / 255.0
                                                          blue:159.0 / 255.0
                                                         alpha:1]];
        
        [self.colors addObject:[NSColor colorWithCalibratedRed:240.0 / 255.0
                                                         green:78.0 / 255.0
                                                          blue:152.0 / 255.0
                                                         alpha:1]];
        [self.colors addObject:[NSColor colorWithCalibratedRed:97.0 / 255.0
                                                         green:35.0 / 255.0
                                                          blue:159.0 / 255.0
                                                         alpha:1]];
        
        [self.colors addObject:[NSColor colorWithCalibratedRed:240.0 / 255.0
                                                         green:78.0 / 255.0
                                                          blue:152.0 / 255.0
                                                         alpha:1]];
        
        self.shape = [[NSBezierPath alloc] init];
        self.outline = [[NSBezierPath alloc] init];
        [self.outline setLineWidth:2.0];
        CGFloat dash_pattern[]={2 + arc4random_uniform(5), 1 + arc4random_uniform(7)};
        [self.outline setLineDash:dash_pattern count:1 phase:1];
        if ((float)arc4random() / UINT32_MAX < 0.5) {
            self.color =  [self.colors objectAtIndex:0];
        }else{
            self.color =  [self.colors objectAtIndex:arc4random_uniform([self.colors count])];
        }

    }
    return self;
}

-(void) step
{
    return;
}

-(void) draw
{
    
    [self.outline removeAllPoints];

    [self.outline moveToPoint:self.a];
    [self.outline lineToPoint:self.b];
    [self.outline lineToPoint:self.c];
    [self.outline lineToPoint:self.d];
    [self.outline lineToPoint:self.a];
    
    [[NSColor colorWithRed:0.75 green:0.75 blue:0.75 alpha:1] set];
    [self.outline stroke];
    // self.color =  [self.colors objectAtIndex:arc4random_uniform([self.colors count])];
    [self.color set];
    [self.outline fill];
    
}
-(NSMutableArray *)subdivide
{
    NSMutableArray *returnValue = [[NSMutableArray alloc] init];
    NSMutableArray *corners = [[NSMutableArray alloc] init];
    [corners addObject:[NSValue valueWithPoint:self.a]];
    [corners addObject:[NSValue valueWithPoint:self.b]];
    [corners addObject:[NSValue valueWithPoint:self.c]];
    [corners addObject:[NSValue valueWithPoint:self.d]];
    
    int s = arc4random_uniform(3);
    NSValue *a = [corners objectAtIndex:s];
    NSValue *b = [corners objectAtIndex:(s + 1) % 4];
    NSValue *c = [corners objectAtIndex:(s + 2) % 4];
    NSValue *d = [corners objectAtIndex:(s + 3) % 4];

    CGVector e0 = CGVectorDifference(CGVectorFromPoint(b.pointValue), CGVectorFromPoint(a.pointValue));
    float d0 = CGVectorDistance(CGVectorFromPoint(b.pointValue), CGVectorFromPoint(a.pointValue));

    if (d0 < 5) {
        return returnValue;
    }

    CGVector e1 = CGVectorDifference(CGVectorFromPoint(c.pointValue), CGVectorFromPoint(d.pointValue));
    float d1 = CGVectorDistance(CGVectorFromPoint(c.pointValue), CGVectorFromPoint(d.pointValue));

    if (d1 < 5) {
        return returnValue;
    }

    CGVector va = CGVectorSum(CGVectorFromPoint(a.pointValue), CGVectorMultiplyByScalar(CGVectorNormalize(e0), d0 * (float)arc4random() / UINT32_MAX));
    CGVector vc = CGVectorDifference(CGVectorFromPoint(c.pointValue), CGVectorMultiplyByScalar(CGVectorNormalize(e1), d1 * 0.5));

    CGVector v = va;
    CGVector w = vc;
    
    CGPoint v1 = CGPointMake(v.dx, v.dy);
    CGPoint v2 = CGPointMake(v.dx + 2, v.dy);
    CGPoint w1 = CGPointMake(w.dx , w.dy);
    CGPoint w2 = CGPointMake(w.dx + 2, w.dy + 2);

    
    [returnValue  addObject: [BoxItem BoxItemWithA:a.pointValue andB:v1 andC:w1 andD:d.pointValue]];
    [returnValue  addObject: [BoxItem BoxItemWithA:v1 andB:b.pointValue andC:c.pointValue andD:w1]];
    return returnValue;
}
@end
