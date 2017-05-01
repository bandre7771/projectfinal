//
//  TasksSearchView.swift
//  ProjectFinal
//
//  Created by John Paul Young on 5/1/17.
//  Copyright © 2017 John Young. All rights reserved.
//
import UIKit

protocol TasksSearchViewDelegate: class {
    func tasksSearchView(to search: String)
    func tasksSearchView(updated task: Task)
}

class TasksSearchView: UIView, SearchBarViewDelegate, TasksListTableViewDelegate {
    private var _searchBarView: SearchBarView? = nil
    private var _taskListTableView: TasksListTableView? = nil
    
    weak var delegate: TasksSearchViewDelegate? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        _searchBarView = SearchBarView()
        _searchBarView?.delegate = self
        addSubview(_searchBarView!)
        
        _taskListTableView = TasksListTableView()
        _taskListTableView?.delegateTasksList = self
        addSubview(_taskListTableView!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var r: CGRect = bounds
        (_searchBarView!.frame, r) = r.divided(atDistance: r.height*0.08, from: .minYEdge)
        (_taskListTableView!.frame, r) = r.divided(atDistance: r.height, from: .minYEdge)
    }
    
    public func updateSearch(to tasks: [Task]) {
        _taskListTableView?.tasks = tasks.sorted(by: >)
    }
    
    func searchBarView(to search: String) {
        delegate?.tasksSearchView(to: search)
        NSLog("Current task search: \(search)")
    }
    
    func tasksListTableView(updated task: Task) {
        delegate?.tasksSearchView(updated: task)
    }
    
}
