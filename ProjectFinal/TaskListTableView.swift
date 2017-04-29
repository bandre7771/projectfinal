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

    func addPressed() {
        NSLog("Add Pressed!")
        //TODO: Library.Instance.createNewGame()
    }
    
    //UITableView Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _taskList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        let cell: UITableViewCell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        let group: String = Array(_taskList.keys)[indexPath.section]
        if var array = taskList[group] {
            cell.textLabel?.text = array[index].title
        }
        
        //cell.detailTextLabel?.text = taskList[index].title
        //cell.textLabel?.textAlignment = .right
        //cell.detailTextLabel?.textAlignment = .right
        //cell = label
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var count = 0
        for(key, _) in _taskList {
            if count == section {
                return key
            }
            count = count + 1
        }
        return ""
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return _taskList.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let firstKey = Array(_taskList.keys)[section]
        if let array = _taskList[firstKey] {
            return array.count
        }
        return 0
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index: Int = indexPath.row
        NSLog("Selected cell at index: \(index)")
        //let task: Task = _taskList[index]
        let group: String = Array(_taskList.keys)[indexPath.section]
        delegateTask?.taskListTableView(table: self, selectedTask: index, group: group)
        // TODO: implement task edit window here
        /* let game: Game = GameLibrary.Instance.gameAtIndex(gameIndex)
        
        let gameViewController: GameViewController = GameViewController(game: game)
        navigationController?.pushViewController(gameViewController, animated: true)
        */
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == UITableViewCellEditingStyle.delete){
            let index: Int = indexPath.row
            NSLog("Attempted to delete cell at index: \(index)")
            // TODO: Library.Instance.deleteTaskAtIndex(index)
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
            setNeedsDisplay()
            reloadData()
            
        }
    }
    
    public var currentDay: Date {
        get{
            return _currentDay
        }
        set{
            _currentDay = newValue
        }
    }
}
