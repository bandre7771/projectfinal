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
    private var _status: String
    private var _priority: String
    private var _date: Date
    private var _group: Group
    private var _notes: Note
    
    init(title: String, status: String, priority: String, date: Date, group: Group, notes: Note) {
        _title = title
        _status = status
        _priority = priority
        _date = date
        _group = group
        _notes = notes
    }
    
    init() {
        _title = ""
        _status = ""
        _priority = ""
        _date = Date()
        _group = Group()
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
    
    public var status: String {
        get{
            return _status
        }
        set{
            _status = newValue
        }
    }
    
    public var priority: String {
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
    
    public var group: Group {
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
