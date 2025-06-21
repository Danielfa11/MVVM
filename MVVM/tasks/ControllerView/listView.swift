//
//  listView.swift
//  MVVM
//
//  Created by Daniel Anderson on 6/19/25.
//

import SwiftUI

struct listView: View {
        
    @EnvironmentObject var taskListViewModel: CoreDataViewModel
    @State var showAddView = false
    
    var body: some View {
        VStack{
            HStack{
                EditButton().disabled(showAddView)
                Spacer()
                Text("Tasks").font(.title)
                Spacer()
                Button(action: {
                    showAddView.toggle()
                },label: {
                    Image(systemName: "plus.circle")
                        .font(.title2)
                })
            }.padding()
            Text("Number Completed Tasks \(taskListViewModel.numberCompletedTasks)")
            List{
                Section(header: Text("UnCompleted")){
                    ForEach(taskListViewModel.savedEntities,id: \.id){item in
                        
                        if !item.isComplete{
                            rowView(item:item)
                        }
                        
                        
                    }.onDelete(perform: taskListViewModel.deleteTask)
                        .onMove(perform: taskListViewModel.moveItem)
                }
                Section(header: Text("Completed")){
                    ForEach(taskListViewModel.savedEntities,id: \.id){item in
                        
                        if item.isComplete{
                            rowView(item:item)
                        }
                        
                        
                    }.onDelete(perform: taskListViewModel.deleteTask)
                        .onMove(perform: taskListViewModel.moveItem)
                }
                
                
            }.listStyle(.grouped).animation(.default, value: taskListViewModel.savedEntities)
        }.sheet(isPresented: $showAddView) {
            AddView(showAddView:$showAddView)
        }
            
    }
}

#Preview {
    NavigationView{
        listView()
    }
    .environmentObject(CoreDataViewModel())
    
}


