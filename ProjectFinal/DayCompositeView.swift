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
    var taskListViewController: TaskListViewController? = nil
    override init(frame: CGRect) {
        super.init(frame: frame)
        calendarCollectionView = CalendarCollectionView()
        taskListViewController = TaskListViewController()
        
        addSubview(calendarCollectionView!)
        addSubview(taskListView)
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
        var frame: CGRect = CGRect.zero
        (frame, r) = r.divided(atDistance: r.width*0.50, from: .maxXEdge)
        calendarCollectionView?.frame = frame
        (taskListView.frame, r) = r.divided(atDistance: r.width, from: .maxXEdge)
    }
}
