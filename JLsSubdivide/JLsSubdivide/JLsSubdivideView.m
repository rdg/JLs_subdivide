//
//  JLsSubdivideView.m
//  JLsSubdivide
//
//  Created by Georg Duemlein on 29/04/18.
//  Copyright © 2018 Georg Duemlein. All rights reserved.
//

#import "JLsSubdivideView.h"
#import "BoxItem.h"

@implementation JLsSubdivideView

- (instancetype)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {
        [self setAnimationTimeInterval:1/30.0];
        
        self.items =  [NSMutableArray arrayWithCapacity:1];
        CGPoint a = CGPointMake(2, self.bounds.size.height * 0.75);
        CGPoint b = CGPointMake(self.bounds.size.width - 2, self.bounds.size.height * 0.75);
        CGPoint c = CGPointMake(self.bounds.size.width - 2, self.bounds.size.height * 0.25);
        CGPoint d = CGPointMake(2, self.bounds.size.height * 0.25);
        [self.items addObject: [BoxItem BoxItemWithA:a andB:b andC:c andD:d]];
    }
    return self;
}

- (void)startAnimation
{
    [super startAnimation];
}

- (void)stopAnimation
{
    [super stopAnimation];
}

- (void)drawRect:(NSRect)rect
{
    [super drawRect:rect];
}

- (void)animateOneFrame
{
    int index = arc4random_uniform([self.items count]);
    if (SSRandomIntBetween(0, 100) < 12)
    {
        BoxItem *split = [self.items objectAtIndex:index];
        NSMutableArray *subdivided =  [split subdivide];
        [self.items removeObjectAtIndex:index];

        for (BoxItem *item in subdivided) {
            [self.items addObject:item];
        }
    }

    if ([self.items count] > 195 || SSRandomIntBetween(0, 1000) > 998)
    {
        [self.items removeAllObjects];
        CGPoint a = CGPointMake(2, self.bounds.size.height * 0.75);
        CGPoint b = CGPointMake(self.bounds.size.width - 2, self.bounds.size.height * 0.75);
        CGPoint c = CGPointMake(self.bounds.size.width - 2, self.bounds.size.height * 0.25);
        CGPoint d = CGPointMake(2, self.bounds.size.height * 0.25);
        [self.items addObject: [BoxItem BoxItemWithA:a andB:b andC:c andD:d]];
    }

    [[NSColor blackColor] set];
    [[NSBezierPath bezierPathWithRect:[self bounds]] fill];

    for (BoxItem *item in self.items) {
        [item draw];
    }
    
//    NSMutableParagraphStyle* textStyle = NSMutableParagraphStyle.defaultParagraphStyle.mutableCopy;
//    textStyle.alignment = NSTextAlignmentLeft;
//
//    NSDictionary* textFontAttributes = @{NSFontAttributeName: [NSFont fontWithName: @"Helvetica" size: 12], NSForegroundColorAttributeName: NSColor.redColor, NSParagraphStyleAttributeName: textStyle};
//
//    [[NSString stringWithFormat:@"%d", [self.items count]] drawInRect:[self bounds] withAttributes:textFontAttributes];
}

- (BOOL)hasConfigureSheet
{
    return NO;
}

- (NSWindow*)configureSheet
{
    return nil;
}

@end
