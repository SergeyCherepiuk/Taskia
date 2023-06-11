//
//  TasksListScreen.swift
//  Taskia
//
//  Created by Serhii Cherepiuk on 10/06/2023.
//

import SwiftUI
import CoreData

struct TasksListScreen: View {
    var body: some View {
        VStack {
            Header()
            TasksList()
        }
    }
}
