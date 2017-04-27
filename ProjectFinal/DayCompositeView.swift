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
    var taskListViewController: TaskListViewController? = nil
    override init(frame: CGRect) {
        super.init(frame: frame)
        calendarCollectionViewController = CalendarCollectionViewController()
        taskListViewController = TaskListViewController()
        
        addSubview(calendarCollectionView)
        addSubview(taskListView)
    }
    
    private var calendarCollectionView: UICollectionView {
        return (calendarCollectionViewController?.view)! as! UICollectionView
    }
    
    private var taskListView: UITableView {
        return (taskListViewController?.view)! as! UITableView
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var r: CGRect = bounds
        (calendarCollectionView.frame, r) = r.divided(atDistance: r.width*0.50, from: .maxXEdge)
        (taskListView.frame, r) = r.divided(atDistance: r.width, from: .maxXEdge)
    }
}
