//
//  Checkbox.swift
//  Taskia
//
//  Created by Serhii Cherepiuk on 10/06/2023.
//

import SwiftUI

struct Checkbox: View {
    @Binding var isChecked: Bool
    
    private let blue = Color(hex: 0x0A84FF, alpha: 1.0)
    
    var body: some View {
        if isChecked {
            ZStack {
                Circle()
                    .foregroundColor(blue)
                    .frame(width: 22, height: 22)
                Image(systemName: "checkmark")
                    .font(.system(size: 10))
                    .foregroundColor(.white)
            }
        } else {
            ZStack {
                Circle()
                    .strokeBorder(.gray, lineWidth: 1.5)
                    .foregroundColor(.white)
                    .frame(width: 22, height: 22)
            }
        }
    }
}
