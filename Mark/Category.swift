//
//  Category.swift
//  Mark
//
//  Created by Kyle McAlpine on 15/04/2015.
//  Copyright (c) 2015 kylejm. All rights reserved.
//

import SQLite

class Category {
    let tableName = "Categories"
    let idColumn = Expression<Int64>("category_id")
    let nameColumn = Expression<String>("name")
    
    let id : Int64
    var name : String
    
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
