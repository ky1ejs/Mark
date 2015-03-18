//
//  AddEditURLViewController.swift
//  Fave
//
//  Created by Kyle McAlpine on 06/03/2015.
//  Copyright (c) 2015 kylejm. All rights reserved.
//

import Cocoa

class AddEditURLViewController: NSViewController {
    var urls : NSArray!
    @IBOutlet var titleTF : NSTextField!
    @IBOutlet var urlTF : NSTextField!
    @IBOutlet var commentTF: NSTextField!
    @IBOutlet var labelTF: NSTextField!
    
    @IBAction func save(sender: NSButton) {
        let url = SavedURL(managedObjectContext: AppDelegate.context())
        url.title = self.titleTF.stringValue
        url.url = self.urlTF.stringValue
        url.comment = self.commentTF.stringValue
        var error : NSError?
        AppDelegate.context().save(&error)
        if (error != nil) {
            //TODO: handle this
            abort()
        }
    }
    
}

