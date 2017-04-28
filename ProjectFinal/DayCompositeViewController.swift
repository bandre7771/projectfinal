//
//  DayCompositeViewController.swift
//  ProjectFinal
//
//  Created by John Paul Young on 4/27/17.
//  Copyright © 2017 John Young. All rights reserved.
//

import UIKit

class DayCompositeViewController: UIViewController, UserInfoDelegate {
    
    init() {
        super.init(nibName: "DayCompositViewController", bundle: nil)
        self.edgesForExtendedLayout = []
        UserInfo.Instance.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var dayCompositeView: DayCompositeView {
        return view as! DayCompositeView
    }
    
    override func loadView() {
        view = DayCompositeView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Today"
        reloadNavigationBarItems()
        let swipeR = UISwipeGestureRecognizer(target: self, action: #selector(DayCompositeViewController.swipeRightOccured(swipe:)))
        swipeR.direction = .right
        let swipeL = UISwipeGestureRecognizer(target: self, action: #selector(DayCompositeViewController.swipeLeftOccured(swipe:)))
        swipeL.direction = .left
        view.addGestureRecognizer(swipeR)
        view.addGestureRecognizer(swipeL)
    }
    
    private func reloadNavigationBarItems() {
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = UIColor.white
        let task = UIBarButtonItem(barButtonSystemItem: .search, target: nil, action: nil)
        let category = UIBarButtonItem(barButtonSystemItem: .organize, target: nil, action: nil)
        let currentDay = UIBarButtonItem(title: currentMonthDayYear, style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = task
        navigationItem.leftBarButtonItems = [currentDay, category]
    }
    
    private var currentMonthDayYear: String {
        let currentDay: Date = UserInfo.Instance.currentDay
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd YYYY"
        let monthDayYear: String = dateFormatter.string(from: currentDay)
        return monthDayYear
    }
    
    @objc private func swipeRightOccured(swipe: UISwipeGestureRecognizer) {
        UserInfo.Instance.goToPastDay()
        NSLog("swiped right")
    }
    
    @objc private func swipeLeftOccured(swipe: UISwipeGestureRecognizer) {
        UserInfo.Instance.goToNextDay()
        NSLog("swiped left")
    }
    
    // MARK: UserInfoDelegate Methods
    func currentDayChanged() {
        reloadNavigationBarItems()
    }
    
}
