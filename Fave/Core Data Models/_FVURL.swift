// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to FVURL.swift instead.

import CoreData

enum FVURLAttributes: String {
    case comment = "comment"
    case rating = "rating"
    case url = "url"
}

@objc
class _FVURL: NSManagedObject {

    // MARK: - Class methods

    class func entityName () -> String {
        return "URL"
    }

    class func entity(managedObjectContext: NSManagedObjectContext!) -> NSEntityDescription! {
        return NSEntityDescription.entityForName(self.entityName(), inManagedObjectContext: managedObjectContext);
    }

    // MARK: - Life cycle methods

    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }

    convenience init(managedObjectContext: NSManagedObjectContext!) {
        let entity = _FVURL.entity(managedObjectContext)
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
    var url: String?

    // func validateUrl(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    // MARK: - Relationships

}

