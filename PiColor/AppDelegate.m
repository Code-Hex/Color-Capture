//
//  AppDelegate.m
//  PiColor
//
//  Created by CodeHex on 2015/10/02.
//  Copyright © 2015年 CodeHex. All rights reserved.
//

#import "AppDelegate.h"
#import "RoundedView.h"
#import "ForegroundView.h"

#define UIColorFromRGB(rgbValue) [NSColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface NSColor(color)
+ (BOOL)isWhitish:(NSColor *)color;
@end

@implementation NSColor(color)

+ (BOOL)isWhitish:(NSColor *)color
{
    
    const CGFloat *rgba = CGColorGetComponents(color.CGColor);
    NSInteger rgbaCount = CGColorGetNumberOfComponents(color.CGColor);
    
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    CGFloat alpha;
    
    if (rgbaCount == 4) {
        red   = rgba[0];
        green = rgba[1];
        blue  = rgba[2];
        alpha = rgba[3];
    } else {
        red   = rgba[0];
        green = rgba[0];
        blue  = rgba[0];
        alpha = rgba[1];
    }
    
    CGFloat value = 0.299 * red + 0.587 * green + 0.114 * blue;
    
    return value >= 0.5 ? YES : NO;
}

@end

@interface AppDelegate ()

@property (weak) IBOutlet RoundedView *view;
@property (weak) IBOutlet ForegroundView *MainView;
@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    
    [_window setCollectionBehavior:NSWindowCollectionBehaviorCanJoinAllSpaces | NSWindowCollectionBehaviorFullScreenAuxiliary];
    [_window setLevel:NSFloatingWindowLevel];
    [NSApp activateIgnoringOtherApps:YES];

    NSArray *args = [[NSProcessInfo processInfo] arguments];
    NSString *argv = [args objectAtIndex:1];
    
    NSError *error = nil;
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(rgb|RGB)\\( ?(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?) ?, ?){2}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\)"
                                                      options:NSRegularExpressionCaseInsensitive
                                                        error:&error];
    
    NSTextCheckingResult *match = [regex firstMatchInString:argv
                                                    options:0
                                                      range:NSMakeRange(0, argv.length)];
    if (match) {
        NSLog(@"Match");
        argv = [argv stringByReplacingOccurrencesOfString:@"rgb" withString:@""];
        argv = [argv stringByReplacingOccurrencesOfString:@"RGB" withString:@""];
        argv = [argv stringByReplacingOccurrencesOfString:@"(" withString:@""];
        argv = [argv stringByReplacingOccurrencesOfString:@" " withString:@""];
        argv = [argv stringByReplacingOccurrencesOfString:@")" withString:@""];
        NSArray *colors = [argv componentsSeparatedByString:@","];
        
        color = [NSColor colorWithCalibratedRed:[[colors objectAtIndex:0] floatValue] / 255 green:[[colors objectAtIndex:1] floatValue] / 255 blue:[[colors objectAtIndex:2] floatValue] / 255 alpha:1];
    } else {
        argv = [argv stringByReplacingOccurrencesOfString:@"#" withString:@""];
        
        if (argv.length == 3) {
            NSString *red = [argv substringWithRange:NSMakeRange(0, 1)];
            NSString *green = [argv substringWithRange:NSMakeRange(1, 1)];
            NSString *blue = [argv substringWithRange:NSMakeRange(2, 1)];
            argv = [NSString stringWithFormat:@"%1$@%1$@%2$@%2$@%3$@%3$@", red, green, blue];
        }
        
        NSScanner *scan = [NSScanner scannerWithString:argv];
        
        unsigned int hex = 0;
        [scan scanHexInt:&hex];
        color = UIColorFromRGB(hex);
    }
    
    NSColor *backgroundcolor = [NSColor isWhitish:color] ? [NSColor colorWithCalibratedWhite:0.2 alpha:0.8]
                                                         : [NSColor colorWithCalibratedWhite:0.8 alpha:0.8];
    _window.backgroundColor = [NSColor clearColor];
    [_view setColor:backgroundcolor];
    [_MainView setRoundedView:_view];
    [_MainView setColor:color];
    _MainView.layer.cornerRadius = 25;
    [_window setOpaque:NO];
    [_window setStyleMask:NSBorderlessWindowMask];
    

    NSPoint loc = [NSEvent mouseLocation];

    [_window setFrame:CGRectMake(loc.x - 30, loc.y + 20, _window.frame.size.width , _window.frame.size.height) display:YES];
    int distance = 150;

    _EventHandler = [NSEvent addLocalMonitorForEventsMatchingMask:NSMouseMovedMask
                                          handler:^(NSEvent *event) {
         NSPoint point = [event locationInWindow];
      if (sqrt(pow(point.x - _window.frame.origin.x, 2) + pow(point.y - _window.frame.origin.y, 2)) > distance) {
          [NSEvent removeMonitor:_EventHandler];
          [_view fadeOutAndOrderOut:YES];
          return (NSEvent *)nil;
      }
         return event;
    }];
    
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end
