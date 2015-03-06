//
//  ViewController.swift
//  Fave
//
//  Created by Kyle McAlpine on 06/03/2015.
//  Copyright (c) 2015 kylejm. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    var urls : NSArray!

    override func viewDidLoad() {
        super.viewDidLoad()
        let fetch = NSFetchRequest(entityName: "URL");
        var error : NSError?
        let result = AppDelegate.context().executeFetchRequest(fetch, error: &error)
        if (error == nil) {
            urls = result
        }
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

