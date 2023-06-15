//
//  TaskRow.swift
//  Taskia
//
//  Created by Serhii Cherepiuk on 10/06/2023.
//

import SwiftUI
import CoreData

struct TaskRow: View {
    @Environment(\.managedObjectContext) private var moc: NSManagedObjectContext
    
    @State private var task: Task
    private let gray = Color(hex: 0x888888, alpha: 1.0)
    private let dateFormatter = DateFormatter()
    
    init(task: Task) {
        self.task = task
        self.dateFormatter.dateFormat = "MMM d, h:mm a"
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 5) {
                    Text(self.task.title ?? "No title")
                        .font(.system(size: 17, weight: .regular))
                        .strikethrough(self.task.isDone, color: .black)
                    Text(self.task.toCategory?.name ?? "No category")
                        .font(.system(size: 13, weight: .regular))
                        .foregroundColor(self.gray)
                }
                Spacer()
                Checkbox(isChecked: self.$task.isDone)
                    .padding(EdgeInsets(
                        top: 0,
                        leading: 0,
                        bottom: 0,
                        trailing: 12
                    ))
                    .onTapGesture {
                        self.task.isDone = !self.task.isDone
                        try? moc.save()
                    }
            }
            if self.task.note != nil {
                Text(self.task.note!)
                    .font(.system(size: 12, weight: .regular))
            }
            Divider()
            HStack {
                Text(dateFormatter.string(from: self.task.due ?? Date()))
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(gray)
            }
        }
        .padding(.vertical, 10)
        .padding(.leading, 10)
    }
}
