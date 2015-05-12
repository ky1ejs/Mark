
//  ViewController.swift
//  Mark
//
//  Created by Kyle McAlpine on 06/03/2015.
//  Copyright (c) 2015 kylejm. All rights reserved.
//

import Cocoa

class BookmarkTVC : NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    var bookmarks = [Bookmark]()
    @IBOutlet weak var tableView : NSTableView!
    @IBOutlet weak var detailView : BookmarkDetailViewController!

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
        cell.bookmark = bm
        return cell
    }
    
    func tableView(tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 60
    }
    
    func tableViewSelectionIsChanging(notification: NSNotification) {
        tableView.enumerateAvailableRowViewsUsingBlock { (rowView : NSTableRowView!, rowIndex : Int) -> Void in
            let viewForRow = rowView.viewAtColumn(0) as! BookmarkCell
            if rowView.selected {
                viewForRow.urlTextField.textColor = NSColor(calibratedRed:0.678431, green:0.678431, blue:0.678431, alpha:1.0)
            } else {
                viewForRow.urlTextField.textColor = NSColor(calibratedRed:0.313725, green:0.313725, blue:0.313725, alpha:1.0)
            }
            
        }
    }
    
    func tableViewSelectionDidChange(notification: NSNotification) {
      var selectedBm : Bookmark? = nil
      if (self.tableView.selectedRow > -1) {
        selectedBm = self.bookmarks[self.tableView.selectedRow]
      }
      self.detailView.bookmark = selectedBm
    }
    
    func insertBookmark(bm : Bookmark) {
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
            self.bookmarks.removeAtIndex(rowIndex)
            self.tableView.removeRowsAtIndexes(NSIndexSet(index: rowIndex), withAnimation: NSTableViewAnimationOptions.EffectFade)
        }
    }
    
    func fetchAndReload() {
        self.bookmarks = db.allRecordsForTable(Bookmark)
        self.tableView.reloadData()
    }

}