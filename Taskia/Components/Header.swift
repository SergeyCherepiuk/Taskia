//
//  Header.swift
//  Taskia
//
//  Created by Serhii Cherepiuk on 10/06/2023.
//

import SwiftUI
import CoreData

struct Header: View {
    private let dateFormatter = DateFormatter()
    
    init() {
        dateFormatter.dateFormat = "EEEE, MMM dd"
    }
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                Text("List of tasks")
                    .font(.system(size: 22, weight: .bold))
                Text(dateFormatter.string(from: Date()))
                    .font(.system(size: 15, weight: .regular))
            }
            Spacer()
            NavigationLink(destination: TaskDetailsScreen()) {
                Text("Add taks")
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 16)
    }
}
