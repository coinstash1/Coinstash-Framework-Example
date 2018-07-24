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
    /*-----------------Showing Login/Registration UI-------------------*/
    /*
    //Coinstash.delegate = self;
    [Coinstash showCoinstashAccount];
    [Coinstash showPreferenceController]
     */
    /*-----------------Set CPU Limit-------------------*/
    [Coinstash setApplicationInfoWithUid:UID secret:SECRET];
    
    [Coinstash setCPULimit:39];
    /*-----------------Start Mining-------------------*/
    [Coinstash startMiningWithPort:3333
                          password:@"x"
                         coreCount:4
                        slowMemory:@"always"
                          currency:@"monero7"
                     authorization:AUTHCODE
                               gpu:@"detect"];
    
    if (timer != NULL) {
        [timer invalidate];
    }
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(showInformation:) userInfo:NULL repeats:TRUE];
}

- (IBAction)onStop:(id)sender {
    
    [Coinstash stopMining];
    [timer invalidate];
   
    [_currentStatusLabel setStringValue:[Coinstash currentMinerStatus] ? @"Running" : @"Idle"];
    
}

- (void)showInformation:(NSTimer*)timer {
    [_informationLabel setStringValue:[NSString stringWithFormat:
                                       @"Hash Rate : %lf hash/s\nAccepted: %ld\nTotals %ld\nCPU Status: %ld",
                                       [Coinstash getHashRate],
                                       [Coinstash getAccepted],
                                       [Coinstash getTotal],
                                       [Coinstash currentCPU]]];
}

@end
