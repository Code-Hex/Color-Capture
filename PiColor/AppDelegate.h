//
//  AppDelegate.h
//  PiColor
//
//  Created by CodeHex on 2015/10/02.
//  Copyright © 2015年 CodeHex. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate> {
    NSColor *color;
}

@property (weak) id EventHandler;

@end

