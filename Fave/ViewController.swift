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
        self.tableView.rowHeight = 60
        fetch()
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return (self.urls != nil) ? urls.count : 0
    }
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let url = urls.objectAtIndex(row) as SavedURL
        let cell = tableView.makeViewWithIdentifier("SavedURLCell", owner: self) as SavedURLCell
        cell.textField?.stringValue = url.title!
        cell.urlTextField.stringValue = url.url!
        return cell
    }
    
    func fetch() {
        var error : NSError?
        let result = AppDelegate.context().executeFetchRequest(NSFetchRequest(entityName: SavedURL.entityName()), error: &error)
        if (error == nil) {
            self.urls = result
            print(result!.count)
        }
    }
    
    func tableView(tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 60
    }
    
    
    @IBAction func reload(sender: NSButton) {
        fetch()
        self.tableView.reloadData()
    }

}

