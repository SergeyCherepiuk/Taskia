//
//  TaskDetailsScreen.swift
//  Taskia
//
//  Created by Serhii Cherepiuk on 10/06/2023.
//

import SwiftUI
import CoreData

struct TaskDetailsScreen: View {
    @Environment(\.managedObjectContext) private var moc: NSManagedObjectContext
    @Environment(\.presentationMode) private var presentationMode
    
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
            VStack {
                NavigationLink(destination: { CategoriesListScreen(selectedCategory: self.$category) }) {
                    HStack {
                        Text("Category")
                            .foregroundColor(.black)
                        Spacer()
                        Text(self.category?.name ?? "No category")
                            .foregroundColor(.gray)
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }
                }
                Divider()
            }
            DatePicker("", selection: self.$due)
                .datePickerStyle(.graphical)
            Spacer()
        }
        .padding(20)
        .navigationTitle("Task")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button ("Save") {
                if !title.isEmpty && category != nil {
                    if self.task == nil {
                        self.task = Task(context: self.moc)
                        self.task!.id = UUID()
                    }
                    saveTask()
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
    
    private func saveTask() {
        self.task!.title = self.title
        self.task!.toCategory = self.category!
        if self.note.isEmpty {
            self.task!.note = nil
        } else {
            self.task!.note = self.note
        }
        self.task!.isDone = false
        self.task!.due = self.due
        try? moc.save()
    }
}
