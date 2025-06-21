//
//  TaskListViewModel.swift
//  MVVM
//
//  Created by Daniel Anderson on 6/19/25.
//

import Foundation

class TaskListViewModel: ObservableObject {
   @Published var items: [TaskModel] = []
     
    init(){
        let newItems = [
            TaskModel(title: "hello" ),
            TaskModel(title: "World" ),
            TaskModel(title: "World"),
        ]
        items.append(contentsOf:newItems)
    }
    
    func deleteItem(indexSet:IndexSet){
        items.remove(atOffsets: indexSet)
    }
    
    func moveItem(from:IndexSet,to:Int){
        print(items)
        items.move(fromOffsets: from, toOffset:to)
        print(items)
    }
    
    func addItem(title:String){
        items.append(TaskModel(title:title))
    }
    
    func completeTask(task:TaskModel){
        if let index = items.firstIndex(where: {$0.id == task.id}) {
            items[index] = items[index].updateCompletedAt()
        }
    }
}
