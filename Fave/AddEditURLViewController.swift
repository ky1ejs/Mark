//
//  AddEditURLViewController.swift
//  Fave
//
//  Created by Kyle McAlpine on 06/03/2015.
//  Copyright (c) 2015 kylejm. All rights reserved.
//

import Cocoa

class AddEditURLViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    var urls : NSArray!
    
    override func viewDidLoad() {
        
    }
    
    override var representedObject: AnyObject? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return urls.count
    }
    
}

