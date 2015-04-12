//
//  AddEditURLViewController.swift
//  Mark
//
//  Created by Kyle McAlpine on 06/03/2015.
//  Copyright (c) 2015 kylejm. All rights reserved.
//

import Cocoa

class AddEditBookmarkVC : NSViewController, NSTextFieldDelegate, NSTokenFieldDelegate {
    @IBOutlet var titleTF : NSTextField!
    @IBOutlet var urlTF : NSTextField!
    @IBOutlet var commentTF : NSTextField!
    @IBOutlet var tagsTF : NSTokenField!
    var activeTF : NSTextField!
    
    @IBAction func save(sender: NSButton) {
        //TODO: validation
        
        let tags = self.tagsTF.objectValue as! [String]
        var tagObjects = [PFObject]()
        for tag in tags {
            let query = PFQuery(className: "Tag")
            query.fromLocalDatastore()
            query.whereKey("name", equalTo: tag)
            if let results = query.findObjects() where results.count > 0 {
                tagObjects.append(results[0] as! PFObject)
            } else {
                let newTag = PFObject(className: "Tag")
                newTag["name"] = tag
                tagObjects.append(newTag)
            }
        }
        let bm = PFObject(className: "Bookmark")
        bm["title"] = self.titleTF.stringValue
        bm["url"] = self.urlTF.stringValue
        bm["comment"] = self.commentTF.stringValue
        bm["tags"] = tagObjects
        bm.pin()
    }
    
    func tokenField(tokenField: NSTokenField, shouldAddObjects tokens: [AnyObject], atIndex index: Int) -> [AnyObject] {
        if let newTokens = tokens as? [String] {
            var allowedTokens = [String]()
            var currentTokens = self.tagsTF.objectValue as! [String]
            for token in newTokens {
                if let firstIndex = find(currentTokens, token) {
                    if find(currentTokens[firstIndex.successor() ..< currentTokens.endIndex], token) == nil {
                        allowedTokens.append(token)
                    }
                }
            }
            
            return allowedTokens
        }
        
        return [AnyObject]()
    }
    
    override func controlTextDidBeginEditing(obj: NSNotification) {
        self.activeTF = obj.object as! NSTextField
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

