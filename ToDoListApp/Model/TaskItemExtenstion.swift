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
}
