//
//  DayCompositeView.swift
//  ProjectFinal
//
//  Created by John Paul Young on 4/27/17.
//  Copyright © 2017 John Young. All rights reserved.
//

import UIKit

class DayCompositeView: UIView {
    var calendarCollectionView: CalendarCollectionView? = nil
    var taskListTableView: TaskListTableView? = nil
    private var _taskList: [String:[Task]]
    
    override init(frame: CGRect) {
        _taskList = [:]
        super.init(frame: frame)
        taskListTableView = TaskListTableView()
        calendarCollectionView = CalendarCollectionView()
        addSubview(taskListTableView!)
        addSubview(calendarCollectionView!)
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var r: CGRect = bounds
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
}
