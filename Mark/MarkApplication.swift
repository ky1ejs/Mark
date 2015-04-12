//
//  MarkApplication.swift
//  Mark
//
//  Created by Kyle McAlpine on 12/04/2015.
//  Copyright (c) 2015 kylejm. All rights reserved.
//

import Cocoa

class MarkApplication: NSApplication {
    override init() {
        super.init()
        self.initialiseParse()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initialiseParse()
    }
    
    func initialiseParse() {
        Parse.enableLocalDatastore()
        Parse.setApplicationId(parseAPIKey, clientKey: parseClientKey)
    }
}
