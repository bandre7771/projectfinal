//
//  Task.swift
//  ProjectFinal
//
//  Created by Ben Andrews on 4/19/17.
//  Copyright © 2017 John Young. All rights reserved.
//

import UIKit

class Task {
    private var _title: String
    private var _status: Bool
    private var _priority: Int
    private var _date: Date
    private var _group: String
    private var _notes: Note
    
    init(title: String, status: Bool, priority: Int, date: Date, group: String, notes: Note) {
        _title = title
        _status = status
        _priority = priority
        _date = date
        _group = group
        _notes = notes
    }
    
    init() {
        _title = ""
        _status = false
        _priority = 0
        _date = Date()
        _group = ""
        _notes = Note()
    }
    
    
    // MARK: Public Accessible Variables
    public var title: String {
        get{
            return _title
        }
        set{
            _title = newValue
        }
    }
    
    public var status: Bool {
        get{
            return _status
        }
        set{
            _status = newValue
        }
    }
    
    public var priority: Int {
        get{
            return _priority
        }
        set{
            _priority = newValue
        }
    }
    
    public var date: Date {
        get{
            return _date
        }
        set{
            _date = newValue
        }
    }
    
    public var group: String {
        get{
            return _group
        }
        set{
            _group = newValue
        }
    }
    
    public var notes: Note {
        get{
            return _notes
        }
        set{
            _notes = newValue
        }
    }
}

extension Task: Comparable {
    
    static func == (lhs: Task, rhs: Task) -> Bool {
        return lhs.title == rhs.title &&
            lhs.status == rhs.status &&
            lhs.priority == rhs.priority &&
            lhs.date == rhs.date &&
            lhs.group == rhs.group &&
            lhs.notes == rhs.notes
        
    }
    
    static func < (lhs: Task, rhs: Task) -> Bool {
        return lhs.date < rhs.date ||
            (lhs.date == rhs.date && lhs.priority < rhs.priority) ||
            (lhs.priority == rhs.priority && lhs.title < rhs.title)
    }
    
    static func >(lhs: Task, rhs: Task) -> Bool {
        return lhs.date > rhs.date ||
            (lhs.date == rhs.date && lhs.priority > rhs.priority) ||
            (lhs.priority == rhs.priority && lhs.title > rhs.title)
    }
    
}
