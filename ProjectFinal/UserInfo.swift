//
//  UserInfo.swift
//  ProjectFinal
//
//  Created by Ben Andrews on 4/24/17.
//  Copyright © 2017 John Young. All rights reserved.
//

import UIKit

protocol UserInfoDelegate: class {
    func taskListUpdated()
    func notesListChanged(_ notes: [Note])
}

class UserInfo {
    private var _currentNoteSearch: [Note] = []
    private var _notes: [Note] = [Note.init(text: "This note is a demo note for today! This is text to make it longer. Is this enough text hmmm maybe. We'll find out... Turns out it was but I want to make it even longer.", date: Date())]

    private var _taskList: [String: [Task]] = [:]
    private var _taskGroupList: [String] = []
    
    private var _selectedCategories: [Bool] = []
    
    weak var delegateDayComposite: UserInfoDelegate? = nil
    weak var delegateNotesSearch: UserInfoDelegate? = nil
    weak var delegateTasksSearch: UserInfoDelegate? = nil
    
    public static let Instance: UserInfo = UserInfo()
    
    private init() {
        let dayBeforeYesterday = Calendar.current.date(byAdding: .day, value: -2, to: Date())
        let yesterday = Calendar.current.date(byAdding: .day, value: 1, to: dayBeforeYesterday!)
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Date())
        let dayAfterTomorrow = Calendar.current.date(byAdding: .day, value: 1, to: tomorrow!)
        let dayAfterAfterTomorrow = Calendar.current.date(byAdding: .day, value: 2, to: tomorrow!)

        
        _notes.append(Note.init(text: "The day before yesterday's demo note!", date: dayBeforeYesterday!))
        _notes.append(Note.init(text: "Yesterdays demo note!", date: yesterday!))
        _notes.append(Note.init(text: "Tomorrows demo note!", date: tomorrow!))
        _notes.append(Note.init(text: "The day after tomorrow's note!", date: dayAfterTomorrow!))
        _notes.append(Note.init(text: "Testing", date: dayAfterAfterTomorrow!))
        
        
        for note in _notes {
            _currentNoteSearch.append(note)
        }
    }
    
    public func addTask(task: Task) {
        if var array = _taskList[task.group]{
            array.append(task)
            _taskList[task.group] = array
        }
        else if !task.group.isEmpty{
            _taskList[task.group] = [task]
            _selectedCategories.append(true)
        }
        delegateTasksSearch?.taskListUpdated()
        delegateDayComposite?.taskListUpdated()
    }
    
    public func removeTask(index: Int, group: String) {
        if var array = _taskList[group] {
            if index < array.count {
                array.remove(at: index)
                _taskList[group] = array
            }
        }
        delegateTasksSearch?.taskListUpdated()
        delegateDayComposite?.taskListUpdated()
    }
    
    public func removeTask(task: Task) {
        if var array = _taskList[task.group] {
            for (index, _)in array.enumerated() {
                if index < array.count {
                    if array[index].title == task.title && array[index].priority == task.priority {
                        array.remove(at: index)
                        _taskList[task.group] = array
                    }
                }
            }
        }
    }
    
    public func updateTask(at index: Int, task: Task){
        if var array = _taskList[task.group] {
            if index < array.count {
                array[index] = task
                _taskList[task.group] = array
            }
            
        }
        else {
            if !task.group.isEmpty {
                _taskList[task.group] = [task]
            }
        }
        delegateTasksSearch?.taskListUpdated()
        delegateDayComposite?.taskListUpdated()
    }
    
    public func getTask(at index: Int, group: String) -> Task {
        if var array = _taskList[group]{
            return array[index]
        }
        return Task()
    }
    
    public func addGroup(group: String) {
        _taskGroupList.append(group)
    }
    
    public func removeGroup(index: Int) {
        _taskGroupList.remove(at: index)
    }
    
    
    public func getDaysTasks(date: Date) -> [String: [Task]]{
        var dayTasks: [String: [Task]] = [:]
        var categories: [String] = getAllCategories()
        var areSelectedCategories: [Bool] = getSelectedCategories()
        
        var selectedCategories: [String] = []
        let calendar: Calendar = Calendar.current
        for i in 0..<categories.count {
            if areSelectedCategories[i] {
                selectedCategories.append(categories[i])
            }
        }
        for (group) in selectedCategories {
            if let array = _taskList[group] {
                for task in array {
                    if calendar.isDate(task.date, equalTo: date, toGranularity: .day) {
                        if var array = dayTasks[group]{
                            array.append(task)
                            dayTasks[group] = array
                        }
                        else {
                            dayTasks[group] = [task]
                        }
                    }
                }
            }
        }
        
        return dayTasks
    }
    
    public func taskExists(task: Task) -> Bool {
        for (group, taskArray) in _taskList {
            for task1 in taskArray {
                if task1.title == task.title && group == task.group{
                    return true
                }
            }
        }
        return false
    }
    
    
    // MARK - Public Accessible Variables
    public var TaskCollection: [String: [Task]] {
        return _taskList
    }
    
    public var TaskGroupList: [String] {
        return _taskGroupList
    }

    // MARK - Note Public Accessible Variables
    public var noteCount: Int {
        return _notes.count
    }
    
    public var notes: [Note] {
        return _notes
    }
    
    private func addNewNote(note: Note) {
        _notes.append(note)
    }
    
    public func addOrUpdateNote(_ note: Note) {
        let index: Int? = _notes.index(where: {searchNote in searchNote === note})
        if index != nil {
            _notes[index!] = note
        } else {
            addNewNote(note: note)
        }
        _currentNoteSearch = _notes
        delegateDayComposite?.notesListChanged(_notes)
        delegateNotesSearch?.notesListChanged(_currentNoteSearch)
    }
    
    public func getAllCategories() -> [String]{
        var categories: [String] = []
        for (group, _) in _taskList {
            if !categories.contains(group) {
                categories.append(group)
            }
        }
        return categories
    }
    
    public func getSelectedCategories() -> [Bool] {
        if _selectedCategories.isEmpty {
            for _ in 0...getAllCategories().count {
                _selectedCategories.append(true)
            }
            return _selectedCategories
        }
        else{
            return _selectedCategories
        }
        
    }
    
    public func selectCategory(index: Int) {
        if _selectedCategories[index] {
            _selectedCategories[index] = false
        }
        else {
            _selectedCategories[index] = true
        }
    }
    
    // MARK: - Tutorial Flags
    public var dayViewTutorial: Bool = true
    public var searchViewTutorial: Bool = true
    public var taskViewTutorial: Bool = true
    public var taskSearchViewTutorial: Bool = true
    public var categoryViewTutorial: Bool = true
}
