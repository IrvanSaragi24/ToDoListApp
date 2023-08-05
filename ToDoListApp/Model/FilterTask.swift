//
//  FilterTask.swift
//  ToDoListApp
//
//  Created by Irvan P. Saragi on 05/08/23.
//

import Foundation

import SwiftUI

enum TaskFilter: String
{
    static var allFilters: [TaskFilter]
    {
        return [.NonCompleted,.Completed,.OverDue,.All]
    }
    
    case All = "All"
    case NonCompleted = "To Do"
    case Completed = "Completed"
    case OverDue = "Overdue"
}
