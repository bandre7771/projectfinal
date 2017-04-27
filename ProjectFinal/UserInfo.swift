//
//  UserInfo.swift
//  ProjectFinal
//
//  Created by Ben Andrews on 4/24/17.
//  Copyright © 2017 John Young. All rights reserved.
//

import UIKit

class UserInfo {
    
    private var _taskList: [Task] = []
    private var _taskGroupList: [Group] = []
    private var _dailyNoteList: [Note] = []
    
    public static let Instance: UserInfo = UserInfo()
    
    private init() { }
    
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
    
    
    // MARK - Public Accessible Variables
    public var dailyNoteList: [Note]{
        return _dailyNoteList
    }


    
}
