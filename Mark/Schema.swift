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
    let databaseNeedsInitialising = !NSFileManager.defaultManager().fileExistsAtPath(dbPath)
    let markDB = Database(dbPath) // Creates DB if it doesn't exist
    if (databaseNeedsInitialising) {
        markDB.foreignKeys = true
        Category.initialiseTable(markDB)
        Bookmark.initialiseTable(markDB)
        Tag.initialiseTable(markDB)
        BookmarkTag.initialiseTable(markDB)
    }
    markDB.trace(println)
    return markDB
}()

protocol Table {
    static var tableName : String { get }
    init(row : Row)
}

private protocol SchemaTable : Table {
    static func initialiseTable(db : Database) -> Query
}

extension Database {
    func allRecordsForTable<T: Table>(table : T.Type) -> [T] {
        let query = self[T.tableName]
        var results = [T]()
        for row in query {
            results.append(T(row: row))
        }
        return results
    }
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
            t.column(URLColumn, unique: true)
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

    required init(row : Row) {
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
            t.column(idColumn, primaryKey: .Autoincrement)
            t.column(nameColumn, unique: true)
        }
        return categories
    }
    
    required init(row : Row) {
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
            t.column(idColumn, primaryKey: .Autoincrement)
            t.column(nameColumn, unique: true)
        }
        return tags
    }
    
    required init(row : Row) {
        self.id = row[Tag.idColumn]
        self.name = row[Tag.nameColumn]
    }
    
    static func tagWithName(name : String, createIfNotExists : Bool = false) -> Tag? {
        let tagTable = db[Tag.tableName]
        let query = tagTable.filter(Tag.nameColumn == name)
        var tag : Tag?
        if let row = query.first {
            tag = Tag(row: row)
        } else if (createIfNotExists) {
            if let insertedId = tagTable.insert(Bookmark.nameColumn <- name) {
                if let row = tagTable.filter(Tag.idColumn == insertedId).first {
                    tag = Tag(row: row)
                }
            }
        }
        return tag
    }
}

class BookmarkTag : SchemaTable {
    static let tableName = "BookmarkTag"
    static let idColumn = Expression<Int64>("bookmark_tag_id")
    static let bookmarkID = Expression<Int64>("bookmark_id")
    static let tagID = Expression<Int64>("tag_id")
    
    let id : Int64
    let bookmarkID : Int64
    let tagID : Int64
    
    private static func initialiseTable(db: Database) -> Query {
        let bookmarkTags = db[tableName]
        let bookmarks = Bookmark.initialiseTable(db)
        let tags = Tag.initialiseTable(db)
        db.create(table: bookmarkTags, ifNotExists: true) { t in
            t.column(idColumn, primaryKey: .Autoincrement)
            t.column(bookmarkID)
            t.column(tagID)
            t.foreignKey(bookmarkID, references: bookmarks[Bookmark.idColumn], update: SchemaBuilder.Dependency.Cascade, delete: SchemaBuilder.Dependency.Cascade)
            t.foreignKey(tagID, references: tags[Tag.idColumn], update: SchemaBuilder.Dependency.Cascade, delete: SchemaBuilder.Dependency.Cascade)
            t.unique(bookmarkID, tagID)
        }
        return bookmarkTags
    }
    
    static func addTagToBookmark(bm : Bookmark, tag : Tag) -> BookmarkTag? {
        let query = db[tableName]
        var bt : BookmarkTag?
        if let insertedID = query.insert(bookmarkID <- bm.id, tagID <- tag.id) {
            if let row = query.filter(idColumn == insertedID).first {
                bt = BookmarkTag(row: row)
            }
        }
        return bt
    }
    
    required init(row: Row) {
        self.id = row[BookmarkTag.idColumn]
        self.bookmarkID = row[BookmarkTag.bookmarkID]
        self.tagID = row[BookmarkTag.tagID]
    }
    
}

