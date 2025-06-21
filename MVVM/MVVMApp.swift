//
//  MVVMApp.swift
//  MVVM
//
//  Created by Daniel Anderson on 6/19/25.
//

import SwiftUI

@main
struct MVVMApp: App {
    
    @StateObject var taskListViewModel:CoreDataViewModel = CoreDataViewModel()
    
    var body: some Scene {
        WindowGroup {
            TabView{
                Tab("Tasks Tab", systemImage:"list.bullet.clipboard",content: {
                    listView()
                })
                
                Tab("Test Tab",systemImage: "circle",content: {
                    Text("Test")
                })
            }
            .environmentObject(taskListViewModel)
            
        }
    }
}
