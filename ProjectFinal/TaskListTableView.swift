//
//  TaskListViewController.swift
//  ProjectFinal
//
//  Created by John Paul Young on 4/27/17.
//  Copyright © 2017 John Young. All rights reserved.
//

import UIKit

protocol TaskListTableViewDelegate: class {
    func taskListTableView(table: TaskListTableView, selectedTask index: Int, group: String)
    func taskListTableView(table: TaskListTableView, removeTask index: Int, group: String)
}

class TaskListTableView: UITableView, UITableViewDataSource, UITableViewDelegate {
    // MARK: - UIViewController Overrides
    private var _taskList: [String:[Task]]
    private var _currentDay: Date
    private var _currentDayTasks: [String:[Task]]
    private var _category: String
    
    
    override init(frame: CGRect, style: UITableViewStyle) {
        _taskList = [:]
        _currentDay = Date()
        _currentDayTasks = UserInfo.Instance.getDaysTasks(date: _currentDay)
        _category = ""
        super.init(frame: frame, style: style)
        dataSource = self
        self.allowsSelection = true
        self.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //UITableView Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        if !_currentDayTasks.isEmpty {
            for(key, _) in _currentDayTasks {
                if count == section {
                    if let array = _currentDayTasks[key] {
                        if array.count > 0 {
                            return array.count
                        }
                    }
                }
                count = count + 1
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        let cell: UITableViewCell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        let group: String = Array(_currentDayTasks.keys)[indexPath.section]
        if var array = taskList[group] {
            if index < array.count {
                cell.textLabel?.text = array[index].title
                var priority: String = ""
                for _ in 0..<array[index].priority {
                    priority += "!"
                }
                cell.detailTextLabel?.text = priority
                if array[index].status {
                    cell.textLabel?.textColor = UIColor.lightGray
                    cell.detailTextLabel?.textColor = UIColor.lightGray
                } else {
                    cell.textLabel?.textColor = UIColor.black
                    cell.detailTextLabel?.textColor = UIColor.black
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var count = 0
        for(key, _) in _currentDayTasks {
            if count == section {
                return key
            }
            count = count + 1
        }
        return ""
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if _currentDayTasks.count > 0 {
            return _currentDayTasks.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index: Int = indexPath.row
        NSLog("Selected cell at index: \(index)")
        let group: String = Array(_currentDayTasks.keys)[indexPath.section]
        delegateTask?.taskListTableView(table: self, selectedTask: index, group: group)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == UITableViewCellEditingStyle.delete){
            let index: Int = indexPath.row
            NSLog("Attempted to delete cell at index: \(index)")
            let group: String = Array(_currentDayTasks.keys)[indexPath.section]
            delegateTask?.taskListTableView(table: self, removeTask: index, group: group)
        }
    }
    
    public func getCurrentCategory () {
        
    }
    
    weak var delegateTask: TaskListTableViewDelegate? = nil
    
    public var taskList: [String:[Task]] {
        get{
            return _taskList
        }
        set{
            _taskList = newValue
            reloadData()
        }
    }
    
    public var currentDay: Date {
        get{
            return _currentDay
        }
        set{
            _currentDay = newValue
            _currentDayTasks = UserInfo.Instance.getDaysTasks(date: _currentDay)
            reloadData()
        }
    }
}
