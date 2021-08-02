//
//  DatabaseManager.swift
//  ToDo_List_Test
//
//  Created by Rahul Bansal on 02/08/21.
//

import Foundation
import RealmSwift

typealias CompletionHandlerDelegate = (_ success : Bool) -> Void

class DatabaseManager : NSObject {
    
    static let sharedInstance = DatabaseManager()
    
    private let realmVersion: UInt64 = 15
    private var realmConfig: Realm.Configuration
    private let realmPath = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.ro.randusoft.RSToDoList")!.path + "/db.realm"
    
    override init() {
        print("realmPath --- \(realmPath)")
        self.realmConfig = Realm.Configuration(schemaVersion: self.realmVersion, migrationBlock: { migration, oldSchemaVersion in
            
        })
        
        if let originalDefaultRealmPath = self.realmConfig.fileURL {
            if FileManager.default.fileExists(atPath: originalDefaultRealmPath.absoluteString) {
                do {
                    try FileManager.default.moveItem(atPath: originalDefaultRealmPath.absoluteString, toPath: realmPath)
                } catch {
                    print("error at moving default realm")
                }
            }
        }
        
        if let realmPathURL = URL(string: realmPath) {
            self.realmConfig.fileURL = realmPathURL
        } else {
            fatalError("bad realm path?")
        }
        
        super.init()
        
    }
    
    private func getRealm() -> Realm {
        return try! Realm(configuration: self.realmConfig)
    }
    
    func getTasks() -> [Task] {
        return Array(self.getRealm().objects(Task.self))
    }
    
    func addTask(task: Task, completion : CompletionHandlerDelegate) {
        self.addObject(object: task, update: false, completion: completion)
    }
    
    func getTaskById(id: String) -> Task? {
        
        let results: Results<Task> = self.getRealm().objects(Task.self)
        return Array(results.filter("id == '\(id)'")).first
    }
    
    func deleteTask(task: Task, completion : CompletionHandlerDelegate) {
        self.deleteObject(object: task, completion: completion)
    }
    
    
    // generic private funcs
    
    private func addObject(object: Object, update: Bool, completion : CompletionHandlerDelegate) {
        let realm = self.getRealm()
        do {
            try realm.write {
                realm.add(object, update: update ? .all : .modified)
            }
            
            completion(true)
        }
        catch {
            print("Realm error: Cannot write: \(object)")
            completion(false)
        }
    }
    
    private func deleteObject(object: Object, completion : CompletionHandlerDelegate) {
        let realm = self.getRealm()
        do {
            try realm.write {
                realm.delete(object)
            }
            
            completion(true)
        }
        catch {
            print("Realm error: Cannot write: \(object)")
            completion(false)
        }
    }
}
