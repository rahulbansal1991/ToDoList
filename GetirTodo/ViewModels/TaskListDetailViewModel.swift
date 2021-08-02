//
//  TaskListDetailViewModel.swift
//  ToDo_List_Test
//
//  Created by Rahul Bansal on 02/08/21.
//

import Foundation

class TaskListDetailViewModel {
    
    func saveTask(title : String, detail : String, completion : CompletionHandlerDelegate) {
        
        let task = Task(title: title, detail: detail)
        
        DatabaseManager.sharedInstance.addTask(task: task, completion: completion)
    }
    
    func updateTask(task : Task, title : String, detail : String, completion : CompletionHandlerDelegate) {
        
        DatabaseManager.sharedInstance.updateTask(task: task, title: title, detail: detail, completion: completion)
    }
    
    func deleteTask(task : Task, completion : CompletionHandlerDelegate) {
        
        DatabaseManager.sharedInstance.deleteTask(task: task, completion: completion)
    }

}
