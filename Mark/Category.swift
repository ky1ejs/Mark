//
//  Category.swift
//  Mark
//
//  Created by Kyle McAlpine on 15/04/2015.
//  Copyright (c) 2015 kylejm. All rights reserved.
//

import SQLite

class Category {
    class var tableName : String { return "Categories" }
    
    class var idColumn : Expression<Int64> { return Expression<Int64>("category_id") }
    
    class var nameColumn : Expression<String> { return Expression<String>("name") }
    
    let id : Int64
    var name : String
    
    static func initialiseTable(db : Database) {
        let categories = db[self.tableName]
        
        db.create(table: categories, ifNotExists: true) { t in
            t.column(self.idColumn, primaryKey: .Autoincrement)
            t.column(self.nameColumn)
        }
    }
    
    static func categoriesFromQuery(query : Query) -> [Category] {
        var categories = [Category]()
        for row in query {
            categories.append(Category(row: row))
        }
        return categories
    }
    
    init(row : Row) {
        self.id = row[self.idColumn]
        self.name = row[self.nameColumn]
    }
}
