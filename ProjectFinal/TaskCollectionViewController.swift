//
//  TaskViewController.swift
//  ProjectFinal
//
//  Created by Ben Andrews on 4/24/17.
//  Copyright © 2017 John Young. All rights reserved.
//

import UIKit

class TaskCollectionViewController: UIViewController, UITableViewDataSource {
    
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
        //cell.backgroundColor = colorForIndex(indexPath.row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserInfo.Instance.TaskCollection.count
    }
}

