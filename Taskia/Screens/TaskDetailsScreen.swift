//
//  TaskDetailsScreen.swift
//  Taskia
//
//  Created by Serhii Cherepiuk on 10/06/2023.
//

import SwiftUI

struct TaskDetailsScreen: View {
    @State private var task: Task?
    @State private var title: String
    @State private var note: String
    @State private var category: Category?
    @State private var due: Date
    
    init(task: Task? = nil) {
        self._task = State(initialValue: task)
        self._title = State(initialValue: task?.title ?? "")
        self._note = State(initialValue: task?.note ?? "")
        self._category = State(initialValue: task?.toCategory)
        self._due = State(initialValue: Date.now)
    }
    
    var body: some View {
        TaskDetails(
            task: self.$task,
            title: self.$title,
            note: self.$note,
            category: self.$category,
            due: self.$due
        )
    }
}
