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
    @IBOutlet var titleTF : NSTextField!
    @IBOutlet var urlTF : NSTextField!
    
    override func viewDidLoad() {
        
    }
    
    @IBAction func save(sender: NSButton) {
        let url = SavedURL(managedObjectContext: AppDelegate.context())
        url.title = self.titleTF.stringValue
        url.url = self.urlTF.stringValue
        var error : NSError?
        AppDelegate.context().save(&error)
    }
    
}

