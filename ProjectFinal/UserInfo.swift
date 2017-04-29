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
}

class UserInfo {
    
    private var _dailyDictionary: [Date : [Task]] = [Calendar.current.startOfDay(for: Date()): [/*Event(title: "Demo Event", startHour: 4, startMinute: 0, endHour: 8, endMinute: 0, date: Date()),
         Event(title: "Demo Event", startHour: 12, startMinute: 0, endHour: 14, endMinute: 0, date: Date()),
         Event(title: "Demo Event", startHour: 16, startMinute: 0, endHour: 17, endMinute: 0, date: Date()),
         Event(title: "Demo Event", startHour: 16, startMinute: 50, endHour: 19, endMinute: 0, date: Date())*/]]
    private var _taskList: [Task] = []
    private var _taskGroupList: [Group] = []
    private var _dailyNoteList: [Note] = []
    private var _currentDay: Date? = nil
    
    weak var delegate: UserInfoDelegate? = nil
    
    public static let Instance: UserInfo = UserInfo()
    
    private init() {
        _currentDay = Date()
        for (_,value) in _dailyDictionary {
            for task in value {
                _taskList.append(task)
            }
        }
    }
    
    public func addTask(task: Task) {
        _taskList.append(task)
        delegate?.taskListUpdated()
    }
    
    public func removeTask(index: Int) {
        _taskList.remove(at: index)
        delegate?.taskListUpdated()
    }
    
    public func updateTask(at index: Int, task: Task){
        _taskList[index] = task
        delegate?.taskListUpdated()
    }
    
    public func getTask(at index: Int) -> Task {
        return _taskList[index]
    }
    
    public func addGroup(group: Group) {
        _taskGroupList.append(group)
    }
    
    public func removeGroup(index: Int) {
        _taskGroupList.remove(at: index)
    }
    
    public func addDailyNote(note: Note) {
        _dailyNoteList.append(note)
        
    }
    
    public func removeDailyNote(at index: Int) {
        _dailyNoteList.remove(at: index)
    }
    
    
    public func getDaysTasks(date: Date) -> [Task]{
        var dayTasks: [Task] = []
        var calendar: Calendar = Calendar.current
        for task in _taskList {
            if calendar.isDate(task.date, equalTo: date, toGranularity: .day) {
                dayTasks.append(task)
            }
//            switch date.compare(task.date) {
//            case .orderedAscending     :   print("Date A is earlier than date B")
//            case .orderedDescending    :   print("Date A is later than date B")
//            case .orderedSame          :   dayTasks.append(task)
//            }
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
    
    public func currentDayChanged(to date: Date) {
        _taskList.removeAll()
        let start = Calendar.current.startOfDay(for: date)
        if _dailyDictionary[start] != nil {
            for task in _dailyDictionary[start]! {
                _taskList.append(task)
            }
        }
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
    public var TaskCollection: [Task] {
        return _taskList
    }
    
    public var TaskGroupList: [Group] {
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
    
    
    // MARK - Public Accessible Variables
    public var dailyNoteList: [Note]{
        return _dailyNoteList
    }


    
}
