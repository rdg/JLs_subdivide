//
//  BoxItem.h
//  JLsPraystation
//
//  Created by Georg Duemlein on 14/04/18.
//  Copyright © 2018 Georg Duemlein. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/Appkit.h>
#import "CGVectorAdditions.h"

@interface BoxItem : NSObject

@property (assign) CGPoint a;
@property (assign) CGPoint b;
@property (assign) CGPoint c;
@property (assign) CGPoint d;

@property (nonatomic, retain) NSMutableArray *colors;
@property (nonatomic, strong) NSColor *color;
@property (nonatomic, retain) NSBezierPath *shape;
@property (nonatomic, retain) NSBezierPath *outline;

+ (instancetype) BoxItemWithA:(CGPoint)a andB:(CGPoint)b andC:(CGPoint)c andD:(CGPoint)d;
- (id) initWithA:(CGPoint)a andB:(CGPoint)b andC:(CGPoint)c andD:(CGPoint)d;

- (void) step;
- (void) draw;
- (NSMutableArray *)subdivide;

@end
