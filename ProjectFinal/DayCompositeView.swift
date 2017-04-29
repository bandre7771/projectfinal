//
//  DayCompositeView.swift
//  ProjectFinal
//
//  Created by John Paul Young on 4/27/17.
//  Copyright © 2017 John Young. All rights reserved.
//

import UIKit
protocol DayCompositeViewDelegate: class {
    func dailyNoteViewTapped()
}

class DayCompositeView: UIView, DailyNoteViewDelegate {
    var calendarCollectionView: CalendarCollectionView? = nil
    var taskListTableView: TaskListTableView? = nil
    var dailyNoteView: DailyNoteView? = nil
    private var _taskList: [String:[Task]]
    
    public var delegate: DayCompositeViewDelegate? = nil
    
    override init(frame: CGRect) {
        _taskList = [:]
        super.init(frame: frame)
        taskListTableView = TaskListTableView()
        calendarCollectionView = CalendarCollectionView()
        dailyNoteView = DailyNoteView()
        dailyNoteView?.delegate = self
        addSubview(taskListTableView!)
        addSubview(calendarCollectionView!)
        addSubview(dailyNoteView!)
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var r: CGRect = bounds
        (dailyNoteView!.frame, r) = r.divided(atDistance: r.height*0.10, from: .maxYEdge)
        (calendarCollectionView!.frame, r) = r.divided(atDistance: r.width*0.50, from: .maxXEdge)
        (taskListTableView!.frame, r) = r.divided(atDistance: r.width, from: .maxXEdge)
    }

    public var taskList: [String:[Task]] {
        get{
            return _taskList
        }
        set{
            _taskList = newValue
            taskListTableView?.taskList = newValue
        }
    }
    
    func noteViewTapped() {
        delegate?.dailyNoteViewTapped()
    }
    
}
