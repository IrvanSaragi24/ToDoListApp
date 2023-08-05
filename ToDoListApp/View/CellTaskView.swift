//
//  CellTaskView.swift
//  ToDoListApp
//
//  Created by Irvan P. Saragi on 05/08/23.
//

import SwiftUI

struct CellTaskView: View {
    @EnvironmentObject var dateHolder : DateHolder
    @ObservedObject var passedTaskItem : TaskItem
    var body: some View {
        
        CheckBoxView(passedTaskItem: passedTaskItem)
            .environmentObject(dateHolder)
        Text(passedTaskItem.name ?? "")
            .padding(.horizontal)
    }
}

struct CellTaskView_Previews: PreviewProvider {
    static var previews: some View {
        CellTaskView(passedTaskItem: TaskItem())
    }
}
