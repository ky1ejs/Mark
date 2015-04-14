//
//  BookmarkTable.swift
//  Mark
//
//  Created by Kyle McAlpine on 13/04/2015.
//  Copyright (c) 2015 kylejm. All rights reserved.
//

import Cocoa

class BookmarkTable: NSTableView {
    override func validateProposedFirstResponder(responder: NSResponder, forEvent event: NSEvent?) -> Bool {
        return true
    }
}
