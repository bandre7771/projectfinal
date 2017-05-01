//
//  SearchBarView.swift
//  ProjectFinal
//
//  Created by John Paul Young on 4/28/17.
//  Copyright © 2017 John Young. All rights reserved.
//

import UIKit
protocol SearchBarViewDelegate: class {
    func searchBarView(to search: String)
}

class SearchBarView: UIView, UITextFieldDelegate {
    
    private var _searchField: UITextField? = nil
    
    weak var delegate: SearchBarViewDelegate? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        autoresizesSubviews = true
        _searchField = UITextField()
        _searchField?.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        _searchField?.translatesAutoresizingMaskIntoConstraints = false
        _searchField?.backgroundColor = UIColor.white
        _searchField?.keyboardType = UIKeyboardType.default
        _searchField?.returnKeyType = UIReturnKeyType.done
        _searchField?.clearButtonMode = UITextFieldViewMode.whileEditing
        _searchField?.borderStyle = UITextBorderStyle.roundedRect
        _searchField?.delegate = self
        addSubview(_searchField!)
        
        let views: [String : UIView] = ["searchField": _searchField!]
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[searchField]-|", options: .alignAllCenterX, metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[searchField]-|", options: .alignAllCenterY, metrics: nil, views: views))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public var text: String {
        get {
            return (_searchField?.text)!
        }
    }
    
    // MARK: Textfield Delegates
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("TextField did begin editing method called")
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        print("TextField did end editing method called")
        if (textField.text != nil) {
            delegate?.searchBarView(to: textField.text!)
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("TextField should begin editing method called")
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        print("TextField should clear method called")
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("TextField should end editing method called")
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("While entering the characters this method gets called")
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("TextField should return method called")
        textField.resignFirstResponder()
        return true
    }
    
}
