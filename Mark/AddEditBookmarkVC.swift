//
//  AddEditURLViewController.swift
//  Mark
//
//  Created by Kyle McAlpine on 06/03/2015.
//  Copyright (c) 2015 kylejm. All rights reserved.
//

import Cocoa

class AddEditBookmarkVC : NSViewController, NSTextFieldDelegate, NSTokenFieldDelegate {
    @IBOutlet weak var titleTF : NSTextField!
    @IBOutlet weak var urlTF : NSTextField!
    @IBOutlet weak var commentTF : NSTextField!
    @IBOutlet weak var tagsTF : NSTokenField!
    @IBOutlet weak var bookmarkTVC : BookmarkTVC!
    
    weak var activeTF : NSTextField!
    
    @IBAction func save(sender: NSButton) {
        //TODO: validation

        let bm = Bookmark(className: "Bookmark")
        bm.name = self.titleTF.stringValue
        bm.URLString = self.urlTF.stringValue
        bm.comment = self.commentTF.stringValue
        bm.pinInBackgroundWithBlock(nil)
        
        let tags = self.tagsTF.objectValue as! [String]
        for tagName in tags {
            let query = Tag.query()!
            query.fromLocalDatastore()
            query.whereKey("name", equalTo: tagName)
            
            var tag : Tag! = nil
            if let results = query.findObjects() where results.count > 0 {
                tag = results.first as! Tag
            } else {
                tag = Tag(className: "Tag")
            }
            tag.bookmarks.addObject(bm)
            tag.pinInBackgroundWithBlock(nil)
        }
        
        self.bookmarkTVC.insertBookmark(bm)
    }
    
    func tokenField(tokenField: NSTokenField, shouldAddObjects tokens: [AnyObject], atIndex index: Int) -> [AnyObject] {
        if let newTokens = tokens as? [String] {
            var allowedTokens = [String]()
            var currentTokens = self.tagsTF.objectValue as! [String]
            for token in newTokens {
                if let firstIndex = find(currentTokens, token) {
                    //Always will be found the first time since NSTokenField adds the token to it's "objectValue" before calling this function
                    if find(currentTokens[firstIndex.successor() ..< currentTokens.endIndex], token) == nil {
                        allowedTokens.append(token)
                    }
                }
            }
            
            return allowedTokens
        }
        
        return [AnyObject]()
    }
    
//    func findMultiple<C: CollectionType where C.Generator.Element: Equatable>(collection: C, element: C.Generator.Element, times: Int) -> Bool {
//        var found = true
//        let size = collection.count
//        var i = 1
//        for anElement in collection {
//            
//        }
//        for (var i = 0; i < times; i++) {
//            if let foundForI = find(elements, element) {
//                elements = [foundForI.successor() ..< elements.endIndex]
//            } else {
//                found = false
//                break
//            }
//        }
//        return found
//    }
    
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

