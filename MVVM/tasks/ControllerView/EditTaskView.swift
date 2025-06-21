//
//  EditTaskView.swift
//  MVVM
//
//  Created by Daniel Anderson on 6/19/25.
//

import SwiftUI

struct EditTaskView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var taskListViewModel: CoreDataViewModel
    
    
    var task:TaskEntity
    @State var title:String
    @State var isComplete:Bool
    
    
    init(task:TaskEntity) {
        self.task = task
        _title = State(initialValue: task.title ?? "")
        _isComplete = State(initialValue: task.isComplete)
    }
    let columns = [
        GridItem(spacing: 20),
        GridItem(spacing:25)
    ]
    var body: some View {
            ScrollView{
                HStack{
                    Text("created:")
                    Text("\(task.createdAt?.formatted(date:Date.FormatStyle.DateStyle.abbreviated,  time: Date.FormatStyle.TimeStyle.omitted) ?? "")")
                }
                
                    LazyVGrid(columns:columns){
                        TextField("New Title",text: $title)
                            .padding(.horizontal)
                            .frame(height: 55)
                            .background(Color(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186))
                            .cornerRadius(10)
                        
                        Toggle("Complete\(isComplete ? "!":"?")",isOn: $isComplete).toggleStyle(.automatic)
                            .padding(.horizontal)
                            .frame(height: 55)
                            .foregroundStyle(isComplete ? Color.green : Color.red)
                            .background(Color(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186))
                            .cornerRadius(10)
                    }
                    Button("Save",action:saveEdits)
                        .foregroundStyle(Color.white)
                        .frame(height:55)
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                    .cornerRadius(15)
                
            }.padding(15)
            .navigationTitle("Edit - \(task.title ?? "Bugged")")
            .onAppear {
                title = task.title ?? ""
                isComplete = task.isComplete
            }
        }
        
    
    
    func saveEdits(){
        if title.count > 3 {
            taskListViewModel.updateTask(task: task,newtitle: title,newIsComplete: isComplete)
//            task.isComplete = isComplete
//            task.title = title
//            taskListViewModel.saveTask()
            taskListViewModel.fetchTasks()
            dismiss()
        }
    }
}

//#Preview {
//    NavigationView{
//        EditTaskView( task: TaskModel(title:"title111"))
//    }
//    .environmentObject(CoreDataViewModel(),)
//
//}
