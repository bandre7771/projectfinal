//
//  SearchBarView.swift
//  ProjectFinal
//
//  Created by John Paul Young on 4/28/17.
//  Copyright © 2017 John Young. All rights reserved.
//

import UIKit

class SearchBarView: UIView {
    private var _searchField: UITextField? = nil
    
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
        addSubview(_searchField!)
        
        let views: [String : UIView] = ["searchField": _searchField!]
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[searchField]-|", options: .alignAllCenterX, metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[searchField]-|", options: .alignAllCenterY, metrics: nil, views: views))

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
