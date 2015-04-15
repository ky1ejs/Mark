//
//  Category.swift
//  Mark
//
//  Created by Kyle McAlpine on 15/04/2015.
//  Copyright (c) 2015 kylejm. All rights reserved.
//

class Category: PFObject, PFSubclassing {
    @NSManaged var parentCategory : Category
    @NSManaged var name : String
    
    static func parseClassName() -> String {
        return "Category"
    }
}
