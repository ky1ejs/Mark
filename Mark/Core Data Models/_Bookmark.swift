// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Bookmark.swift instead.

import CoreData

enum BookmarkAttributes: String {
    case comment = "comment"
    case rating = "rating"
    case title = "title"
    case url = "url"
}

enum BookmarkRelationships: String {
    case labels = "labels"
}

@objc
class _Bookmark: NSManagedObject {

    // MARK: - Class methods

    class func entityName () -> String {
        return "Bookmark"
    }

    class func entity(managedObjectContext: NSManagedObjectContext!) -> NSEntityDescription! {
        return NSEntityDescription.entityForName(self.entityName(), inManagedObjectContext: managedObjectContext);
    }

    // MARK: - Life cycle methods

    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }

    convenience init(managedObjectContext: NSManagedObjectContext!) {
        let entity = _Bookmark.entity(managedObjectContext)
        self.init(entity: entity, insertIntoManagedObjectContext: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged
    var comment: String?

    // func validateComment(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var rating: NSNumber?

    // func validateRating(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var title: String?

    // func validateTitle(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var url: String?

    // func validateUrl(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    // MARK: - Relationships

    @NSManaged
    var labels: NSSet

}

extension _Bookmark {

    func addLabels(objects: NSSet) {
        let mutable = self.labels.mutableCopy() as NSMutableSet
        mutable.unionSet(objects)
        self.labels = mutable.copy() as NSSet
    }

    func removeLabels(objects: NSSet) {
        let mutable = self.labels.mutableCopy() as NSMutableSet
        mutable.minusSet(objects)
        self.labels = mutable.copy() as NSSet
    }

    func addLabelsObject(value: Label!) {
        let mutable = self.labels.mutableCopy() as NSMutableSet
        mutable.addObject(value)
        self.labels = mutable.copy() as NSSet
    }

    func removeLabelsObject(value: Label!) {
        let mutable = self.labels.mutableCopy() as NSMutableSet
        mutable.removeObject(value)
        self.labels = mutable.copy() as NSSet
    }

}
