//
//  ToDoListAppApp.swift
//  ToDoListApp
//
//  Created by Irvan P. Saragi on 03/08/23.
//

import SwiftUI

@main
struct ToDoListAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
