//
//  MainWindowViewController.swift
//  Mark
//
//  Created by Kyle McAlpine on 17/03/2015.
//  Copyright (c) 2015 kylejm. All rights reserved.
//

import Cocoa

class SplitVC : NSSplitViewController {
    
    @IBAction func toggleAddSplitView(sender: NSToolbarItem) {
        let view = self.splitView.subviews[2] as NSView
        view.hidden = !view.hidden
    }

    
}
