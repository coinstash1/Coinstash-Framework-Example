//
//  AppDelegate.m
//  frameworkTest_Objc
//
//  Created by Beach Digital Limited on 2/1/18.
//  Copyright © 2018 Beach Digital Limited. All rights reserved.
//

#import "AppDelegate.h"
#import "Credentials.h"


@interface AppDelegate ()
- (IBAction)onStart:(id)sender;
- (IBAction)onStop:(id)sender;
@property (weak) IBOutlet NSTextField *currentStatusLabel;
@property (weak) IBOutlet NSTextField *informationLabel;

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


- (IBAction)onStart:(id)sender{
    [Mineful setApplicationInfoWithUid:UID secret:SECRET];
    [Mineful startTestMining:[NSArray arrayWithObjects:
                                [NSNumber numberWithInt:3333],
                                [NSNumber numberWithInt:5555],
                                [NSNumber numberWithInt:7777]
                                , nil] completion:^(NSInteger port) {
        if (port != -1) {
            [Mineful setCPULimit:30];
            /*-----------------Start Mining-------------------*/
            [Mineful startMiningWithPort:port
                                  password:@"x"
                                 coreCount:4
                                slowMemory:@"always"
                                  currency:@"monero"
                             authorization:AUTHCODE
                                       gpu:@"detect"];
            
            if (timer != NULL) {
                [timer invalidate];
            }
            
            timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(showInformation:) userInfo:NULL repeats:TRUE];
        } else {
            printf("No Available Ports");
        }
    }];
    
    
    /*-----------------Showing Login/Registration UI-------------------*/
    /*
    //Coinstash.delegate = self;
    [Coinstash showCoinstashAccount];
    [Coinstash showPreferenceController]
     */
    /*-----------------Set CPU Limit-------------------*/
    
    
}

- (IBAction)onStop:(id)sender {
    
    [Mineful stopMining];
    [timer invalidate];
   
    [_currentStatusLabel setStringValue:[Mineful currentMinerStatus] ? @"Running" : @"Idle"];
    
}

- (void)showInformation:(NSTimer*)timer {
    [_informationLabel setStringValue:[NSString stringWithFormat:
                                       @"Hash Rate : %lf hash/s\nAccepted: %ld\nTotals %ld\nCPU Status: %ld",
                                       [Mineful getHashRate],
                                       [Mineful getAccepted],
                                       [Mineful getTotal],
                                       [Mineful currentCPU]]];
}

@end
