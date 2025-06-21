//
//  rowView.swift
//  MVVM
//
//  Created by Daniel Anderson on 6/19/25.
//

import SwiftUI

struct rowView: View {
    @EnvironmentObject var taskListViewModel: CoreDataViewModel
    
    let item: TaskEntity
    @State var isEdit:Bool
    @State var isEditSave:Bool = false
    @State var newTitle: String
    @State var newisComplete:Bool
    
    init(item:TaskEntity){
        self.item = item
        self.isEdit = true
        _newTitle = State(initialValue: item.title ?? "")
        _newisComplete = State(initialValue: item.isComplete)
    }
    var body: some View {
        Group{
            HStack{
            if (isEdit){
                Image(systemName: item.isComplete ? "checkmark.circle" : "circle")
                    .foregroundColor(item.isComplete ? .green : .red)
                Text(item.title ?? "").onTapGesture {
                    print("tapped")
                    isEdit.toggle()
                }
                
            } else {
                HStack{
                    TextField("New Title", text:$newTitle)
                        .frame(height: 35)
                        .frame(maxWidth: .infinity)
                        .background(Color(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186))
                        .cornerRadius(15)
                        .multilineTextAlignment(.center)
                    Spacer()
                    Text("Complete Task")
                    Toggle(isOn: $newisComplete, label: {
                        Text("task complete")
                    }).labelsHidden()
                }.onTapGesture {
                    print("tapped")
                    isEditSave.toggle()
                    
                }
                }
                
            }.animation(.default, value: isEdit)
        }.alert("Save Changes to Task: \(item.title ?? "")",isPresented: $isEditSave, actions: {
            Button("Discard"){
                isEditSave.toggle()
            }.foregroundStyle(.red)
            Button("save"){
                taskListViewModel.updateTask(task: item, newtitle: newTitle, newIsComplete: newisComplete)
                isEditSave.toggle()
                isEdit.toggle()
            }
        })

    }
}
