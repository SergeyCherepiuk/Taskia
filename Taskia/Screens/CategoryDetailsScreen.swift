//
//  CategoryDetailsScreen.swift
//  Taskia
//
//  Created by Serhii Cherepiuk on 11/06/2023.
//

import SwiftUI

struct CategoryDetailsScreen: View {
    @State private var category: Category?
    @State private var name: String
    
    init(category: Category? = nil) {
        self._category = State(initialValue: category)
        self._name = State(initialValue: category?.name ?? "")
    }
    
    var body: some View {
        CategoryDetails(category: self.$category, name: self.$name)
    }
}
