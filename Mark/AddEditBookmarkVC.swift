//
//  AddEditURLViewController.swift
//  Mark
//
//  Created by Kyle McAlpine on 06/03/2015.
//  Copyright (c) 2015 kylejm. All rights reserved.
//

import Cocoa
import SQLite

class AddEditBookmarkVC : NSViewController, NSTextFieldDelegate, NSTokenFieldDelegate {
    @IBOutlet weak var titleTF : NSTextField!
    @IBOutlet weak var urlTF : NSTextField!
    @IBOutlet weak var commentTF : NSTextField!
    @IBOutlet weak var tagsTF : NSTokenField!
    @IBOutlet weak var bookmarkTVC : BookmarkTVC!
    
    weak var activeTF : NSTextField!
    
    @IBAction func save(sender: NSButton) {
        if (!self.validateFields()) {
            return
        }
        
        let bookmarks = db[Bookmark.tableName]
        
        var setters = [Setter]()
        setters.append(Bookmark.nameColumn <- self.titleTF.stringValue)
        setters.append(Bookmark.URLColumn <- self.urlTF.stringValue)
        if (count(self.commentTF.stringValue) > 0) {
            setters.append(Bookmark.commentColumn <- self.commentTF.stringValue)
        }
        
//        if let tags = self.tagsTF.objectValue as? [String] where tags.count > 0 {
//            for tagName in tags {
//                let query = Tag.query()!
//                query.fromLocalDatastore()
//                query.whereKey("name", equalTo: tagName)
//                
//                var tag : Tag! = nil
//                if let results = query.findObjects() where results.count > 0 {
//                    tag = results.first as! Tag
//                } else {
//                    tag = Tag(className: "Tag")
//                    tag.name = tagName
//                }
//                tag.bookmarks.addObject(bm)
//                tag.pinInBackgroundWithBlock(nil)
//            }
//        }
        
        self.resetTextFields()
        self.titleTF.becomeFirstResponder()
        
        if let bmID = bookmarks.insert(setters) {
            let bm = Bookmark(row: bookmarks.filter(Bookmark.idColumn == bmID).first!)
            self.bookmarkTVC.insertBookmark(bm)
        }
        
    }
    
    // mark - Validation
    
    func validateFields() -> Bool {
        if count(self.titleTF.stringValue) == 0 {
            return false
        }
        if count(self.urlTF.stringValue) == 0 {
            return false
        }
        return true
    }
    
    override func controlTextDidChange(obj: NSNotification) {
        //todo
    }
    
    // mark - NSTokenFieldDelegate
    
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
    
    func tokenField(tokenField: NSTokenField, completionsForSubstring substring: String, indexOfToken tokenIndex: Int, indexOfSelectedItem selectedIndex: UnsafeMutablePointer<Int>) -> [AnyObject]? {
//        let query = Tag.query()
//        query?.fromLocalDatastore()
//        query?.whereKey("name", hasPrefix: substring)
//        let results = query?.findObjects()
        var names = [String]()
//        for tag in results as! [Tag] {
//            names.append(tag.name)
//        }
        return names
    }
    
    // mark - Managing the textfields
    
    override func controlTextDidBeginEditing(obj: NSNotification) {
        self.activeTF = obj.object as! NSTextField
    }
    
    override func controlTextDidEndEditing(obj: NSNotification) {
        self.activeTF = nil
    }
    
    func resetTextFields() {
        self.titleTF.stringValue = ""
        self.urlTF.stringValue = ""
        self.tagsTF.stringValue = ""
        self.commentTF.stringValue = ""
    }
    
}

