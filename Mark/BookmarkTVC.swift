
//  ViewController.swift
//  Mark
//
//  Created by Kyle McAlpine on 06/03/2015.
//  Copyright (c) 2015 kylejm. All rights reserved.
//

import Cocoa

class BookmarkTVC : NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    var bookmarks = [PFObject]()
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
        self.fetchAndReload()
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
        let bm = self.bookmarks[row]
        cell.textField?.stringValue = bm["title"] as! String
        cell.urlTextField.stringValue = bm["url"] as! String
        return cell
    }
    
    func tableView(tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 60
    }
    
    func insertBookmark(bm : PFObject) {
        self.bookmarks.insert(bm, atIndex: 0)
        self.tableView.insertRowsAtIndexes(NSIndexSet(index: 0), withAnimation: NSTableViewAnimationOptions.SlideDown)
    }
    
    @IBAction func deleteRow(sender: AnyObject) {
        let rowIndex = self.tableView.selectedRow
        if rowIndex > -1 {
            let bookmarks = self.bookmarks.count
            if bookmarks > 1 {
                var rowToSelect = rowIndex + 1
                if rowToSelect == bookmarks {
                    rowToSelect -= 2
                }
                self.tableView.selectRowIndexes(NSIndexSet(index: rowToSelect), byExtendingSelection: false)
            }
            self.bookmarks[rowIndex].unpinInBackgroundWithBlock(nil)
            self.bookmarks.removeAtIndex(rowIndex)
            self.tableView.removeRowsAtIndexes(NSIndexSet(index: rowIndex), withAnimation: NSTableViewAnimationOptions.EffectFade)
        }
    }
    
    func fetchAndReload() {
        let query = PFQuery(className: "Bookmark")
        query.fromLocalDatastore()
        query.findObjectsInBackgroundWithBlock { (results, error) -> Void in
            if (error == nil) {
                self.bookmarks = results as! [PFObject]
                self.tableView.reloadData()
            }
        }
    }

}