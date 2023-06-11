//
//  TasksList.swift
//  Taskia
//
//  Created by Serhii Cherepiuk on 11/06/2023.
//

import SwiftUI
import CoreData

struct TasksList: View {
    @Environment(\.managedObjectContext) private var moc: NSManagedObjectContext
    @FetchRequest(sortDescriptors: []) private var tasks: FetchedResults<Task>
    
    var body: some View {
        List {
            ForEach(tasks) { task in
                ZStack {
                    TaskRow(task: task)
                    NavigationLink(destination: { TaskDetailsScreen(task: task) }) {
                        EmptyView()
                    }
                    .opacity(0)
                }
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
    
    private func removeTask(at offsets: IndexSet) {
        for index in offsets {
            let task = tasks[index]
            moc.delete(task)
            try? moc.save()
        }
    }
}
