//
//  SavedURLCell.swift
//  Mark
//
//  Created by Kyle McAlpine on 07/03/2015.
//  Copyright (c) 2015 kylejm. All rights reserved.
//

import Cocoa

class BookmarkCell : NSTableCellView {
    @IBOutlet private var urlTextField : NSTextField!
    
    var bookmark : Bookmark! {
        didSet {
            self.textField?.stringValue = self.bookmark.name
            self.urlTextField.stringValue = self.bookmark.URLString
        }
    }
    
    override func mouseDown(theEvent: NSEvent) {
        if let tv = self.superview?.superview as? NSTableView {
            tv.mouseDown(theEvent)
        }
        if theEvent.clickCount == 2 {
            self.bookmark.openURL()
        }
    }
}