//
//  ContentView.swift
//  Taskia
//
//  Created by Serhii Cherepiuk on 10/06/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        NavigationView {
            TasksListScreen()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
