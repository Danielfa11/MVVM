//
//  AddView.swift
//  MVVM
//
//  Created by Daniel Anderson on 6/19/25.
//

import SwiftUI

struct AddView: View {
    @EnvironmentObject var taskListViewModel: CoreDataViewModel
    
    @State var title:String = ""
    @State var alertTile: String = ""
    @State var showAlert: Bool = false
    
    @Binding var showAddView:Bool
    var body: some View {
        VStack{
            Text("Edit Task").font(.title).underline().frame(height: 55)
            VStack {
                TextField("Tasks Tilte", text: $title)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186))
                    .cornerRadius(10)
                
                Button(action: save, label:{
                    Text("Save")
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .cornerRadius(15)
                })
            }.padding(15)
        Spacer()
        }.padding()
            .alert("Task Title must be longer than 3 characters", isPresented: $showAlert, actions: {
                Button("Dismiss"){
                    showAlert.toggle()
                }
                
            })
    }
    
    func save(){
        if title.count > 3{
            taskListViewModel.addTask(task: TaskModel(title:title))
            showAddView.toggle()
            return
        }
        showAlert.toggle()
    }
    
   
}

//#Preview {
//    NavigationView{
//        AddView()
//    }
//}
