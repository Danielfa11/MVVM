//
//  CoreDataViewModel.swift
//  MVVM
//
//  Created by Daniel Anderson on 6/19/25.
//

import SwiftUI
import CoreData

class CoreDataViewModel: ObservableObject {
    let contanier: NSPersistentContainer
    @Published var savedEntities: [TaskEntity] = []
    
    var numberCompletedTasks: Int8 = 0
    init() {
        contanier = NSPersistentContainer(name: "TasksContainer")
        contanier.loadPersistentStores { (description,error)in
            if let error = error {
                print("error loading core data",error.localizedDescription)
            } else {
                print("success load core data")
            }
        }
         fetchTasks()
    }
    
    func fetchTasks() {
        numberCompletedTasks = 0
        let request = NSFetchRequest<TaskEntity>(entityName: "TaskEntity")
        do {
          let entities = try contanier.viewContext.fetch(request)
            DispatchQueue.main.async {
                self.savedEntities = entities
                    }
            
            for entity in entities {
                if entity.isComplete{
                    numberCompletedTasks+=1
                }
            }
        }catch let error{
            print("couldn't fetch",error)
        }
    }
    
    
    func addTask(task:TaskModel){
        let newTask = TaskEntity(context: contanier.viewContext)
        newTask.id = task.id
        newTask.title = task.title
        newTask.isComplete = task.isComplete
        newTask.createdAt = task.createdAt
        saveTask()
        
    }
    
    func deleteTask(indexSet:IndexSet) {
        guard let index = indexSet.first else { return }
        let entitiy = savedEntities[index]
        
        contanier.viewContext.delete(entitiy)
        saveTask()
    }
    
    func moveItem(from:IndexSet,to:Int){
        savedEntities.move(fromOffsets: from, toOffset:to)

    }

    func completeTask(task:TaskEntity){
        task.isComplete = !task.isComplete
        saveTask()
    }
    
    func updateTask(task:TaskEntity,newtitle:String,newIsComplete:Bool){
//        contanier.
        task.title = newtitle
        task.isComplete = newIsComplete
        saveTask()
//        contanier.viewContext.refresh(task, mergeChanges: true)

        
    }
        
    func saveTask() {
        if !contanier.viewContext.hasChanges {
            print("No Changes")
            return
        }
        do {
            try contanier.viewContext.save()
            fetchTasks()
        } catch let error {
            print("\(error)")
        }
    }
}
