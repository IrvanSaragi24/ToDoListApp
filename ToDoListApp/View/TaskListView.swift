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
    @State var selectedFilter = TaskFilter.NonCompleted
    
    var body: some View {
        NavigationView {
            VStack{
                Picker("", selection: $selectedFilter.animation())
                {
                    ForEach(TaskFilter.allFilters, id: \.self)
                    {
                        filter in
                        Text(filter.rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                ZStack{
                    List {
                        ForEach(filteredTaskItems()) { taskItem in
                            NavigationLink(destination: EditTaskView(passedTaskItem: taskItem, initialDate: Date()).environmentObject(dateHolder))
                            {
                        
                                CellTaskView(passedTaskItem: taskItem)
                            }
                        }
                        .onDelete(perform: deleteItems)
                        
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            ButtonTaskView()
                        }
                    }
                    DateScrollerView()
                        .padding()
                        .environmentObject(dateHolder)

                }
            }
            .navigationTitle("To Do List")
        }
    }
    
    private func filteredTaskItems() -> [TaskItem]
    {
        if selectedFilter == TaskFilter.Completed
        {
            return dateHolder.taskItems.filter{ $0.isCompleted()}
        }
        
        if selectedFilter == TaskFilter.NonCompleted
        {
            return dateHolder.taskItems.filter{ !$0.isCompleted()}
        }
        
        if selectedFilter == TaskFilter.OverDue
        {
            return dateHolder.taskItems.filter{ $0.isOverDue()}
        }
        
        return dateHolder.taskItems
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
