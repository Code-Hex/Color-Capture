//
//  RoundedView.h
//  PiColor
//
//  Created by CodeHex on 2015/10/03.
//  Copyright © 2015年 CodeHex. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface RoundedView : NSView

@property (weak) NSColor *background;

- (void)setColor:(NSColor *)bgColor;
- (void)fadeOutAndOrderOut:(BOOL)orderOut;
@end
