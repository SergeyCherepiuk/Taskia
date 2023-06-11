//
//  CategoryRow.swift
//  Taskia
//
//  Created by Serhii Cherepiuk on 11/06/2023.
//

import SwiftUI

struct CategoryRow: View {
    let categoryName: String
    let isSelected: Bool
    
    private let blue = Color(hex: 0x0A84FF, alpha: 1.0)
    
    var body: some View {
        HStack {
            Text(categoryName)
            Spacer()
            if isSelected {
                Image(systemName: "checkmark")
                    .foregroundColor(blue)
            }
        }
    }
}
