//
//  Tag.swift
//  Mark
//
//  Created by Kyle McAlpine on 13/04/2015.
//  Copyright (c) 2015 kylejm. All rights reserved.
//

import SQLite

class Tag {
    let tableName = "Tags"
    let idColumn = Expression<Int64>("tag_id")
    let nameColumn = Expression<String>("name")
    
    let id : Int64
    var name : String
    
    static func tagsFromQuery(query : Query) -> [Tag] {
        var tags = [Tag]()
        for row in query {
            tags.append(Tag(row: row))
        }
        return tags
    }
    
    init(row : Row) {
        self.id = row[self.idColumn]
        self.name = row[self.nameColumn]
    }
    
    static func parseClassName() -> String {
        return "Tag"
    }
}
