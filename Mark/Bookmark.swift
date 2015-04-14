//
//  Bookmark.swift
//  Mark
//
//  Created by Kyle McAlpine on 13/04/2015.
//  Copyright (c) 2015 kylejm. All rights reserved.
//

import Cocoa

class Bookmark: PFObject, PFSubclassing {
    
    @NSManaged var name : String
    @NSManaged var URLString : String
    @NSManaged var tags : [Tag]
    @NSManaged var comment : String
    
    static func parseClassName() -> String {
        return "Bookmark"
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
