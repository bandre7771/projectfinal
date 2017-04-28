//
//  TaskListViewController.swift
//  ProjectFinal
//
//  Created by John Paul Young on 4/27/17.
//  Copyright © 2017 John Young. All rights reserved.
//

import UIKit

class TaskListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    // MARK: - UIViewController Overrides
    override func loadView() {
        view = UITableView()
    }
    
    override func viewDidLoad() {
        title = "Daily Task List View"

        taskListTableView.delegate = self
        // TODO:Library.Instance.delegate = self
        taskListTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // TODO: ListTableView.reloadData()
    }
    
    func addPressed() {
        NSLog("Add Pressed!")
        //TODO: Library.Instance.createNewGame()
    }
    
    private var taskListTableView: UITableView {
        return view as! UITableView
    }
    
    //UITableView Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5//TODO: Library.Instance.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        let cell: UITableViewCell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        cell.textLabel?.text = "cell at index: \(index)"
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
