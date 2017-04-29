//
//  DayCompositeViewController.swift
//  ProjectFinal
//
//  Created by John Paul Young on 4/27/17.
//  Copyright © 2017 John Young. All rights reserved.
//

import UIKit

class DayCompositeViewController: UIViewController, UserInfoDelegate, TaskListTableViewDelegate, TaskViewControllerDelegate, NoteViewControllerDelegate, DayCompositeViewDelegate {
    
    private var _currentDay: Date? = nil
    private var _currentNote: Note? = nil
    private var _currentTaskIndex: Int
    
    init() {
        _currentTaskIndex = 0
        super.init(nibName: "DayCompositViewController", bundle: nil)
        self.edgesForExtendedLayout = []
        UserInfo.Instance.delegate = self
        _currentDay = UserInfo.Instance.currentDay
        _currentTaskIndex = 0
        _currentNote = Note()
        dayCompositeView.delegate = self
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
        let currentDay = UIBarButtonItem(title: currentMonthDayYear, style: .plain, target: self, action: #selector(goToToday))
        navigationItem.rightBarButtonItem = task
        navigationItem.leftBarButtonItems = [currentDay, category]
        navigationItem.titleView = UIView()
        dayCompositeView.taskListTableView?.taskList = UserInfo.Instance.TaskCollection
        dayCompositeView.taskListTableView?.delegateTask = self
        dayCompositeView.calendarCollectionView?.events = EventsCalendarCollection.Instance.getAllCurrentEvents()
        dayCompositeView.dailyNoteView?.text = ""
        _currentNote = Note(text: "", date: _currentDay!)
        for note in UserInfo.Instance.notes {
            if Calendar.current.startOfDay(for: note.date) == Calendar.current.startOfDay(for: _currentDay!) {
                _currentNote = note
                dayCompositeView.dailyNoteView?.text = (_currentNote?.text)!
                break
            }
        }
    }
    
    private var currentMonthDayYear: String {
        let currentDay: Date = UserInfo.Instance.currentDay
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd YYYY"
        let monthDayYear: String = dateFormatter.string(from: currentDay)
        return monthDayYear
    }
    
    // MARK: Delegate from user info
    func taskListUpdated() {
        refresh()
    }
    
    func notesListChanged(_ notes: [Note]) {
        refresh()
    }
    
    // MARK - Delegates from TaskListTableView
    func taskListTableView(table: TaskListTableView, selectedTask index: Int, group: String)  {
        let taskViewController: TaskViewController = TaskViewController(task: UserInfo.Instance.getTask(at: index, group: group))
        taskViewController.delegate = self
        navigationController?.pushViewController(taskViewController, animated: true)
        _currentTaskIndex = index
    }
    
    // MARK - Delegates from TaskViewController
    func taskViewController(taskViewController: TaskViewController, saveTask: Task) {
        UserInfo.Instance.updateTask(at: _currentTaskIndex, task: saveTask)
    }
    
    func doneEditing() {
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
    
    @objc private func goToToday() {
        UserInfo.Instance.goToDay(date: Date())
    }
    
    // MARK: UserInfoDelegate Methods
    func currentDayChanged(to date: Date) {
        EventsCalendarCollection.Instance.currentDayChanged(to: date)
        _currentDay = date
        refresh()
    }
    
    // MARK: NoteViewControllerDelegate methods
    func noteViewController(save note: Note) {
        UserInfo.Instance.addOrUpdateNote(note)
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: DayCompositeViewDelegate methods
    func dailyNoteViewTapped() {
        let noteViewController: NoteViewController = NoteViewController(Note: _currentNote!)
        noteViewController.delegate = self
        navigationController?.pushViewController(noteViewController , animated: true)
    }
    
}
