//
//  DayCompositeView.swift
//  ProjectFinal
//
//  Created by John Paul Young on 4/27/17.
//  Copyright © 2017 John Young. All rights reserved.
//

import UIKit

class DayCompositeView: UIView {
<<<<<<< HEAD
    var calendarCollectionViewController: CalendarCollectionViewController? = nil
    var taskListTableView: TaskListTableView? = nil
    private var _taskList: [Task]
    
=======
    var calendarCollectionView: CalendarCollectionView? = nil
    var taskListViewController: TaskListViewController? = nil
>>>>>>> 53645ec84c626eab8a57d09e3caf585ea1682504
    override init(frame: CGRect) {
        _taskList = []
        super.init(frame: frame)
<<<<<<< HEAD
        calendarCollectionViewController = CalendarCollectionViewController()
        taskListTableView = TaskListTableView()
        
        addSubview(calendarCollectionView)
        addSubview(taskListTableView!)
    }
    
    private var calendarCollectionView: UICollectionView {
        return (calendarCollectionViewController?.view)! as! UICollectionView
    }
    
  
=======
        calendarCollectionView = CalendarCollectionView()
        taskListViewController = TaskListViewController()
        
        addSubview(calendarCollectionView!)
        addSubview(taskListView)
    }
    
    private var taskListView: UITableView {
        return (taskListViewController?.view)! as! UITableView
    }
>>>>>>> 53645ec84c626eab8a57d09e3caf585ea1682504

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var r: CGRect = bounds
<<<<<<< HEAD
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
=======
        var frame: CGRect = CGRect.zero
        (frame, r) = r.divided(atDistance: r.width*0.50, from: .maxXEdge)
        calendarCollectionView?.frame = frame
        (taskListView.frame, r) = r.divided(atDistance: r.width, from: .maxXEdge)
>>>>>>> 53645ec84c626eab8a57d09e3caf585ea1682504
    }
}
