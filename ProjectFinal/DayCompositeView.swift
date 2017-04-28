//
//  DayCompositeView.swift
//  ProjectFinal
//
//  Created by John Paul Young on 4/27/17.
//  Copyright © 2017 John Young. All rights reserved.
//

import UIKit

class DayCompositeView: UIView {
    var calendarCollectionViewController: CalendarCollectionViewController? = nil
    var taskListTableView: TaskListTableView? = nil
    private var _taskList: [Task]
    
    override init(frame: CGRect) {
        _taskList = []
        super.init(frame: frame)
        calendarCollectionViewController = CalendarCollectionViewController()
        taskListTableView = TaskListTableView()
        
        addSubview(calendarCollectionView)
        addSubview(taskListTableView!)
    }
    
    private var calendarCollectionView: UICollectionView {
        return (calendarCollectionViewController?.view)! as! UICollectionView
    }
    
  

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var r: CGRect = bounds
        (calendarCollectionView.frame, r) = r.divided(atDistance: r.width*0.50, from: .maxXEdge)
        (taskListTableView!.frame, r) = r.divided(atDistance: r.width, from: .maxXEdge)
    }
    
    
    public var taskList: [Task]{
        get{
            return _taskList
        }
        set{
            _taskList = newValue
            taskListTableView?.taskList = newValue
        }
    }
}
