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
    func taskListUpdated() { refresh() }
    func notesListChanged(_ notes: [Note]) {}
    
    // MARK: TaskViewControllerDelegate Methods
    func taskViewController(taskViewController: TaskViewController, saveTask: Task) {
        let index: Int = UserInfo.Instance.getIndexOf(saveTask)
        UserInfo.Instance.updateTask(at: index, task: saveTask)
        navigationController?.popViewController(animated: true)
    }
    
    func doneEditing() {
        navigationController?.popViewController(animated: true)
    }
}