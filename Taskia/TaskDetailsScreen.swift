//
//  TaskDetailsScreen.swift
//  Taskia
//
//  Created by Serhii Cherepiuk on 10/06/2023.
//

import SwiftUI

struct TaskDetailsScreen: View {
    private var task: Task?
    @State private var title: String
    @State private var note: String
    @State private var due: Date
    
    init(task: Task? = nil) {
        self.task = task
        self._title = State(initialValue: task?.title ?? "")
        self._note = State(initialValue: task?.note ?? "")
        self._due = State(initialValue: Date.now)
    }
    
    var body: some View {
        VStack(spacing: 20) {
            VStack {
                TextField(text: self.$title) {
                    Text("Title")
                }
                .lineLimit(1)
                Divider()
            }
            VStack {
                TextField(text: self.$note) {
                    Text("Note")
                }
                Divider()
            }
            DatePicker("", selection: self.$due)
                .datePickerStyle(.graphical)
            Spacer()
        }
        .padding(20)
        .navigationTitle("Task Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
