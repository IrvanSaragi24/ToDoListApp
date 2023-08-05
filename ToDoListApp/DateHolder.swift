//
//  DateHolder.swift
//  ToDoListApp
//
//  Created by Irvan P. Saragi on 05/08/23.
//

import Foundation
import CoreData

class DateHolder : ObservableObject{
    
    init (_ context : NSManagedObjectContext){
        
    }
    
    func saveContext(_ context : NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
