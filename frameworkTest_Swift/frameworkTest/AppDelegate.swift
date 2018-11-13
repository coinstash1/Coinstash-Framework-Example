//
//  AppDelegate.swift
//  frameworkTest
//
//  Created by Beach Digital Limited on 1/26/18.
//  Copyright © 2018 Beach Digital Limited. All rights reserved.
//

import Cocoa
import Mineful_Mac

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, MinefulDelegate {
    func onStartMineful() {
    
    }
    
    func userDidRegister() {
    }
    
    func userDidLogin() {
    }
    
    
    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var informationLabel: NSTextField!
    @IBOutlet weak var currentStatusLabel: NSTextField!
    
    var timer : Timer? = nil
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
        Mineful.stopMining()
        timer?.invalidate()

    }
    
    @IBAction func onStart(_ sender: Any) {
        Mineful.setApplicationInfo(uid: UID,
                                     secret: SECRET)
        Mineful.startTestMining([3333, 5555, 7777]) { (port) in
            if port != -1 {
                /*-----------------Set CPU Limit-------------------*/
                Mineful.setCPULimit(30)
                /*-----------------Start Mining-------------------*/
                //  Mineful.configure("configure")
                //  Mineful.showIntroView()
                Mineful.startMining(port: port,
                                      password: "x",
                                      coreCount: 4,
                                      slowMemory: "warn",
                                      currency: "monero",
                                      authorization: AUTHCODE,
                                      gpu: "detect"
                )
                
                self.timer?.invalidate()
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.showInformation(_:)), userInfo: nil, repeats: true)
            } else {
                print("No Ports Available")
            }
        }
        
        
    }
    
    @IBAction func onStop(_ sender: Any) {
        Mineful.stopMining()
        timer?.invalidate()
        
        currentStatusLabel.stringValue = Mineful.currentMinerStatus() ? "Running" : "Idle"
    }
    
    @objc func showInformation(_ timer : Timer) {
        informationLabel.stringValue = "Hash Rate : \(Mineful.getHashRate()) hash/s"
            +  "\nAccepted : \(Mineful.getAccepted())"
            +  "\nTotals : \(Mineful.getTotal())"
            +  "\nCPU Status: \(Mineful.currentCPU())%"
    }
}

