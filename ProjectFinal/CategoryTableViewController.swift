//
//  CategoryTableView
//  ProjectFinal
//
//  Created by John Paul Young on 4/27/17.
//  Copyright © 2017 John Young. All rights reserved.
//

import UIKit

protocol CategoryTableViewControllerDelegate: class {
    func categoryTableView(table: CategoryTableViewController, selectedCategory index: Int)
}

class CategoryTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    // MARK: - UIViewController Overrides
    private var _categories: [String]
    private var _selected: [Bool]
    
    
    init() {
        _categories = []
        _selected = []
        super.init(nibName: nil, bundle: nil)
        self.edgesForExtendedLayout = []
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        _categories = UserInfo.Instance.getAllCategories()
        _selected = UserInfo.Instance.getSelectedCategories()
        
        title = "Choose Categories"
        
        let tableView: UITableView = UITableView()
        view = tableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.dataSource = self
        contentView.delegate = self
        contentView.allowsSelection = true
    }
    
    public var contentView: UITableView {
        return view as! UITableView
    }
    
    //UITableView Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        let cell: UITableViewCell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        
        if _selected[index] {
            cell.textLabel?.text = _categories[index] + "  ✅"
        }
        else {
            cell.textLabel?.text = _categories[index]
        }
        //cell.detailTextLabel?.text = taskList[index].title
        //cell.textLabel?.textAlignment = .right
        //cell.detailTextLabel?.textAlignment = .right
        //cell = label
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index: Int = indexPath.row
        NSLog("Selected cell at index: \(index)")
        
        if _selected[index] {
            selected[index] = false
        }
        else {
            selected[index] = true
        }
        
        delegateCategory?.categoryTableView(table: self, selectedCategory: index)
        contentView.reloadData()
        //let task: Task = _taskList[index]
        //let group: String = Array(_currentDayTasks.keys)[indexPath.section]
    
        //delegateTask?.taskListTableView(table: self, selectedTask: index, group: group)
        // TODO: implement task edit window here
        /* let game: Game = GameLibrary.Instance.gameAtIndex(gameIndex)
         
         let gameViewController: GameViewController = GameViewController(game: game)
         navigationController?.pushViewController(gameViewController, animated: true)
         */
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    weak var delegateCategory: CategoryTableViewControllerDelegate? = nil
    
    public var categories: [String] {
        get{
            return _categories
        }
        set{
            _categories = newValue
        }
    }
    
    public var selected: [Bool] {
        get{
            return _selected
        }
        set{
            _selected = newValue
        }
    }
}
