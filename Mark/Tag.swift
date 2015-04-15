//
//  Tag.swift
//  Mark
//
//  Created by Kyle McAlpine on 13/04/2015.
//  Copyright (c) 2015 kylejm. All rights reserved.
//

import Cocoa

class Tag: PFObject, PFSubclassing {
    @NSManaged var name : String
    @NSManaged var bookmarks : PFRelation
    
    static func parseClassName() -> String {
        return "Tag"
    }
}
