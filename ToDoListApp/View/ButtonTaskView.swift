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
        VStack{
            Spacer()
            HStack{
                NavigationLink(destination: EditTaskView(passedTaskItem: nil, initialDate: Date())
                    .environmentObject(dateHolder)) {
                        Image(systemName: "note.text.badge.plus")
                }
            }
        }
    }
}

struct ButtonTaskView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonTaskView()
    }
}
