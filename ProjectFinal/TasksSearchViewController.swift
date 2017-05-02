//
//  TasksSearchViewController.swift
//  ProjectFinal
//
//  Created by John Paul Young on 5/1/17.
//  Copyright © 2017 John Young. All rights reserved.
//

import UIKit

class TasksSearchViewController: UIViewController, UserInfoDelegate, TasksSearchViewDelegate, TaskViewControllerDelegate {

    private var _currentSearch: [Task]? = nil
    private var _allTasks: [Task]? = nil
    
    init() {
        super.init(nibName: "DayCompositViewController", bundle: nil)
        UserInfo.Instance.delegateTasksSearch = self
        self.edgesForExtendedLayout = []
        _currentSearch = []
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var tasksSearchView: TasksSearchView {
        return view as! TasksSearchView
    }
    
    override func loadView() {
        view = TasksSearchView()
        refresh()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Tasks"
        tasksSearchView.delegate = self
        _allTasks = arrayFrom(task: UserInfo.Instance.TaskCollection)
        _currentSearch = _allTasks
        refresh()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (UserInfo.Instance.taskSearchViewTutorial) {
            let alert = UIAlertController(title: "Tasks", message: "This page allows you to search through your daily tasks. To add a new task, tap the add button in the top bar of the day view inside the day tab.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Got it!", style: UIAlertActionStyle.default, handler: {(action: UIAlertAction) in ()}))
            self.present(alert, animated: true, completion: nil)
            UserInfo.Instance.taskSearchViewTutorial = false
        }
    }
    
    public func refresh() {
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = UIColor.white
        let clearSearch = UIBarButtonItem(title: "Clear Search", style: .plain, target: self, action: #selector(clearCurrentSearch))
        navigationItem.rightBarButtonItem = clearSearch
        tasksSearchView.updateSearch(to: _currentSearch!)
    }
    
    private func arrayFrom(task collection: [String : [Task]]) -> [Task] {
        var tasks: [Task] = []
        for (_, value) in collection {
            for task in value {
                tasks.append(task)
            }
        }
        return tasks
    }
    
    // Private search related methods
    private func currentSearchChanged(to search: String) {
        _currentSearch?.removeAll()
        let lowerCaseSearch: String = search.lowercased()
        if !lowerCaseSearch.isEmpty {
            for task in _allTasks! {
                let lowerCaseTaskTitle: String = task.title.lowercased()
                let lowerCaseNaskNote: String = task.notes.text.lowercased()
                if lowerCaseTaskTitle.contains(lowerCaseSearch) || lowerCaseNaskNote.contains(lowerCaseSearch) {
                    _currentSearch?.append(task)
                }
            }
            refresh()
        } else {
            clearCurrentSearch()
        }
    }
    
    @objc private func clearCurrentSearch() {
        _currentSearch = _allTasks
        refresh()
    }
    
    // MARK: TaskSearchViewDelegateMethods
    func tasksSearchView(to search: String) {
        currentSearchChanged(to: search)
    }
    
    func tasksSearchView(updated task: Task) {
        let taskViewController: TaskViewController = TaskViewController(task: task)
        taskViewController.delegate = self
        navigationController?.pushViewController(taskViewController , animated: true)
    }
    
    // MARK: UserInfoDelegate Methods
    func taskListUpdated() {
        _allTasks = arrayFrom(task: UserInfo.Instance.TaskCollection)
        _currentSearch = _allTasks
        refresh()
    }
    func notesListChanged(_ notes: [Note]) {}
    
    // MARK: TaskViewControllerDelegate Methods
    func taskViewController(taskViewController: TaskViewController, newTask: Task, oldTask: Task) {
        if UserInfo.Instance.taskExists(task: oldTask) {
            UserInfo.Instance.removeTask(task: oldTask)
        }
        UserInfo.Instance.addTask(task: newTask)
    }
    func doneEditing(updated task: Task) {
        navigationController?.popViewController(animated: true)
    }
}
