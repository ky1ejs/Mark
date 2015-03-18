//
//  ViewController.swift
//  Fave
//
//  Created by Kyle McAlpine on 06/03/2015.
//  Copyright (c) 2015 kylejm. All rights reserved.
//

import Cocoa

class URLTableViewController : NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    var urls : NSArray!
    var isAddingRecord : Bool = false
    
    @IBOutlet weak var tableView : NSTableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        fetch()
        self.tableView.rowHeight = 60
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return (self.urls != nil) ? (self.isAddingRecord) ? urls.count + 1 : self.urls.count : 0
    }
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.makeViewWithIdentifier("SavedURLCell", owner: self) as SavedURLCell
        if (!self.isAddingRecord || row != 0) {
            let url = urls.objectAtIndex(row) as SavedURL
            cell.textField?.stringValue = url.title!
            cell.urlTextField.stringValue = url.url!
            return cell
        }
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
    
    @IBAction func addButtonClicked(sender: NSButton) {
//        let addEditView = self.splitVC.splitViewItems.last as NSSplitViewItem
//        addEditView.animator().collapsed = false
//        if !self.isAddingRecord {
//            self.isAddingRecord = true
//            self.tableView.insertRowsAtIndexes(NSIndexSet(index: 0), withAnimation: NSTableViewAnimationOptions.SlideDown)
//        
//        }
    }
    

}

