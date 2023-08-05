//
//  ContentView.swift
//  ToDoListApp
//
//  Created by Irvan P. Saragi on 03/08/23.
//

import SwiftUI
import CoreData

struct TaskListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var dateHolder : DateHolder
    
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \TaskItem.dueDate, ascending: true)],
//        animation: .default)
//    private var items: FetchedResults<TaskItem>
    
    var body: some View {
        NavigationView {
            VStack{
                ZStack{
                    
                    
                    List {
                        ForEach(dateHolder.taskItems) { taskItem in
                            NavigationLink(destination: EditTaskView(passedTaskItem: taskItem, initialDate: Date()).environmentObject(dateHolder))
                            {
                                //                                Text(taskItem.dueDate!, formatter: itemFormatter)
                                CellTaskView(passedTaskItem: taskItem)
                            }
                        }
                        .onDelete(perform: deleteItems)
                        
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            EditButton()
                        }
                    }
                    DateScrollerView()
                        .padding()
                        .environmentObject(dateHolder)
                        .padding(.bottom, 100)
                    ButtonTaskView()
                        .environmentObject(dateHolder)
                }
            }
            .navigationTitle("To Do List")
        }
    }
    
    
    
    
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { dateHolder.taskItems[$0] }.forEach(viewContext.delete)
            
            dateHolder.saveContext(viewContext)
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
