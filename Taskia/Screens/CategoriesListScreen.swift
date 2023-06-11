//
//  CategoriesListScreen.swift
//  Taskia
//
//  Created by Serhii Cherepiuk on 11/06/2023.
//

import SwiftUI

struct CategoriesListScreen: View {
    @Binding var selectedCategory: Category?
    
    var body: some View {
        CategoriesList(selectedCategory: self.$selectedCategory)
            .navigationTitle("Categories")
            .navigationBarTitleDisplayMode(.inline)
    }
}
