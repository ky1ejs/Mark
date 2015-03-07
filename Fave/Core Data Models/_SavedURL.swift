// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SavedURL.swift instead.

import CoreData

enum SavedURLAttributes: String {
    case comment = "comment"
    case rating = "rating"
    case title = "title"
    case url = "url"
}

enum SavedURLRelationships: String {
    case categories = "categories"
}

@objc
class _SavedURL: NSManagedObject {

    // MARK: - Class methods

    class func entityName () -> String {
        return "SavedURL"
    }

    class func entity(managedObjectContext: NSManagedObjectContext!) -> NSEntityDescription! {
        return NSEntityDescription.entityForName(self.entityName(), inManagedObjectContext: managedObjectContext);
    }

    // MARK: - Life cycle methods

    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }

    convenience init(managedObjectContext: NSManagedObjectContext!) {
        let entity = _SavedURL.entity(managedObjectContext)
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
    var categories: NSSet

}

extension _SavedURL {

    func addCategories(objects: NSSet) {
        let mutable = self.categories.mutableCopy() as NSMutableSet
        mutable.unionSet(objects)
        self.categories = mutable.copy() as NSSet
    }

    func removeCategories(objects: NSSet) {
        let mutable = self.categories.mutableCopy() as NSMutableSet
        mutable.minusSet(objects)
        self.categories = mutable.copy() as NSSet
    }

    func addCategoriesObject(value: Category!) {
        let mutable = self.categories.mutableCopy() as NSMutableSet
        mutable.addObject(value)
        self.categories = mutable.copy() as NSSet
    }

    func removeCategoriesObject(value: Category!) {
        let mutable = self.categories.mutableCopy() as NSMutableSet
        mutable.removeObject(value)
        self.categories = mutable.copy() as NSSet
    }

}
