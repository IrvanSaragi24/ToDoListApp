//
//  ButtonTaskView.swift
//  ToDoListApp
//
//  Created by Irvan P. Saragi on 05/08/23.
//

import SwiftUI

struct ButtonTaskView: View {
    @EnvironmentObject var dateHolder : DateHolder
    var body: some View {
        HStack{
            NavigationLink(destination: EditTaskView(passedTaskItem: nil, initialDate: Date())
                .environmentObject(dateHolder)) {
                Text("Add Task")
                    .font(.headline)
            }
            .padding(15)
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(30)
            .padding(30)
            .shadow(color: .black, radius: 5)
        }
    }
}

struct ButtonTaskView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonTaskView()
    }
}
