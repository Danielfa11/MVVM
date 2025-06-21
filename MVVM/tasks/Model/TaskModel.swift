//
//  TaskModel.swift
//  MVVM
//
//  Created by Daniel Anderson on 6/19/25.
//

import Foundation

struct TaskModel: Identifiable {
    let id: String
    let title: String
    let isComplete:Bool
    let createdAt:Date
   
    init(id:String = UUID().uuidString,title: String,isCompleted:Bool = false ,createdAt:Date = Date()) {
        self.id = id
        self.title = title
        self.isComplete = isCompleted
        self.createdAt = createdAt
    }
    
    init(taskEntity: TaskEntity) {
        self.id = taskEntity.id!
        self.title = taskEntity.title!
        self.isComplete = taskEntity.isComplete
        self.createdAt = taskEntity.createdAt!
    }
    
    
    func updateCompletedAt()->TaskModel {
        return TaskModel(id:id, title:title, isCompleted: !isComplete, createdAt: createdAt,)
    }
    
    func toTaskEntity(){
        
    }
    
    
   
}
