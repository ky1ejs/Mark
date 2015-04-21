//
//  Bookmark.swift
//  Mark
//
//  Created by Kyle McAlpine on 13/04/2015.
//  Copyright (c) 2015 kylejm. All rights reserved.
//

import Cocoa
import SQLite

let bookmarkTableName = "Bookmarks"
let bookmarkIDColumn = Expression<Int64>("bookmark_id")
let bookmarkNameColumn = Expression<String>("name")
let bookmarkURLColumn = Expression<String>("url")
let bookmarkCommentColumn = Expression<String?>("comment")
let bookmarkCategoryColumn = Expression<Int64?>("category_id")

class Bookmark {
    
    let id : Int64
    var name : String
    var URLString : String
    var comment : String?
    
    static func bookmarksFromQuery(query : Query) -> [Bookmark] {
        var bookmarks = [Bookmark]()
        for row in query {
            bookmarks.append(Bookmark(row: row))
        }
        return bookmarks
    }
    
    init(row : Row) {
        self.id = row[bookmarkIDColumn]
        self.name = row[bookmarkNameColumn]
        self.URLString = row[bookmarkURLColumn]
        self.comment = row[bookmarkCommentColumn]
    }
    
    func URL() -> NSURL? {
        return NSURL(string: self.URLString)
    }
    
    func openURL() {
        if let URL = self.URL() {
            NSWorkspace.sharedWorkspace().openURL(URL)
        }
    }
}
