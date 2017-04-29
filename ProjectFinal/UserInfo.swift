//
//  UserInfo.swift
//  ProjectFinal
//
//  Created by Ben Andrews on 4/24/17.
//  Copyright © 2017 John Young. All rights reserved.
//

import UIKit
protocol UserInfoDelegate: class {
    func currentDayChanged(to date: Date)
    func taskListUpdated()
    func notesListChanged(_ notes: [Note])
}

class UserInfo: NoteDelegate {
    
    private var _currentNoteSearch: [Note] = []
    
    private var _notes: [Note] = [Note.init(text: "This note is a demo note for today!", date: Date())]

    
    private var _dailyDictionary: [Date : [Task]] = [Calendar.current.startOfDay(for: Date()): [/*Event(title: "Demo Event", startHour: 4, startMinute: 0, endHour: 8, endMinute: 0, date: Date()),
         Event(title: "Demo Event", startHour: 12, startMinute: 0, endHour: 14, endMinute: 0, date: Date()),
         Event(title: "Demo Event", startHour: 16, startMinute: 0, endHour: 17, endMinute: 0, date: Date()),
         Event(title: "Demo Event", startHour: 16, startMinute: 50, endHour: 19, endMinute: 0, date: Date())*/]]
    private var _taskList: [String: [Task]] = [:]
    private var _taskGroupList: [String] = []
    private var _currentDay: Date? = nil
    
    weak var delegate: UserInfoDelegate? = nil
    
    public static let Instance: UserInfo = UserInfo()
    
    private init() {
        _currentDay = Date()
        
        let dayBeforeYesterday = Calendar.current.date(byAdding: .day, value: -2, to: _currentDay!)
        let yesterday = Calendar.current.date(byAdding: .day, value: 1, to: dayBeforeYesterday!)
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: _currentDay!)
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
        delegate?.taskListUpdated()
    }
    
    public func removeTask(index: Int, group: String) {
        if var array = _taskList[group] {
            array.remove(at: index)
            _taskList[group] = array
        }
        delegate?.taskListUpdated()
    }
    
    public func updateTask(at index: Int, task: Task){
        if var array = _taskList[task.group] {
            array[index] = task
            _taskList[task.group] = array
        }
        delegate?.taskListUpdated()
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
    
    public func goToNextDay() {
        _currentDay = Calendar.current.date(byAdding: .day, value: 1, to: _currentDay!)
        delegate?.currentDayChanged(to: _currentDay!)
        NSLog("Day Incremented To: \(String(describing: _currentDay?.description))")
    }
    public func goToPastDay() {
        _currentDay = Calendar.current.date(byAdding: .day, value: -1, to: _currentDay!)
        delegate?.currentDayChanged(to: _currentDay!)
        NSLog("Day Decremented To: \(String(describing: _currentDay?.description))")
    }
    
    public func goToDay(date: Date) {
        _currentDay = date
        NSLog("Day changed To: \(String(describing: _currentDay?.description))")
        delegate?.currentDayChanged(to: date)
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
    
    public var currentDay: Date {
        get {
            return _currentDay!
        }
        set {
            _currentDay = newValue
        }
    }
    
    

    
    
    // MARK - Note Public Accessible Variables
    public var noteCount: Int {
        return _notes.count
    }
    
    public var searchNoteCount: Int {
        return _currentNoteSearch.count
    }
    
    public var CurrentNoteSearch: [Note] {
        return _currentNoteSearch
    }
    
    public func createNewNote(note: Note) {
        note.delegates?.append(self)
        _notes.append(note)
//        delegate?.noteCreatedAtIndex(_notes.count - 1)
    }
    
    public func deleteNoteAtIndex(_ index: Int) {
        if(index >= 0 && index < _notes.count) {
            _notes.remove(at: index)
//            delegate?.noteDeletedAtIndex(index)
        } else {
            NSLog("Could not remove note")
        }
    }
    
    public func noteAtIndex(_ index: Int) -> Note {
        return _notes[index]
    }
    
    public func currentSearchChanged(to search: String) {
        _currentNoteSearch.removeAll()
        // TODO: Add regex
    }
    
    // MARK: - NoteDelegate Methods
    func noteChanged(_ note: Note) {
//        let index: Int? = _notes.index(where: {searchNote in searchNote === note})
//        if index != nil {
//            delegate?.noteChangedAtIndex(index!)
//        }
    }
    
    
    // MARK: - Persistence Methods
    public func load() {
        //TODO: Implement Persistance Load
    }
    public func save() {
        //TODO: Implement Persistance Save
    }
    
}
