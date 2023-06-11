//
//  CategoryDetailsScreen.swift
//  Taskia
//
//  Created by Serhii Cherepiuk on 11/06/2023.
//

import SwiftUI
import CoreData

struct CategoryDetailsScreen: View {
    @Environment(\.managedObjectContext) private var moc: NSManagedObjectContext
    @Environment(\.presentationMode) private var presentationMode
    
    @State private var category: Category?
    @State private var name: String
    
    init(category: Category? = nil) {
        self._category = State(initialValue: category)
        self._name = State(initialValue: category?.name ?? "")
    }
    
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
                    if !name.isEmpty {
                        if self.category == nil {
                            self.category = Category(context: self.moc)
                            self.category!.id = UUID()
                        }
                        saveCategory()
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            Spacer()
        }
    }
    
    private func saveCategory() {
        self.category!.name = self.name
        try? moc.save()
    }
}
