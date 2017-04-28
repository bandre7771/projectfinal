//
//  TaskViewController.swift
//  ProjectFinal
//
//  Created by Ben Andrews on 4/24/17.
//  Copyright © 2017 John Young. All rights reserved.
//

import UIKit

class TaskCollectionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    override func loadView() {
        let taskTableView = UITableView()
        view = taskTableView
    }
    
    override func viewDidLoad() {
        contentView.dataSource = self
    }
    
    private var contentView: UITableView{
        return view as! UITableView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell()
        cell.textLabel?.text = UserInfo.Instance.getTask(at: indexPath.row).title
        return cell
    }
    
    // MARK: - UITableViewDelegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let taskIndex: Int = indexPath.row
        let task: Task = UserInfo.Instance.getTask(at: taskIndex)
        
        let taskViewController: TaskViewController = TaskViewController(task: task)
        navigationController?.pushViewController(taskViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserInfo.Instance.TaskCollection.count
    }
}

