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
    cable = [[MinefulCable alloc] init];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


- (IBAction)onStart:(id)sender{
//    [Mineful checkAuthWithEmail:@"vasilurda.sun@gmail.com" password:@"test1234" completion:^(NSDictionary<NSString *,id> * response) {
//        cable.OnMessageEvent = ^(NSError * error, NSDictionary<NSString *,id> * result) {
//            if (error == NULL) {
//                NSDictionary<NSString *,NSString *> *identifier = result[@"identifier"];
//                NSString* type = identifier[@"type"];
//
//            }
//        };
//        [cable UserChannelSubscribe];
//    }];
    [Mineful setApplicationInfoWithUid:UID secret:SECRET];
    /*-----------------Start Mining-------------------*/
    [Mineful startPortTestingWithOrders:AUTHCODE completion:^(NSInteger port) {
        if (port != -1) {
            printf("%d", port);
            [Mineful setCPULimit:30];
            [Mineful startMiningWithOrdersWithPort:port password:@"x" coreCount:4 slowMemory:@"always" gpu:@"detect" authorization:AUTHCODE];
        
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
