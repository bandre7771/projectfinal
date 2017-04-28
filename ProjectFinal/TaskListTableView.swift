//
//  TaskListViewController.swift
//  ProjectFinal
//
//  Created by John Paul Young on 4/27/17.
//  Copyright © 2017 John Young. All rights reserved.
//

import UIKit

class TaskListTableView: UITableView, UITableViewDataSource, UITableViewDelegate {
    // MARK: - UIViewController Overrides
    private var _taskList: [Task]
    
<<<<<<< HEAD:ProjectFinal/TaskListTableView.swift
    
    override init(frame: CGRect, style: UITableViewStyle) {
        _taskList = []
        dataSource = self
        super.init(frame: frame, style: style)
=======
    override func viewDidLoad() {
        title = "Daily Task List View"

        taskListTableView.delegate = self
        // TODO:Library.Instance.delegate = self
        taskListTableView.dataSource = self
>>>>>>> 53645ec84c626eab8a57d09e3caf585ea1682504:ProjectFinal/TaskListViewController.swift
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addPressed() {
        NSLog("Add Pressed!")
        //TODO: Library.Instance.createNewGame()
    }
    
    //UITableView Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _taskList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        let cell: UITableViewCell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        cell.textLabel?.text = taskList[index].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index: Int = indexPath.row
        NSLog("Selected cell at index: \(index)")
        // TODO: implement task edit window here
        /* let game: Game = GameLibrary.Instance.gameAtIndex(gameIndex)
        
        let gameViewController: GameViewController = GameViewController(game: game)
        navigationController?.pushViewController(gameViewController, animated: true)
        */
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == UITableViewCellEditingStyle.delete){
            let index: Int = indexPath.row
            NSLog("Attempted to delete cell at index: \(index)")
            // TODO: Library.Instance.deleteTaskAtIndex(index)
        }
    }
    
    public var taskList: [Task] {
        get{
            return _taskList
        }
        set{
            _taskList = newValue
            SetNeedsDisplay()
        }
    }
    
    // MARK: - GameLibraryDelegate Methods
    // TODO: impement following methods for tasks
//    func gameCreatedAtIndex(_ index: Int) {
//        GameLibrary.Instance.save()
//        gameListTableView.reloadData()
//    }
//    
//    func gameDeletedAtIndex(_ index: Int) {
//        GameLibrary.Instance.save()
//        gameListTableView.reloadData()
//    }
//    
//    func gameBoardChangedAtIndex(_ index: Int) {
//        GameLibrary.Instance.save()
//        let indexPath: IndexPath = IndexPath(row: index, section: 0)
//        gameListTableView.reloadRows(at: [indexPath], with: .none)
//    }

}
