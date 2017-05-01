//
//  TasksListTableView.swift
//  ProjectFinal
//
//  Created by John Paul Young on 5/1/17.
//  Copyright © 2017 John Young. All rights reserved.
//

import UIKit

protocol TasksListTableViewDelegate: class {
    func tasksListTableView(updated task: Task)
}

class TasksListTableView: UITableView, UITableViewDataSource, UITableViewDelegate {
    // MARK: - UIViewController Overrides
    private var _tasks: [Task]? = nil
    
    public var delegateTasksList: TasksListTableViewDelegate? = nil
    
    override init(frame: CGRect, style: UITableViewStyle) {
        _tasks = []
        super.init(frame: frame, style: style)
        dataSource = self
        delegate = self
        self.allowsSelection = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //UITableView Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (_tasks?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        let cell: UITableViewCell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        let task: Task = _tasks![index]
        let date = monthDayYear(of: task)
        var taskDesc = (_tasks?[index].title)!
        let maxCharacters = 20
        
        if (taskDesc.characters.count > maxCharacters) {
            let i = taskDesc.index(taskDesc.startIndex, offsetBy: maxCharacters)
            taskDesc = taskDesc.substring(to: i) + "..."
        }
        cell.textLabel?.text = date
        cell.detailTextLabel?.text = taskDesc
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index: Int = indexPath.row
        NSLog("Selected cell at index: \(index)")
        delegateTasksList?.tasksListTableView(updated: _tasks![index])
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == UITableViewCellEditingStyle.delete){
            let index: Int = indexPath.row
            NSLog("Attempted to delete cell at index: \(index)")
        }
    }
    
    private func monthDayYear(of task: Task) -> String {
        let day: Date = task.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/YY"
        let monthDayYear: String = dateFormatter.string(from: day)
        return monthDayYear
    }
    
    public var tasks: [Task] {
        get{
            return _tasks!
        }
        set{
            _tasks = newValue
            setNeedsDisplay()
            self.reloadData()
        }
    }
}
