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
}

class TaskViewController: UIViewController, TaskViewDelegate, DatePickerViewControllerDelegate  {
    
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
        view = TaskView()
        title = "Task Details"
        taskView.task.title = _task.title
        taskView.task.group = _task.group
        taskView.task.priority = _task.priority
        taskView.task.date = _task.date
        taskView.task.status = _task.status
        taskView.task.notes.text = _task.notes.text
        taskView.delegate = self
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Perform any additional setup after loading the view, typically from a nib.
        let saveButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
        navigationItem.setRightBarButtonItems([saveButton], animated: true)
        // The line below will move the search bar below the nav bar
        navigationController?.navigationBar.isTranslucent = false;
        taskView.refresh()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (UserInfo.Instance.taskViewTutorial) {
            let alert = UIAlertController(title: "Tasks Details", message: "This page allows you to add details to a new task or edit them for an existing task.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Got it!", style: UIAlertActionStyle.default, handler: {(action: UIAlertAction) in ()}))
            self.present(alert, animated: true, completion: nil)
            UserInfo.Instance.taskViewTutorial = false
        }
    }
    
    public func save(){
        let task: Task = taskView.task //Task(title: taskView.title, status: taskView.status, priority: taskView.priority, date: taskView.date, group: taskView.group, notes: Note(text: taskView.note, date: taskView.date))
        //delegate?.doneEditing(updated: task)
        delegate?.taskViewController(taskViewController: self, newTask: task, oldTask: _task)
    }
    
//    func taskUpdated() {
//        let task: Task = taskView.task //Task(title: taskView.title, status: taskView.status, priority: taskView.priority, date: taskView.date, group: taskView.group, notes: Note(text: taskView.note, date: taskView.date))
//        
//        
//    }
    
    func taskViewDelegate() {
        let datePickerViewController: DatePickerViewController = DatePickerViewController()
        datePickerViewController.delegate = self
        navigationController?.pushViewController(datePickerViewController, animated: true)
    }
    
    weak var delegate: TaskViewControllerDelegate? = nil
    
    public var taskView: TaskView {
        return view as! TaskView
    }
    
    // MARK: DatePickerViewControllerDelegate methods
    func datePickerViewControllerMethods(picked date: Date) {
        taskView.task.date = date
        taskView.refresh()
    }

}
