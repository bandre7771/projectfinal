//
//  DatePickerViewController.swift
//  ProjectFinal
//
//  Created by John Paul Young on 4/29/17.
//  Copyright © 2017 John Young. All rights reserved.
//

import UIKit

protocol DatePickerViewControllerDelegate: class {
    func datePickerViewControllerMethods(picked date: Date)
}

class DatePickerViewController: UIViewController {
    
    weak var delegate: DatePickerViewControllerDelegate? = nil
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    public var datePickerView: DatePickerView {
        return view as! DatePickerView
    }
    
    override func loadView() {
        view = DatePickerView()
        title = "Note Details"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let goToDate: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(chooseDate))
        navigationItem.rightBarButtonItem = goToDate
    }
    @objc func chooseDate() {
        delegate?.datePickerViewControllerMethods(picked: datePickerView.date)
        navigationController?.popViewController(animated: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
