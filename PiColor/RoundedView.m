//
//  RoundedView.m
//  PiColor
//
//  Created by CodeHex on 2015/10/03.
//  Copyright © 2015年 CodeHex. All rights reserved.
//

#import "RoundedView.h"

@implementation RoundedView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];

    [_background set];
    NSRectFill(dirtyRect);
    [super drawRect:dirtyRect];
    
}

- (void)setColor:(NSColor *)bgColor {
    _background = bgColor;
    [self display];
}

- (void)fadeOutAndOrderOut:(BOOL)orderOut {
    if (orderOut) {
        NSTimeInterval delay = [[NSAnimationContext currentContext] duration] + 0.1;
        [self performSelector:@selector(finishthisapp:) withObject:nil afterDelay:delay];
    }
    [[self animator] setAlphaValue:0.0];
}

- (void)finishthisapp:(id)sender {
    [NSApp terminate:self];
}

@end
