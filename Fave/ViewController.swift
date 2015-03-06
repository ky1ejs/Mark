//
//  ViewController.swift
//  Fave
//
//  Created by Kyle McAlpine on 06/03/2015.
//  Copyright (c) 2015 kylejm. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    var urls : NSArray!
    @IBOutlet var tableView : NSTableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        fetch()
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return urls.count
    }
    
    func tableView(tableView: NSTableView, objectValueForTableColumn tableColumn: NSTableColumn?, row: Int) -> AnyObject? {
        let url = urls.objectAtIndex(row) as FVURL
        let ident = tableColumn?.identifier as String!
        var string : NSString?
        switch ident {
        case "URL":
            string = url.url
            break
        case "Comment":
            string = url.comment
            break
        default:
            break
        }
        return string
    }
    
    func fetch() {
        var error : NSError?
        let result = AppDelegate.context().executeFetchRequest(NSFetchRequest(entityName: FVURL.entityName()), error: &error)
        if (error == nil) {
            self.urls = result
            print(result!.count)
        }
    }
    
    
    @IBAction func reload(sender: NSButton) {
        fetch()
        self.tableView.reloadData()
    }

}

