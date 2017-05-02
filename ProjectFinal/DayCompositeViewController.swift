//
//  DayCompositeViewController.swift
//  ProjectFinal
//
//  Created by John Paul Young on 4/27/17.
//  Copyright © 2017 John Young. All rights reserved.
//

import UIKit

class DayCompositeViewController: UIViewController, UserInfoDelegate, TaskListTableViewDelegate, TaskViewControllerDelegate, NoteViewControllerDelegate, DayCompositeViewDelegate, DatePickerViewControllerDelegate {
    
    private var _currentDay: Date? = nil
    private var _currentNote: Note? = nil
    private var _currentTaskIndex: Int
    
    init() {
        _currentTaskIndex = 0
        super.init(nibName: "DayCompositViewController", bundle: nil)
        self.edgesForExtendedLayout = []
        UserInfo.Instance.delegateDayComposite = self
        _currentDay = Date()
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
        title = "Day"
        refresh()
        let swipeR = UISwipeGestureRecognizer(target: self, action: #selector(DayCompositeViewController.swipeRightOccured(swipe:)))
        swipeR.direction = .right
        let swipeL = UISwipeGestureRecognizer(target: self, action: #selector(DayCompositeViewController.swipeLeftOccured(swipe:)))
        swipeL.direction = .left
        view.addGestureRecognizer(swipeR)
        view.addGestureRecognizer(swipeL)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (UserInfo.Instance.dayViewTutorial) {
            let alert = UIAlertController(title: "Welcome", message: "This page displays all of your tasks swipe left or right to change days or tap the date in the upper left corner to select a day to display.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Got it!", style: UIAlertActionStyle.default, handler: {(action: UIAlertAction) in ()}))
            self.present(alert, animated: true, completion: nil)
            UserInfo.Instance.dayViewTutorial = false
        }
    }
    
    public func refresh() {
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = UIColor.white
        let searchTask = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchForTask))
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewTask))
        let calendar = UIBarButtonItem(title: currentMonthDayYear, style: .plain, target: self, action: #selector(chooseDay))
        let today = UIBarButtonItem(title: "Today", style: .plain, target: self, action: #selector(goToToday))
        navigationItem.rightBarButtonItems = [today, searchTask]
        navigationItem.leftBarButtonItems = [calendar, add]
        navigationItem.titleView = UIView()
        
        dayCompositeView.taskListTableView?.taskList = UserInfo.Instance.TaskCollection
        dayCompositeView.taskListTableView?.delegateTask = self
        dayCompositeView.taskListTableView?.currentDay = _currentDay!
        dayCompositeView.calendarCollectionView?.events = EventsCalendarCollection.Instance.getAllEventsForCurrentDay()
        dayCompositeView.dailyNoteView?.text = ""
        _currentNote = Note(text: "", date: currentDay)
        for note in UserInfo.Instance.notes {
            if Calendar.current.startOfDay(for: note.date) == Calendar.current.startOfDay(for: currentDay) {
                _currentNote = note
                dayCompositeView.dailyNoteView?.text = (_currentNote?.text)!
                break
            }
        }
    }
    
    private var currentMonthDayYear: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd YYYY"
        let monthDayYear: String = dateFormatter.string(from: currentDay)
        return monthDayYear
    }
    
    func searchForTask() {
        navigationController?.pushViewController(TasksSearchViewController(), animated: true)
    }
    
    func addNewTask(){
        let task: Task = Task()
        UserInfo.Instance.addTask(task: task)
        let taskViewController: TaskViewController = TaskViewController(task: task)
        taskViewController.delegate = self
        navigationController?.pushViewController(taskViewController, animated: true)
    }
    
    // MARK - Delegates from TaskListTableView
    func taskListTableView(table: TaskListTableView, selectedTask index: Int, group: String)  {
        let taskViewController: TaskViewController = TaskViewController(task: UserInfo.Instance.getTask(at: index, group: group))
        taskViewController.delegate = self
        navigationController?.pushViewController(taskViewController, animated: true)
        _currentTaskIndex = index
    }
    
    func taskListTableView(table: TaskListTableView, removeTask index: Int, group: String) {
        UserInfo.Instance.removeTask(index: index, group: group)
    }
    
    

    @objc private func swipeRightOccured(swipe: UISwipeGestureRecognizer) {
        currentDay = Calendar.current.date(byAdding: .day, value: -1, to: currentDay)!
        refresh()
        NSLog("swiped right")
    }
    
    @objc private func swipeLeftOccured(swipe: UISwipeGestureRecognizer) {
        currentDay = Calendar.current.date(byAdding: .day, value: 1, to: currentDay)!
        refresh()
        NSLog("swiped left")
    }
    
    @objc private func goToToday() {
        currentDay = Date()
    }
    
    @objc private func chooseDay() {
        let datePickerViewController: DatePickerViewController = DatePickerViewController()
        datePickerViewController.delegate = self
        navigationController?.pushViewController(datePickerViewController, animated: true)
    }
    
    // MARK: UserInfoDelegate Methods
    func currentDayChanged(to date: Date) {
        EventsCalendarCollection.Instance.currentDayChanged(to: date)
        currentDay = date
        refresh()
    }
    
    func taskListUpdated() {
        refresh()
    }
    
    func notesListChanged(_ notes: [Note]) {
        refresh()
    }
    
    // MARK: NoteViewControllerDelegate methods
    func noteViewController(save note: Note) {
        UserInfo.Instance.addOrUpdateNote(note)
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: DatePickerViewController methods
    func datePickerViewControllerMethods(picked date: Date) {
        currentDay = date
        refresh()
    }
    
    // MARK: DayCompositeViewDelegate methods
    func dailyNoteViewTapped() {
        let noteViewController: NoteViewController = NoteViewController(Note: _currentNote!)
        noteViewController.delegate = self
        navigationController?.pushViewController(noteViewController , animated: true)
    }
    
    var currentDay: Date {
        get {
            return _currentDay!
        }
        set {
            _currentDay = newValue
            EventsCalendarCollection.Instance.currentDayChanged(to: newValue)
            refresh()
        }
    }
    
    // MARK - Delegates from TaskViewController
    func taskViewController(taskViewController: TaskViewController, newTask: Task, oldTask: Task) {
        if UserInfo.Instance.taskExists(task: oldTask) {
            UserInfo.Instance.removeTask(task: oldTask)
        }
        UserInfo.Instance.addTask(task: newTask)
        navigationController?.popViewController(animated: true)
    }
}
