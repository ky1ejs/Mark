//
//  AppDelegate.swift
//  Mark
//
//  Created by Kyle McAlpine on 12/04/2015.
//  Copyright (c) 2015 kylejm. All rights reserved.
//

import Cocoa
import SQLite

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    var windowController: NSWindowController!

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        
        self.windowController = NSWindowController(windowNibName: "BookmarkWindow")
        self.windowController.showWindow(self)
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    
    func applicationShouldHandleReopen(sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        self.windowController.showWindow(self)
        return true
    }


}

