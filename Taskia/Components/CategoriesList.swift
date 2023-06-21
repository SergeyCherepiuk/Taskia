//
//  CategoriesList.swift
//  Taskia
//
//  Created by Serhii Cherepiuk on 11/06/2023.
//

import SwiftUI
import CoreData

struct CategoriesList: View {
    @Environment(\.managedObjectContext) private var moc: NSManagedObjectContext
    @FetchRequest(sortDescriptors: []) private var categories: FetchedResults<Category>
    
    @Binding var selectedCategory: Category?
    @State private var isActive = false
    @State private var isDialogVisible = false
    
    var body: some View {
        List {
            ForEach(categories) { category in
                let categoryName = category.name ?? "Unnamed category"
                let selectedCategoryName = self.selectedCategory?.name ?? "No category"
                ZStack {
                    CategoryRow(
                        categoryName: categoryName,
                        isSelected: selectedCategoryName == categoryName
                    )
                    
                    NavigationLink(
                        destination: CategoryDetailsScreen(category: category),
                        isActive: self.$isActive
                    ) {
                        EmptyView()
                    }
                    .opacity(0)
                }
                .contentShape(Rectangle())
                .simultaneousGesture(
                    TapGesture(count: 2).onEnded { _ in
                        askToRemoveIfNeeded(id: category.id!)
                    }
                )
                .simultaneousGesture(
                    TapGesture().onEnded { _ in
                        self.selectedCategory = category
                        self.isActive = false
                    }
                )
                .simultaneousGesture(
                    LongPressGesture().onEnded { _ in
                        self.isActive = true
                    }
                )
                .confirmationDialog("All task will be deleted!", isPresented: $isDialogVisible) {
                    Button("Delete anyway", role: .destructive) {
                        removeCategory(id: category.id!)
                        isDialogVisible = false
                    }
                } message: {
                    Text("All task will be deleted!")
                }
            }
        }
        .toolbar {
            NavigationLink(destination: { CategoryDetailsScreen() }) {
                Text("Add")
            }
        }
    }
    
    private func askToRemoveIfNeeded(id: UUID) {
        for category in categories {
            if category.id == id && category.toTaskArray.count > 0 {
                isDialogVisible = true
            } else if category.id == id {
                removeCategory(id: id)
            }
        }
    }
    
    private func removeCategory(id: UUID) {
        let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        if let result = try? self.moc.fetch(fetchRequest) {
            for object in result {
                if object.id == id {
                    self.moc.delete(object)
                }
                if self.selectedCategory != nil && self.selectedCategory!.id == id {
                    self.selectedCategory = nil
                }
            }
        }
        try? self.moc.save()
    }
}
