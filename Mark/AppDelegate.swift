//
//  AppDelegate.swift
//  Mark
//
//  Created by Kyle McAlpine on 12/04/2015.
//  Copyright (c) 2015 kylejm. All rights reserved.
//

import Cocoa
import SQLite

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    var windowController: NSWindowController!

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        let dbPath = NSHomeDirectory() + "/MarkDatabase"
        NSFileManager.defaultManager().removeItemAtPath(dbPath, error: nil)
        let databaseNeedsInitialising = !NSFileManager.defaultManager().fileExistsAtPath(dbPath)
        let db = Database(dbPath) //Creates if doesn't exist
        if (databaseNeedsInitialising) {
            
            db.foreignKeys = true
            db.trace(println)
            
            let categories = db["Categories"]
            let categoryID = Expression<Int64>("category_id")
            let name = Expression<String>("name")
            
            db.create(table: categories) { t in
                t.column(categoryID, primaryKey: .Autoincrement)
                t.column(name)
            }
            
            let bookmarks = db["Bookmarks"]
            let bookmarkID = Expression<Int64>("bookmark_id")
            let url = Expression<String>("url")
            let comment = Expression<String?>("comment")
            let categoryFK = Expression<Int64?>("category_id")
            
            db.create(table: bookmarks) { t in
                t.column(bookmarkID, primaryKey: .Autoincrement)
                t.column(name)
                t.column(url)
                t.column(comment)
                t.column(categoryFK)
                t.foreignKey(categoryFK, references: categories[categoryID], update: SchemaBuilder.Dependency.Cascade, delete: SchemaBuilder.Dependency.Cascade)
            }
            
            let tags = db["Tags"]
            let tagID = Expression<Int64>("tag_id")
            
            db.create(table: tags) { t in
                t.column(tagID, primaryKey: .Autoincrement)
                t.column(name)
            }
            
            if let cat = categories.insert(name <- "test-category") {
                if let bm = bookmarks.insert(name <- "alice@mac.com", url <- "http://kylejm.io", categoryFK <- cat) {
                    println("woot!")
                }
                if let bm = bookmarks.insert(name <- "test 2", url <- "http://kylejm.io", categoryFK <- cat) {
                    println("woot!")
                }
            }
            
            let results = bookmarks.join(categories, on: categories[categoryID] == bookmarks[categoryFK])
            for result in results {
                println(result[bookmarks[name]])
            }
        }
        
        
        Parse.enableLocalDatastore()
        Bookmark.registerSubclass()
        Tag.registerSubclass()
        Parse.setApplicationId(parseAPIKey, clientKey: parseClientKey)
        
        self.windowController = NSWindowController(windowNibName: "BookmarkWindow")
        self.windowController.showWindow(self)
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}

