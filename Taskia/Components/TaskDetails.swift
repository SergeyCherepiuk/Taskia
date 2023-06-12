//
//  TaskDetails.swift
//  Taskia
//
//  Created by Serhii Cherepiuk on 12/06/2023.
//

import SwiftUI
import CoreData

struct TaskDetails: View {
    @Environment(\.managedObjectContext) private var moc: NSManagedObjectContext
    @Environment(\.presentationMode) private var presentationMode
    
    @Binding var task: Task?
    @Binding var title: String
    @Binding var note: String
    @Binding var category: Category?
    @Binding var due: Date
    
    @State var isAlertVisible = false
    @State var errorMessage = ""
    
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
            Button("Save") {
                onSaveClick()
            }
            .alert(self.errorMessage, isPresented: self.$isAlertVisible) {
                Button("Ok", role: .cancel) {
                    self.isAlertVisible = false
                    self.errorMessage = ""
                }
            }
        }
    }
    
    private func onSaveClick() {
        let isTitleValid = validateTitle()
        let isCategoryValid = validateCategory()
        
        if isTitleValid && isCategoryValid {
            if self.task == nil {
                self.task = Task(context: self.moc)
                self.task!.id = UUID()
            }
            saveTask()
            presentationMode.wrappedValue.dismiss()
        } else {
            if !isTitleValid {
                self.errorMessage.append(contentsOf: "Title is required!\n")
            }
            if !isCategoryValid {
                self.errorMessage.append(contentsOf: "Category must be selected!\n")
            }
            self.errorMessage = self.errorMessage.trimmingCharacters(in: [" ", "\n"])
            self.isAlertVisible = true
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
    
    private func validateTitle() -> Bool {
        return !self.title.isEmpty
    }
    
    private func validateCategory() -> Bool {
        return self.category != nil
    }
}
