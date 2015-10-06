//
//  ForegroungroundView.m
//  PiColor
//
//  Created by CodeHex on 2015/10/04.
//  Copyright © 2015年 CodeHex. All rights reserved.
//

#import "ForegroundView.h"

@implementation ForegroundView

- (void)drawRect:(NSRect)dirtyRect {
    
    [foreground set];

    NSRectFill(dirtyRect);
    [super drawRect:dirtyRect];
    
}

- (void)setColor:(NSColor *)bgColor {
    foreground = bgColor;
    [self display];
}

- (void)setRoundedView:(RoundedView *)aView {
    rview = aView;
}

- (void)mouseDown:(NSEvent *)theEvent {
    if (theEvent.clickCount == 2)
        [self menuForEvent:theEvent];
}

- (BOOL)becomeFirstResponder {
    return YES;
}


- (NSMenu*)menuForEvent:(NSEvent*)event {
    NSMenu * menu = [[NSMenu alloc] initWithTitle:@"Copylist"];
    [menu addItemWithTitle:@"Copy as Hex" action:@selector(CopyasHex) keyEquivalent:@""];
    [menu addItemWithTitle:@"Copy as RGB" action:@selector(CopyasRGB) keyEquivalent:@""];
    [menu addItemWithTitle:@"Swift: Copy as UIColor" action:@selector(CopyasUIColor_swift) keyEquivalent:@""];
    [menu addItemWithTitle:@"Swift: Copy as NSColor" action:@selector(CopyasNSColor_swift) keyEquivalent:@""];
    [menu addItemWithTitle:@"Objective-C: Copy as UIColor" action:@selector(CopyasUIColor) keyEquivalent:@""];
    [menu addItemWithTitle:@"Objective-C: Copy as NSColor" action:@selector(CopyasNSColor) keyEquivalent:@""];
    [menu addItemWithTitle:@"Close" action:@selector(Close) keyEquivalent:@""];
    return menu;
}

- (void)CopyasHex {
    NSString* hexString = [NSString stringWithFormat:@"#%02X%02X%02X",
                           (int) (foreground.redComponent * 0xFF), (int) (foreground.greenComponent * 0xFF),
                           (int) (foreground.blueComponent * 0xFF)];
    [[NSPasteboard generalPasteboard] clearContents];
    [[NSPasteboard generalPasteboard] setString:hexString forType:NSStringPboardType];
    [rview fadeOutAndOrderOut:YES];
}

- (void)CopyasRGB {
    NSString *rgb = [NSString stringWithFormat:@"rgb(%1.f, %1.f, %1.f)", foreground.redComponent * 255, foreground.greenComponent * 255, foreground.blueComponent * 255];
    [[NSPasteboard generalPasteboard] clearContents];
    [[NSPasteboard generalPasteboard] setString:rgb forType:NSStringPboardType];
    [rview fadeOutAndOrderOut:YES];
}

- (void)CopyasUIColor_swift {
    NSString *uicolor = [NSString stringWithFormat:@"UIColor(red: %.3f, green: %.3f, blue: %.3f, alpha: 1)", foreground.redComponent, foreground.greenComponent, foreground.blueComponent];
    [[NSPasteboard generalPasteboard] clearContents];
    [[NSPasteboard generalPasteboard] setString:uicolor forType:NSStringPboardType];
    [rview fadeOutAndOrderOut:YES];
}

- (void)CopyasNSColor_swift {
    NSString *nscolor = [NSString stringWithFormat:@"NSColor(calibratedRed: %.3f, green: %.3f, blue: %.3f, alpha: 1)", foreground.redComponent, foreground.greenComponent, foreground.blueComponent];
    [[NSPasteboard generalPasteboard] clearContents];
    [[NSPasteboard generalPasteboard] setString:nscolor forType:NSStringPboardType];
    [rview fadeOutAndOrderOut:YES];
}

- (void)CopyasUIColor {
    NSString *uicolor = [NSString stringWithFormat:@"[UIColor colorWithRed:%.3f green:%.3f blue:%.3f alpha:1];", foreground.redComponent, foreground.greenComponent, foreground.blueComponent];
    [[NSPasteboard generalPasteboard] clearContents];
    [[NSPasteboard generalPasteboard] setString:uicolor forType:NSStringPboardType];
    [rview fadeOutAndOrderOut:YES];
}

- (void)CopyasNSColor {
    NSString *nscolor = [NSString stringWithFormat:@"[NSColor colorWithCalibratedRed:%.3f green:%.3f blue:%.3f alpha:1];", foreground.redComponent, foreground.greenComponent, foreground.blueComponent];
    [[NSPasteboard generalPasteboard] clearContents];
    [[NSPasteboard generalPasteboard] setString:nscolor forType:NSStringPboardType];
    [rview fadeOutAndOrderOut:YES];
}

- (void)Close {
    [rview fadeOutAndOrderOut:YES];
}

@end