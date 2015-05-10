//
//  BookmarkDetailViewController.swift
//  Mark
//
//  Created by Kyle McAlpine on 10/05/2015.
//  Copyright (c) 2015 kylejm. All rights reserved.
//

import Cocoa
import SQLite

class BookmarkDetailViewController: NSViewController {
    var bookmark : Bookmark? {
        didSet {
            if let bm = bookmark {
                self.nameLabel.stringValue = bm.name
                self.urlLabel.stringValue = bm.URLString
                let bmTagTable = db[BookmarkTag.tableName]
                let tagTable = db[Tag.tableName]
                let query = bmTagTable.select(BookmarkTag.idColumn, BookmarkTag.bookmarkID, tagTable[Tag.idColumn], tagTable[Tag.nameColumn])
                    .filter(BookmarkTag.bookmarkID == bm.id)
                    .join(tagTable, on: bmTagTable[BookmarkTag.tagID] == tagTable[Tag.idColumn])
                var tagsForBookmark = [String]()
                for row in query {
                    let tag = Tag(row: row)
                    tagsForBookmark.append(tag.name)
                }
                self.tagsTokenField.objectValue = tagsForBookmark
            } else {
                self.nameLabel.stringValue = ""
                self.urlLabel.stringValue = ""
                self.tagsTokenField.objectValue = nil
            }
        }
    }
    
    @IBOutlet weak var nameLabel : NSTextField!
    @IBOutlet weak var urlLabel : NSTextField!
    @IBOutlet weak var tagsTokenField : NSTokenField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}
