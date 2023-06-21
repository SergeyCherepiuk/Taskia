//
//  Task+CoreDataProperties.swift
//  Taskia
//
//  Created by Serhii Cherepiuk on 21/06/2023.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var due: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var isDone: Bool
    @NSManaged public var note: String?
    @NSManaged public var title: String?
    @NSManaged public var toCategory: Category?

}

extension Task : Identifiable {

}
