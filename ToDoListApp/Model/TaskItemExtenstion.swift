//
//  TaskItemExtenstion.swift
//  ToDoListApp
//
//  Created by Irvan P. Saragi on 05/08/23.
//

import SwiftUI

extension TaskItem{
    
    func isCompleted () -> Bool{
     return completedDate != nil
    }
    
    func isOverDue () -> Bool{
        if let due = dueDate{
            return !isCompleted() && scheduleTime && due < Date()
        }
        return false
    }
    
    func overDueColor () -> Color{
        return isOverDue() ? .black : .red
    }
    
    func dueDateTimeOnly() -> String{
        if let due = dueDate{
            let dateFormater = DateFormatter()
            dateFormater.dateFormat = "hh:mm a"
            return dateFormater.string(from: due)
        }
        
        return ""
    }
}
