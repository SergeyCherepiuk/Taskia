//
//  Category+CoreDataProperties.swift
//  Taskia
//
//  Created by Serhii Cherepiuk on 21/06/2023.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var toTask: NSSet?
    
    public var toTaskArray: [Task] {
        let set = toTask as? Set<Task> ?? []
        return set.sorted {
            $0.title! < $1.title!
        }
    }

}

// MARK: Generated accessors for toTask
extension Category {

    @objc(addToTaskObject:)
    @NSManaged public func addToToTask(_ value: Task)

    @objc(removeToTaskObject:)
    @NSManaged public func removeFromToTask(_ value: Task)

    @objc(addToTask:)
    @NSManaged public func addToToTask(_ values: NSSet)

    @objc(removeToTask:)
    @NSManaged public func removeFromToTask(_ values: NSSet)

}

extension Category : Identifiable {

}
