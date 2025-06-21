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
                EditButton()
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
            List{
                Text("Number Completed Tasks \(taskListViewModel.numberCompletedTasks)")
                
                ForEach(taskListViewModel.savedEntities,id: \.id){item in
                    rowView(item:item)
                }
                .onDelete(perform: taskListViewModel.deleteTask)
                .onMove(perform: taskListViewModel.moveItem)
                
            }.listStyle(.grouped)
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


