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
        
        title = "Categories"
        
        let tableView: UITableView = UITableView()
        view = tableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserInfo.Instance.categoryViewTutorial {
            let alert = UIAlertController(title: "Categories", message: "This page displays all the task groups. Choose which tasks you would like to view by tapping the group.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Got it!", style: UIAlertActionStyle.default, handler: {(action: UIAlertAction) in ()}))
            self.present(alert, animated: true, completion: nil)
            UserInfo.Instance.categoryViewTutorial = false
        }
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
        
        cell.textLabel?.text = _categories[index]
        if _selected[index] {
            cell.detailTextLabel?.text = "✅"
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
