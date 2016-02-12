//
//  TaskController.swift
//  Task
//
//  Created by Adam Aldous on 2/11/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

class TaskController {
    
    static let sharedInstance = TaskController()
    
    let taskKey = "Task Key"
    
    var tasks: [Task]
    var completedTasks: [Task] {
        return tasks.filter({$0.isComplete.boolValue})
    }
    var incompleteTasks: [Task] {
        return tasks.filter({!$0.isComplete.boolValue})
    }
    
    init() {
        self.tasks = []
        loadFromPersistentStoreage()
    }
    
    var mockTasks: [Task] {
        var task1 = Task(name: "make an app", notes: nil, due: nil, isComplete: false)
        var task2 = Task(name: "make anothe app", notes: nil, due: nil, isComplete: true)
        var task3 = Task(name: "make a third app", notes: nil, due: NSDate(timeIntervalSinceNow: NSTimeInterval(300)), isComplete: false)
        return [task1, task2, task3]
    }
    
    func addTask(task: Task) {
        self.tasks.append(task)
        saveToPersistentStorage()
    }
    
    func removeTask(task: Task) {
        if let index = tasks.indexOf(task) {
            tasks.removeAtIndex(index)
            saveToPersistentStorage()
        }
    }
    
    func saveToPersistentStorage() {
        
        NSKeyedArchiver.archiveRootObject(self.tasks, toFile: self.filePath(taskKey))
    }
    
    func loadFromPersistentStoreage() {
        
        let unarchivedTasks = NSKeyedUnarchiver.unarchiveObjectWithFile(self.filePath(taskKey))
        if let tasksTest = unarchivedTasks as? [Task] {
            self.tasks = tasksTest
        }
    }
    
    func filePath(key : String) -> String {
        let directorySearchResults = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true)
        let documentPath: AnyObject = directorySearchResults[0]
        let tasksPath = documentPath.stringByAppendingString("/\(key).plist")
        return tasksPath
    }
}