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
    @IBOutlet var urlTF : NSTextField!
    @IBOutlet var commentTF : NSTextField!
    
    override func viewDidLoad() {
        
    }
    
    @IBAction func save(sender: NSButton) {
        let url = FVURL(managedObjectContext: AppDelegate.context())
        url.url = urlTF.stringValue
        url.comment = commentTF.stringValue
        var error : NSError?
        AppDelegate.context().save(&error)
        print(error)
    }
    
}

