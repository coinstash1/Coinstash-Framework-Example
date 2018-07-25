//
//  AppDelegate.h
//  frameworkTest_Objc
//
//  Created by Beach Digital Limited on 2/1/18.
//  Copyright © 2018 Beach Digital Limited. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Coinstash_Mac/Coinstash_Mac.h>

@interface AppDelegate : NSObject <NSApplicationDelegate, CoinstashDelegate> {
    NSTimer *timer;

}

@end

