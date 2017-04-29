//
//  DayCompositeViewController.swift
//  ProjectFinal
//
//  Created by John Paul Young on 4/27/17.
//  Copyright © 2017 John Young. All rights reserved.
//

import UIKit

class DayCompositeViewController: UIViewController, UserInfoDelegate, TaskListTableViewDelegate, TaskViewControllerDelegate {
    
    private var _currentTaskIndex: Int
    
    init() {
        _currentTaskIndex = 0
        super.init(nibName: "DayCompositViewController", bundle: nil)
        self.edgesForExtendedLayout = []
        UserInfo.Instance.delegate = self
        _currentTaskIndex = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var dayCompositeView: DayCompositeView {
        return view as! DayCompositeView
    }
    
    override func loadView() {
        view = DayCompositeView()
        refresh()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dayCompositeView.backgroundColor = UIColor.blue
        title = "Today"
        
        let task = UIBarButtonItem(title: "Task Search", style: .plain, target: nil, action: nil)
        let category = UIBarButtonItem(title: "Categories", style: .plain, target: nil, action: nil)
        let currentDay = UIBarButtonItem(title: "\(UserInfo.Instance.currentDay)", style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = task
        navigationItem.leftBarButtonItems = [category, currentDay]

        let swipeR = UISwipeGestureRecognizer(target: self, action: #selector(DayCompositeViewController.swipeRightOccured(swipe:)))
        swipeR.direction = .right
        let swipeL = UISwipeGestureRecognizer(target: self, action: #selector(DayCompositeViewController.swipeLeftOccured(swipe:)))
        swipeL.direction = .left
        view.addGestureRecognizer(swipeR)
        view.addGestureRecognizer(swipeL)
    }
    
    public func refresh() {
        dayCompositeView.taskListTableView?.taskList = UserInfo.Instance.TaskCollection
        dayCompositeView.taskListTableView?.delegateTask = self
    }
    
    // MARK - Delegate from user info
    func taskListUpdated() {
        refresh()
    }
    
    // MARK - Delegates from TaskListTableView
    func taskListTableView(table: TaskListTableView, selectedTask index: Int)  {
        let taskViewController: TaskViewController = TaskViewController(task: UserInfo.Instance.getTask(at: index))
        taskViewController.delegate = self
        navigationController?.pushViewController(taskViewController, animated: true)
        _currentTaskIndex = index
        
    }
    
    func taskViewController(taskViewController: TaskViewController, saveTask: Task) {
        UserInfo.Instance.updateTask(at: _currentTaskIndex, task: saveTask)
        navigationController?.popViewController(animated: true)
    }
    
    
    
    @objc private func swipeRightOccured(swipe: UISwipeGestureRecognizer) {
        UserInfo.Instance.goToPastDay()
        NSLog("swiped right")
    }
    
    @objc private func swipeLeftOccured(swipe: UISwipeGestureRecognizer) {
        UserInfo.Instance.goToNextDay()
        NSLog("swiped left")
    }
    
    
    // MARK: UserInfoDelegate Methods
    func currentDayChanged() {
        // TODO: notify all subcontrollers and views of the change.
        
    }
    
    // MARK: 
    
}
