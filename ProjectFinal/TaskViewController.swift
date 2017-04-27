//
//  TaskViewController.swift
//  ProjectFinal
//
//  Created by Ben Andrews on 4/24/17.
//  Copyright © 2017 John Young. All rights reserved.
//

import UIKit

class TaskViewController: UIViewController {
    private var _task: Task
    
    init(task: Task) {
        _task = task
        super.init(nibName: nil, bundle: nil)
        edgesForExtendedLayout = []
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let taskView: TaskView
        view = TaskView()
        
        refresh()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public func refresh() {
        
    }
}
