//
//  SchemeManager.swift
//  Mark
//
//  Created by Kyle McAlpine on 28/04/2015.
//  Copyright (c) 2015 kylejm. All rights reserved.
//

import SQLite
import AppKit

private let dbPath = NSHomeDirectory() + "/MarkDatabase"

let db : Database = {
    NSFileManager.defaultManager().removeItemAtPath(dbPath, error: nil)
    let databaseNeedsInitialising = !NSFileManager.defaultManager().fileExistsAtPath(dbPath)
    let markDB = Database(dbPath) // Creates DB if it doesn't exist
    if (databaseNeedsInitialising) {
        markDB.foreignKeys = true
        markDB.trace(println)
        Category.initialiseTable(markDB)
        Bookmark.initialiseTable(markDB)
        Tag.initialiseTable(markDB)
    }
    return markDB
}()

protocol Table {
    static var tableName : String { get }
}

private protocol SchemaTable : Table {
    static func initialiseTable(db : Database) -> Query
}

class Bookmark : SchemaTable {
    static let tableName = "Bookmarks"
    static let idColumn = Expression<Int64>("bookmark_id")
    static let nameColumn = Expression<String>("name")
    static let URLColumn = Expression<String>("url")
    static let commentColumn = Expression<String?>("comment")
    static let categoryColumn = Expression<Int64?>("category_id")

    let id : Int64
    var name : String
    var URLString : String
    var comment : String?

    private static func initialiseTable(db : Database) -> Query {
        let bookmarks = db[tableName]
        let categories = Category.initialiseTable(db)
        db.create(table: bookmarks, ifNotExists: true) { t in
            t.column(idColumn, primaryKey: .Autoincrement)
            t.column(nameColumn)
            t.column(URLColumn)
            t.column(commentColumn)
            t.column(categoryColumn)
            t.foreignKey(categoryColumn, references: categories[Category.idColumn], update: SchemaBuilder.Dependency.Cascade, delete: SchemaBuilder.Dependency.Cascade)
        }
        return bookmarks
    }

    static func bookmarksInQuery(query : Query) -> [Bookmark] {
        var bookmarks = [Bookmark]()
        for row in query {
            bookmarks.append(Bookmark(row: row))
        }
        return bookmarks
    }
    
    static func allBookmarks() -> [Bookmark] {
        return bookmarksInQuery(db[tableName])
    }

    init(row : Row) {
        self.id = row[Bookmark.idColumn]
        self.name = row[Bookmark.nameColumn]
        self.URLString = row[Bookmark.URLColumn]
        self.comment = row[Bookmark.commentColumn]
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


class Category : SchemaTable {
    static let tableName = "Categories"
    static let idColumn = Expression<Int64>("category_id")
    static let nameColumn = Expression<String>("name")
    
    let id : Int64
    var name : String
    
    private static func initialiseTable(db : Database) -> Query {
        
        let categories = db[self.tableName]
        
        db.create(table: categories, ifNotExists: true) { t in
            t.column(self.idColumn, primaryKey: .Autoincrement)
            t.column(self.nameColumn)
        }
        return categories
    }
    
    static func categoriesFromQuery(query : Query) -> [Category] {
        var categories = [Category]()
        for row in query {
            categories.append(Category(row: row))
        }
        return categories
    }
    
    init(row : Row) {
        self.id = row[Category.idColumn]
        self.name = row[Category.nameColumn]
    }
    
    init(name : String, db : Database) {
        let categories = db[Category.tableName]
        if let insertedId = categories.insert(Category.nameColumn <- name) {
            self.id = insertedId
            self.name = name
        } else {
            self.id = 0
            self.name = ""
        }
    }
}

class Tag : SchemaTable {
    static let tableName = "Tags"
    static let idColumn = Expression<Int64>("tag_id")
    static let nameColumn = Expression<String>("name")
    
    let id : Int64
    var name : String
    
    private static func initialiseTable(db : Database) -> Query {
        let tags = db[self.tableName]
        
        db.create(table: tags, ifNotExists: true) { t in
            t.column(self.idColumn, primaryKey: .Autoincrement)
            t.column(self.nameColumn)
        }
        return tags
    }
    
    static func tagsFromQuery(query : Query) -> [Tag] {
        var tags = [Tag]()
        for row in query {
            tags.append(Tag(row: row))
        }
        return tags
    }
    
    init(row : Row) {
        self.id = row[Tag.idColumn]
        self.name = row[Tag.nameColumn]
    }
    
    static func parseClassName() -> String {
        return "Tag"
    }
}

