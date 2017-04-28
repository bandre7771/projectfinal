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
        dayCompositeView.backgroundColor = UIColor.blue
        title = "Today"
        
        let task = UIBarButtonItem(title: "Task Search", style: .plain, target: nil, action: nil)
        let category = UIBarButtonItem(title: "Categories", style: .plain, target: nil, action: nil)
        let currentDay = UIBarButtonItem(title: "\(UserInfo.Instance.currentDay)", style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = task
        navigationItem.leftBarButtonItems = [category, currentDay]

        let swipeR = UISwipeGestureRecognizer(target: self, action: #selector(DayCompositeViewController.swipeRightOccured(swipe:)))
        swipeR.direction = .right
        let swipeL = UISwipeGestureRecognizer(target: self, action: #selector(DayCompositeViewController.swipeLeftOccured(swipe:)))
        swipeL.direction = .left
        view.addGestureRecognizer(swipeR)
        view.addGestureRecognizer(swipeL)
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
        // TODO: notify all subcontrollers and views of the change.
    }
    
}
