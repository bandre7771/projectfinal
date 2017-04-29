//
//  DayCompositeViewController.swift
//  ProjectFinal
//
//  Created by John Paul Young on 4/27/17.
//  Copyright © 2017 John Young. All rights reserved.
//

import UIKit

class DayCompositeViewController: UIViewController, UserInfoDelegate, TaskListTableViewDelegate, TaskViewControllerDelegate {
    private var _currentDay: Date? = nil
    
    private var _currentTaskIndex: Int
    
    init() {
        _currentTaskIndex = 0
        super.init(nibName: "DayCompositViewController", bundle: nil)
        self.edgesForExtendedLayout = []
        UserInfo.Instance.delegate = self
        _currentDay = UserInfo.Instance.currentDay
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
        title = "Today"
        refresh()
        let swipeR = UISwipeGestureRecognizer(target: self, action: #selector(DayCompositeViewController.swipeRightOccured(swipe:)))
        swipeR.direction = .right
        let swipeL = UISwipeGestureRecognizer(target: self, action: #selector(DayCompositeViewController.swipeLeftOccured(swipe:)))
        swipeL.direction = .left
        view.addGestureRecognizer(swipeR)
        view.addGestureRecognizer(swipeL)
    }
    
    public func refresh() {
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = UIColor.white
        let task = UIBarButtonItem(barButtonSystemItem: .search, target: nil, action: nil)
        let category = UIBarButtonItem(barButtonSystemItem: .organize, target: nil, action: nil)
        let currentDay = UIBarButtonItem(title: currentMonthDayYear, style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = task
        navigationItem.leftBarButtonItems = [currentDay, category]
        navigationItem.titleView = UIView()
        let daysTasks: [Task] = UserInfo.Instance.getDaysTasks(date: UserInfo.Instance.currentDay)
        dayCompositeView.taskListTableView?.taskList = UserInfo.Instance.TaskCollection
        dayCompositeView.taskListTableView?.delegateTask = self
        dayCompositeView.calendarCollectionView?.events = EventsCalendarCollection.Instance.getAllCurrentEvents()
    }
    
    private var currentMonthDayYear: String {
        let currentDay: Date = UserInfo.Instance.currentDay
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd YYYY"
        let monthDayYear: String = dateFormatter.string(from: currentDay)
        return monthDayYear
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
    func currentDayChanged(to date: Date) {
        EventsCalendarCollection.Instance.currentDayChanged(to: date)
        _currentDay = date
        refresh()
    }
    
}
