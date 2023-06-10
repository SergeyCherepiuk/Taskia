//
//  DataController.swift
//  Taskia
//
//  Created by Serhii Cherepiuk on 10/06/2023.
//

import Foundation
import CoreData

class DataController : ObservableObject {
    let container = NSPersistentContainer(name: "Taskia")
    
    init() {
        container.loadPersistentStores { description, error in
            if error != nil {
                print("Core Data failer to load: \(error!.localizedDescription)")
            }
        }
    }
}
