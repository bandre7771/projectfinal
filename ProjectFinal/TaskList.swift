//
//  TaskList.swift
//  ProjectFinal
//
//  Created by Ben Andrews on 4/19/17.
//  Copyright © 2017 John Young. All rights reserved.
//

import UIKit

class TaskList {
    private var _taskList: [Task]
    private var _taskGroupList: [Group]
    
    init() {
        _taskList = []
        _taskGroupList = []
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
    
    public func addGroup(group: Group) {
        _taskGroupList.append(group)
    }
    
    public func removeGroup(index: Int) {
        _taskGroupList.remove(at: index)
    }
    
    public func searchNotes(word: String) {
        //TODO: Search through each task's notes for the given string
    }
    
    public func searchTasks(word: String) {
        // TODO: Search through each task by name for the keyword given.
    }
    
    // MARK - Public Accessible Variables
    public var TaskList: [Task] {
        return _taskList
    }
    
    public var TaskGroupList: [Group] {
        return _taskGroupList
    }
}
