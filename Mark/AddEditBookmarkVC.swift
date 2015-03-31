//
//  AddEditURLViewController.swift
//  Mark
//
//  Created by Kyle McAlpine on 06/03/2015.
//  Copyright (c) 2015 kylejm. All rights reserved.
//

import Cocoa

class AddEditBookmarkVC : NSViewController, NSTextFieldDelegate {
    @IBOutlet var titleTF : NSTextField!
    @IBOutlet var urlTF : NSTextField!
    @IBOutlet var commentTF : NSTextField!
    @IBOutlet var labelTF : NSTextField!
    var activeTF : NSTextField!
    
    @IBAction func save(sender: NSButton) {
        let bm = Bookmark(managedObjectContext: mocStatic.moc)
        bm.title = self.titleTF.stringValue
        bm.url = self.urlTF.stringValue
        bm.comment = self.commentTF.stringValue
        var error : NSError?
        mocStatic.moc.save(&error)
        if (error != nil) {
            //TODO: handle this
            abort()
        }
    }
    
    override func controlTextDidBeginEditing(obj: NSNotification) {
        self.activeTF = obj.object as NSTextField
    }
    
    override func controlTextDidEndEditing(obj: NSNotification) {
        self.activeTF = nil
    }
    
    override func controlTextDidChange(obj: NSNotification) {
        //todo
    }
    
    @IBAction func toggleAddEditBookmarkViewHidden(sender: AnyObject) {
        if (self.view.hidden == false && self.activeTF != nil) {
            self.activeTF.resignFirstResponder()
        }
        self.view.hidden = !self.view.hidden
    }
    
}

