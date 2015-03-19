//
//  ViewController.swift
//  Mark
//
//  Created by Kyle McAlpine on 06/03/2015.
//  Copyright (c) 2015 kylejm. All rights reserved.
//

import Cocoa

class URLTableViewController : NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    var urls : NSArray!
    
    @IBOutlet weak var tableView : NSTableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        fetch()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "refresh", name:
            NSManagedObjectContextObjectsDidChangeNotification
, object: AppDelegate.context())
        self.tableView.rowHeight = 60
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return self.urls.count
    }
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.makeViewWithIdentifier("SavedURLCell", owner: self) as SavedURLCell
        let url = urls.objectAtIndex(row) as SavedURL
        cell.textField?.stringValue = url.title!
        cell.urlTextField.stringValue = url.url!
        return cell
    }
    
    func tableView(tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 60
    }
    
    func fetch() {
        var error : NSError?
        let result = AppDelegate.context().executeFetchRequest(NSFetchRequest(entityName: SavedURL.entityName()), error: &error)
        if (error == nil) {
            self.urls = result
        }
    }
    
    func refresh() {
        fetch()
        self.tableView.reloadData()
    }

}

