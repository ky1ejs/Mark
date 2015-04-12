
//  ViewController.swift
//  Mark
//
//  Created by Kyle McAlpine on 06/03/2015.
//  Copyright (c) 2015 kylejm. All rights reserved.
//

import Cocoa

class BookmarkTVC : NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    var bookmarks = [AnyObject]()
    @IBOutlet weak var tableView : NSTableView!
    
    override init?(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 60
        self.fetch()
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return self.bookmarks.count
    }
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.makeViewWithIdentifier("BookmarkCell", owner: self) as! BookmarkCell
        let bm = self.bookmarks[row] as! PFObject
        cell.textField?.stringValue = bm["title"] as! String
        cell.urlTextField.stringValue = bm["url"] as! String
        return cell
    }
    
    func tableView(tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 60
    }
    
    func fetch() {
        let query = PFQuery(className: "Bookmark")
        query.fromLocalDatastore()
        if let results = query.findObjects() {
            self.bookmarks = results
        }
    }
    
    func refresh() {
        fetch()
        self.tableView.reloadData()
    }

}