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
    
    private var _notes: [Note] = [Note.init(text: "This note is a demo note for today! This is text to make it longer. Is this enough text hmmm maybe. We'll find out... Turns out it was but I want to make it even longer. Not stopping now lol lol.", date: Date())]

    private var _dailyDictionary: [Date : [Task]] = [Calendar.current.startOfDay(for: Date()): [/*Event(title: "Demo Event", startHour: 4, startMinute: 0, endHour: 8, endMinute: 0, date: Date()),
         Event(title: "Demo Event", startHour: 12, startMinute: 0, endHour: 14, endMinute: 0, date: Date()),
         Event(title: "Demo Event", startHour: 16, startMinute: 0, endHour: 17, endMinute: 0, date: Date()),
         Event(title: "Demo Event", startHour: 16, startMinute: 50, endHour: 19, endMinute: 0, date: Date())*/]]
    private var _taskList: [String: [Task]] = [:]
    private var _taskGroupList: [String] = []
    
    weak var delegateDayComposite: UserInfoDelegate? = nil
    weak var delegateNotesSearch: UserInfoDelegate? = nil
    
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
        else {
            _taskList[task.group] = [task]
        }
        delegateDayComposite?.taskListUpdated()
    }
    
    public func removeTask(index: Int, group: String) {
        if var array = _taskList[group] {
            array.remove(at: index)
            _taskList[group] = array
        }
        delegateDayComposite?.taskListUpdated()
    }
    
    public func updateTask(at index: Int, task: Task){
        if var array = _taskList[task.group] {
            array[index] = task
            _taskList[task.group] = array
        }
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
        let calendar: Calendar = Calendar.current
        for (group, _) in _taskList {
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
//            switch date.compare(task.date) {
//            case .orderedAscending     :   print("Date A is earlier than date B")
//            case .orderedDescending    :   print("Date A is later than date B")
//            case .orderedSame          :   dayTasks.append(task)
//          }
                }
            }
        }
        
        return dayTasks
    }
    
    public func searchDailyNotes(word: String) {
        // TODO: add functionality for searching Daily notes for a string
    }
    
    public func searchTaskNotes(word: String) {
        //TODO: Search through each task's notes for the given string
    }
    
    public func searchTasks(word: String) {
        // TODO: Search through each task by task title for the keyword given.
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
    
    public func addNewNote(note: Note) {
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
    
    
    // MARK: - Persistence Methods
    public func load() {
        //TODO: Implement Persistance Load
    }
    public func save() {
        //TODO: Implement Persistance Save
    }
    
}
