//
//  RoundewWindow.m
//  PiColor
//
//  Created by CodeHex on 2015/10/03.
//  Copyright © 2015年 CodeHex. All rights reserved.
//

#import "RouondedWindow.h"

@implementation RoundedWindow

- (id)initWithContentRect:(NSRect)contentRect styleMask:(NSUInteger)aStyle backing:(NSBackingStoreType)bufferingType defer:(BOOL)flag
{
    self = [super initWithContentRect:contentRect styleMask:NSBorderlessWindowMask backing:bufferingType defer:flag];
    
    if (self)
    {
        [self setOpaque:NO];
        [self setBackgroundColor:[NSColor clearColor]];
        [self setMovableByWindowBackground:TRUE];
        [self setStyleMask:NSBorderlessWindowMask];
        [self setHasShadow:YES];
    }
    
    return self;
}

- (void)setContentView:(NSView *)aView
{
    aView.wantsLayer            = YES;
    aView.layer.frame           = aView.frame;
    aView.layer.cornerRadius    = 10.0;
    aView.layer.masksToBounds   = YES;
    
    [super setContentView:aView];
}


@end