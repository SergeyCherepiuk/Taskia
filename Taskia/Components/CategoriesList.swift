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
                        removeCategory(id: category.id!)
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
            }
        }
        .toolbar {
            NavigationLink(destination: { CategoryDetailsScreen() }) {
                Text("Add")
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
            }
        }
        try? self.moc.save()
    }
}
