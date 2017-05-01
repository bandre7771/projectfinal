//
//  TaskViewController.swift
//  ProjectFinal
//
//  Created by Ben Andrews on 4/24/17.
//  Copyright © 2017 John Young. All rights reserved.
//

import UIKit

protocol TaskViewControllerDelegate: class {
    func taskViewController(taskViewController: TaskViewController, newTask: Task, oldTask: Task)
    func doneEditing(updated task: Task)
}

class TaskViewController: UIViewController, TaskViewDelegate {
    private var _task: Task
    
    init(task: Task) {
        _task = task
        super.init(nibName: nil, bundle: nil)
        edgesForExtendedLayout = []
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let taskView: TaskView = TaskView()
        view = taskView
        title = "Task"
        taskView.title = _task.title
        taskView.group = _task.group
        taskView.priority = _task.priority
        taskView.date = _task.date
        taskView.status = _task.status
        taskView.note = _task.notes.text
        taskView.delegate = self
        
        refresh()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Perform any additional setup after loading the view, typically from a nib.
        let doneButton: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(save))
        navigationItem.setRightBarButtonItems([doneButton], animated: true)
        // The line below will move the search bar below the nav bar
        navigationController?.navigationBar.isTranslucent = false;
    }
    
    public func save(){
        let task: Task = Task(title: taskView.title, status: taskView.status, priority: taskView.priority, date: taskView.date, group: taskView.group, notes: Note(text: taskView.note, date: taskView.date))
        delegate?.doneEditing(updated: task)
    }
    
    func taskUpdated() {
        let task: Task = Task(title: taskView.title, status: taskView.status, priority: taskView.priority, date: taskView.date, group: taskView.group, notes: Note(text: taskView.note, date: taskView.date))
        
        delegate?.taskViewController(taskViewController: self, newTask: task, oldTask: _task)
    }
    
    weak var delegate: TaskViewControllerDelegate? = nil
    
    public func refresh() {
        
    }
    
    public var taskView: TaskView {
        return view as! TaskView
    }
}
