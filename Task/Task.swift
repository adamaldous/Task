//
//  Task.swift
//  Task
//
//  Created by Adam Aldous on 2/11/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

class Task: NSObject, NSCoding {
    
    private let kName = "name"
    private let kNotes = "notes"
    private let kDue = "due"
    private let kIsComplete = "isComplete"
    
    var name: String
    var notes: String?
    var due: NSDate?
    var isComplete: Bool
    
    init(name: String, notes: String? = nil, due: NSDate? = nil, isComplete: Bool = false) {
        self.name = name
        self.notes = notes
        self.due = due
        self.isComplete = isComplete
    }
    
    @objc required init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObjectForKey(kName) as? String else {
            self.name = ""
            self.notes = ""
            self.due = NSDate()
            self.isComplete = false
            super.init()
            return nil
        }
        self.name = name
        self.notes = aDecoder.decodeObjectForKey(kNotes) as? String
        self.due = aDecoder.decodeObjectForKey(kDue) as? NSDate
        self.isComplete = aDecoder.decodeObjectForKey(kIsComplete) as! Bool
        super.init()
    }
    
    @objc func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: kName)
        aCoder.encodeObject(notes, forKey: kNotes)
        aCoder.encodeObject(due, forKey: kDue)
        aCoder.encodeObject(isComplete, forKey: kIsComplete)
    }
}

func ==(lhs: Task, rhs: Task) -> Bool {
    return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
}