//
//  TaskListViewModel.swift
//  ToDo_List_Test
//
//  Created by Rahul Bansal on 02/08/21.
//

import Foundation

class TaskListViewModel {
    
    var taskList = [Task]()
    
    func fetchTasks() {
        
        taskList = DatabaseManager.sharedInstance.getTasks()
    }
     
    func deleteTask(task : Task, completion : CompletionHandlerDelegate) {
        
        DatabaseManager.sharedInstance.deleteTask(task: task, completion: completion)
    }
}
