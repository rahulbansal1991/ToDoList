//
//  Constants.swift
//  ToDo_List_Test
//
//  Created by Rahul Bansal on 02/08/21.
//

import Foundation

class Constants {
    
    // cell reuse id (cells that scroll out of view can be reused)
    static let CellReuseIdentifierTaskList = "CellReuseIdentifierTaskList"
    
}

enum AlertMessage {

    enum Title: String {
        case success = "Success"
        case fail = "Error"
        case alert = "Alert"
    }
    
    enum Message: String {
        case taskSaved = "Task saved successfully!"
        case taskUpdated = "Task updated successfully!"
        case taskDelete = "Task deleted successfully!"
        case error = "Error occurred. Please try again"
        case confirmation = "Are you sure, you want to delete this task?"        
    }
}
