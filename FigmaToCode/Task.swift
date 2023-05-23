//
//  Task.swift
//  FigmaToCode
//
//  Created by Juan Sebastian Bueno on 23/05/23.
//

import Foundation

struct Task: Identifiable {
    var id = UUID()
    var title: String
    static func  getDummyTask() -> [Task] {
        var tasks = [Task]()
        tasks.append(Task(title: "Check emails"))
        tasks.append(Task(title: "Walk the dog 🦮"))
        tasks.append(Task(title: "Read the book"))
        tasks.append(Task(title: "Prepare dog food 🌭"))
        return tasks
    }
}
