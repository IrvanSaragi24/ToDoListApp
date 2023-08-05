//
//  DateHolder.swift
//  ToDoListApp
//
//  Created by Irvan P. Saragi on 05/08/23.
//

import Foundation
import CoreData

class DateHolder : ObservableObject{
    
    @Published var date = Date()
    @Published var taskItems: [TaskItem] = []
    
    let calendar : Calendar = Calendar.current
    
    func moveDate (_ days : Int , _ context : NSManagedObjectContext){
        
        date = calendar.date(byAdding: .day, value: days, to: date)!
        refreshTaskItem(context)
    }
    
    
    
    init (_ context : NSManagedObjectContext){
        refreshTaskItem(context)
    }
    func refreshTaskItem(_ context: NSManagedObjectContext) {
        taskItems = fetchTaskItems(context)
    }
    
    func fetchTaskItems(_ context : NSManagedObjectContext) -> [TaskItem]{
        do{
            return try context.fetch(dailyTasksFetch()) as [TaskItem]
        }
        catch let error{
            fatalError("unresolved error \(error)")
        }
    }
    
    func dailyTasksFetch() -> NSFetchRequest<TaskItem>
    {
        let request = TaskItem.fetchRequest()
        
        request.sortDescriptors = sortOrder()
        request.predicate = predicate()
        return request
    }
    private func sortOrder() -> [NSSortDescriptor]
    {
        let completedDateSort = NSSortDescriptor(keyPath: \TaskItem.completedDate, ascending: true)
        let timeSort = NSSortDescriptor(keyPath: \TaskItem.scheduleTime, ascending: true)
        let dueDateSort = NSSortDescriptor(keyPath: \TaskItem.dueDate, ascending: true)
        
        return [completedDateSort, timeSort, dueDateSort]
    }
    
    private func predicate() -> NSPredicate
    {
        let start = calendar.startOfDay(for: date)
        let end = calendar.date(byAdding: .day, value: 1, to: start)
        return NSPredicate(format: "dueDate >= %@ AND dueDate < %@", start as NSDate, end! as NSDate)
    }
    
    func saveContext(_ context : NSManagedObjectContext) {
        do {
            try context.save()
            refreshTaskItem(context)
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
