//
//  ForegroundView.h
//  PiColor
//
//  Created by CodeHex on 2015/10/04.
//  Copyright © 2015年 CodeHex. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "RoundedView.h"

@interface ForegroundView : NSView {
    NSColor *foreground;
    RoundedView *rview;
}

- (void)setColor:(NSColor *)bgColor;
- (void)setRoundedView:(RoundedView *)aView;

@end
