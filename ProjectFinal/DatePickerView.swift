//
//  DatePickerView.swift
//  ProjectFinal
//
//  Created by John Paul Young on 4/29/17.
//  Copyright © 2017 John Young. All rights reserved.
//

import UIKit

class DatePickerView: UIView {
    
    private var _datePicker: UIDatePicker? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        autoresizesSubviews = true
        _datePicker = UIDatePicker()
        _datePicker?.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        _datePicker?.translatesAutoresizingMaskIntoConstraints = false
        _datePicker?.backgroundColor = UIColor.white
        _datePicker?.datePickerMode = UIDatePickerMode.date
        addSubview(_datePicker!)
        
        let views: [String : UIView] = ["datePicker": _datePicker!]
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[datePicker]|", options: .alignAllCenterX, metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[datePicker]|", options: .alignAllCenterY, metrics: nil, views: views))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public var date: Date {
        get {
            return (_datePicker?.date)!
        }
    }
}
