//
//  TasksListScreen.swift
//  Taskia
//
//  Created by Serhii Cherepiuk on 10/06/2023.
//

import SwiftUI
import CoreData

struct TasksListScreen: View {
    @Environment(\.managedObjectContext) var moc: NSManagedObjectContext
    @FetchRequest(sortDescriptors: []) var tasks: FetchedResults<Task>
    
    var body: some View {
        VStack {
            Header()
            List {
                ForEach(tasks) { task in
                    TaskRow(task: task, moc: moc)
                        .background(RoundedRectangle(cornerRadius: 15).fill(.white))
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets(
                            top: 4,
                            leading: 0,
                            bottom: 4,
                            trailing: 0
                        ))
                }
                .onDelete(perform: removeTask)
            }
            .listStyle(.insetGrouped)
            .navigationBarHidden(true)
        }
    }
    
    func removeTask(at offsets: IndexSet) {
        for index in offsets {
            let task = tasks[index]
            moc.delete(task)
            try? moc.save()
        }
    }
}
