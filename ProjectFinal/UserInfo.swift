//
//  UserInfo.swift
//  ProjectFinal
//
//  Created by Ben Andrews on 4/24/17.
//  Copyright © 2017 John Young. All rights reserved.
//

import UIKit
protocol UserInfoDelegate: class {
    func currentDayChanged()
}

class UserInfo {
    
    private var _taskList: [Task] = []
    private var _taskGroupList: [Group] = []
    private var _dailyNoteList: [Note] = []
    private var _currentDay: Date? = nil
    
    public var delegate: UserInfoDelegate? = nil
    
    public static let Instance: UserInfo = UserInfo()
    
    private init() {
        _currentDay = Date()
    }
    
    public func addTask(task: Task) {
        _taskList.append(task)
    }
    
    public func removeTask(index: Int) {
        _taskList.remove(at: index)
    }
    
    public func updateTask(at index: Int, task: Task){
        _taskList[index] = task
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
    
    public func goToNextDay() {
        _currentDay = Calendar.current.date(byAdding: .day, value: 1, to: _currentDay!)
        delegate?.currentDayChanged()
        NSLog("Day Incremented To: \(String(describing: _currentDay?.description))")
    }
    public func goToPastDay() {
        _currentDay = Calendar.current.date(byAdding: .day, value: -1, to: _currentDay!)
        delegate?.currentDayChanged()
        NSLog("Day Decremented To: \(String(describing: _currentDay?.description))")
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
