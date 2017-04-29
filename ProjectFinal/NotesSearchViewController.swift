//
//  NotesSearchViewController.swift
//  ProjectFinal
//
//  Created by John Paul Young on 4/28/17.
//  Copyright © 2017 John Young. All rights reserved.
//

import UIKit

class NotesSearchViewController: UIViewController {
    
    init() {
        super.init(nibName: "DayCompositViewController", bundle: nil)
        self.edgesForExtendedLayout = []
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var notesSearchView: NotesSearchView {
        return view as! NotesSearchView
    }
    
    override func loadView() {
        view = NotesSearchView()
        refresh()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Notes"
        refresh()
    }
    
    public func refresh() {
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = UIColor.white
        let currentDay = UIBarButtonItem(title: currentMonthDayYear, style: .plain, target: nil, action: nil)
        navigationItem.leftBarButtonItems = [currentDay]
        notesSearchView.updateSearch(to: UserInfo.Instance.currentNoteSearch)
    }
    
    private var currentMonthDayYear: String {
        let currentDay: Date = UserInfo.Instance.currentDay
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd YYYY"
        let monthDayYear: String = dateFormatter.string(from: currentDay)
        return monthDayYear
    }
}
