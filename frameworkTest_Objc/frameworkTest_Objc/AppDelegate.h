//
//  AppDelegate.h
//  frameworkTest_Objc
//
//  Created by Beach Digital Limited on 2/1/18.
//  Copyright © 2018 Beach Digital Limited. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Mineful_Mac/Mineful_Mac.h>

@interface AppDelegate : NSObject <NSApplicationDelegate, MinefulDelegate> {
    NSTimer *timer;

}

@end

