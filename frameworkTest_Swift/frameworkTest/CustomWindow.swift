//
//  CustomWindow.swift
//  frameworkTest
//
//  Created by KINGSTAR on 4/4/18.
//  Copyright © 2018 KINGSTAR. All rights reserved.
//

import Cocoa

class CustomWindow: NSWindow {
    override var canBecomeKey: Bool {
        return true
    }
    
    override var canBecomeMain: Bool{
        return true
    }
}
