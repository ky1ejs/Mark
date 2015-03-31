
//  ViewController.swift
//  Mark
//
//  Created by Kyle McAlpine on 06/03/2015.
//  Copyright (c) 2015 kylejm. All rights reserved.
//

import Cocoa

class BookmarkTVC : NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    var urls : NSArray!
    @IBOutlet weak var tableView : NSTableView!
    
    override init?(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.fetch()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.fetch()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "refresh", name: NSManagedObjectContextObjectsDidChangeNotification, object: CDStack.moc)
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
        let cell = tableView.makeViewWithIdentifier("BookmarkCell", owner: self) as BookmarkCell
        let bm = urls.objectAtIndex(row) as Bookmark
        cell.textField?.stringValue = bm.title!
        cell.urlTextField.stringValue = bm.url!
        return cell
    }
    
    func tableView(tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 60
    }
    
    func fetch() {
        var error : NSError?
        let result = CDStack.moc.executeFetchRequest(NSFetchRequest(entityName: Bookmark.entityName()), error: &error)
        if (error == nil) {
            self.urls = result
        }
    }
    
    func refresh() {
        fetch()
        self.tableView.reloadData()
    }

}