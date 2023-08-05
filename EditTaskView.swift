//
//  EditTaskView.swift
//  ToDoListApp
//
//  Created by Irvan P. Saragi on 05/08/23.
//

import SwiftUI

struct EditTaskView: View {
    @Environment(\.presentationMode) var presentationMode : Binding<PresentationMode>
    @EnvironmentObject var dateHolder : DateHolder
    @Environment(\.managedObjectContext) private var viewContext
    @State var selectedTaskItem : TaskItem?
    @State var name : String
    @State var desc : String
    @State var dueDate : Date
    @State var scheduleTime : Bool
    
    
    
    
    init(passedTaskItem: TaskItem?, initialDate: Date ) {
        if let taskItem = passedTaskItem{
            _selectedTaskItem = State(initialValue: taskItem)
            _name = State(initialValue: taskItem.name ?? "")
            _desc = State(initialValue: taskItem.desc ?? "")
            _dueDate = State(initialValue: taskItem.dueDate ?? initialDate)
            _scheduleTime = State(initialValue: taskItem.scheduleTime)
        }
        else{
            _name = State(initialValue: "")
            _desc = State(initialValue: "")
            _dueDate = State(initialValue: initialDate)
            _scheduleTime = State(initialValue: false)
           
        }
    }
    var body: some View {
        Form {
            Section(header : Text("Task")){
                TextField("Task", text: $name)
                TextField("Description", text: $desc)
            }
            Section(header : Text("Due Date")){
                Toggle("Schedule Time", isOn: $scheduleTime)
                DatePicker("Due Date", selection: $dueDate, displayedComponents: displayComp())
            }
            
            Section {
                Button("Save", action: ActionSave)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
    }
    
    func displayComp () -> DatePickerComponents {
        return scheduleTime ? [.hourAndMinute, .date] : [.date]
    }
    
    func ActionSave (){
        withAnimation {
            if selectedTaskItem == nil{
                selectedTaskItem = TaskItem(context: viewContext)
            }
            
            selectedTaskItem?.created = Date()
            selectedTaskItem?.name = name
            selectedTaskItem?.dueDate = dueDate
            selectedTaskItem?.scheduleTime = scheduleTime
            
            dateHolder.saveContext(viewContext)
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct EditTaskView_Previews: PreviewProvider {
    static var previews: some View {
        EditTaskView(passedTaskItem: nil, initialDate: Date())
    }
}
