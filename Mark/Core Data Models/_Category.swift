// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Category.swift instead.

import CoreData

enum CategoryAttributes: String {
    case name = "name"
}

enum CategoryRelationships: String {
    case urls = "urls"
}

@objc
class _Category: NSManagedObject {

    // MARK: - Class methods

    class func entityName () -> String {
        return "Category"
    }

    class func entity(managedObjectContext: NSManagedObjectContext!) -> NSEntityDescription! {
        return NSEntityDescription.entityForName(self.entityName(), inManagedObjectContext: managedObjectContext);
    }

    // MARK: - Life cycle methods

    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }

    convenience init(managedObjectContext: NSManagedObjectContext!) {
        let entity = _Category.entity(managedObjectContext)
        self.init(entity: entity, insertIntoManagedObjectContext: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged
    var name: String?

    // func validateName(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    // MARK: - Relationships

    @NSManaged
    var urls: NSSet

}

extension _Category {

    func addUrls(objects: NSSet) {
        let mutable = self.urls.mutableCopy() as NSMutableSet
        mutable.unionSet(objects)
        self.urls = mutable.copy() as NSSet
    }

    func removeUrls(objects: NSSet) {
        let mutable = self.urls.mutableCopy() as NSMutableSet
        mutable.minusSet(objects)
        self.urls = mutable.copy() as NSSet
    }

    func addUrlsObject(value: SavedURL!) {
        let mutable = self.urls.mutableCopy() as NSMutableSet
        mutable.addObject(value)
        self.urls = mutable.copy() as NSSet
    }

    func removeUrlsObject(value: SavedURL!) {
        let mutable = self.urls.mutableCopy() as NSMutableSet
        mutable.removeObject(value)
        self.urls = mutable.copy() as NSSet
    }

}
