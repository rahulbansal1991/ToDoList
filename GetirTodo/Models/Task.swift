//
//  Task.swift
//  ToDo_List_Test
//
//  Created by Rahul Bansal on 01/08/21.
//

import Foundation
import RealmSwift

class Task : Object {
    
    @objc dynamic var id = NSUUID().uuidString
    @objc dynamic var title = ""
    @objc dynamic var detail = ""
    @objc dynamic var date: Date?
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(title: String, detail: String) {
        
        self.init()
        
        self.title = title
        self.detail = detail
        self.date = Date()
    }
}
