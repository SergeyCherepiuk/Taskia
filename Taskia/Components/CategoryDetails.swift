//
//  CategoryDetails.swift
//  Taskia
//
//  Created by Serhii Cherepiuk on 12/06/2023.
//

import SwiftUI
import CoreData

struct CategoryDetails: View {
    @Environment(\.managedObjectContext) private var moc: NSManagedObjectContext
    @Environment(\.presentationMode) private var presentationMode
    
    @Binding var category: Category?
    @Binding var name: String
    
    @State private var isAlertVisible = false
    @State private var errorMessage = ""
    
    var body: some View {
        VStack {
            TextField(text: self.$name) {
                Text("Name")
            }
            .lineLimit(1)
            .padding(20)
            .navigationTitle("Category")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button ("Save") {
                    onSaveClick()
                }
                .alert(self.errorMessage, isPresented: self.$isAlertVisible) {
                    Button("Ok", role: .cancel) {
                        self.isAlertVisible = false
                        self.errorMessage = ""
                    }
                }
            }
            Spacer()
        }
    }
    
    private func onSaveClick() {
        let isNameValid = validateName()
        
        if isNameValid {
            if self.category == nil {
                self.category = Category(context: self.moc)
                self.category!.id = UUID()
            }
            saveCategory()
            presentationMode.wrappedValue.dismiss()
        } else {
            self.errorMessage = "Name is required!"
            self.isAlertVisible = true
        }
    }
    
    private func saveCategory() {
        self.category!.name = self.name
        try? moc.save()
    }
    
    private func validateName() -> Bool {
        return !self.name.isEmpty
    }
}
