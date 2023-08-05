//
//  DateScroller.swift
//  ToDoListApp
//
//  Created by Irvan P. Saragi on 05/08/23.
//

import SwiftUI

struct DateScrollerView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var dateHolder : DateHolder
    var body: some View {
        VStack{
            Spacer()  
            HStack{
                Button(action : moveBack){
                    Image(systemName: "chevron.backward")
                        .imageScale(.medium)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                }
                Text(dateFormart())
                    .font(.title3)
                
                Button(action : moveForward){
                    Image(systemName: "chevron.forward")
                        .imageScale(.medium)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                }
            }
        }
    }
    
    func dateFormart () -> String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd LLL yy"
        return dateFormater.string(from: dateHolder.date)
    }
    func moveBack (){
        withAnimation {
            dateHolder.moveDate(-1, viewContext)
        }
    }
    
    func moveForward (){
        withAnimation {
            dateHolder.moveDate(1, viewContext)
        }
    }
}

struct DateScrollerView_Previews: PreviewProvider {
    static var previews: some View {
        DateScrollerView()
    }
}
