//
//  NoteView.swift
//  ProjectFinal
//
//  Created by John Paul Young on 4/29/17.
//  Copyright © 2017 John Young. All rights reserved.
//

import UIKit

class NoteView: UIView {
    
    private var _noteTextField: UITextView? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        autoresizesSubviews = true
        _noteTextField = UITextView()
        _noteTextField?.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        _noteTextField?.translatesAutoresizingMaskIntoConstraints = false
        _noteTextField?.backgroundColor = UIColor.white
        _noteTextField?.keyboardType = UIKeyboardType.default
        _noteTextField?.returnKeyType = UIReturnKeyType.done
        addSubview(_noteTextField!)

        let views: [String : UIView] = ["noteTextField": _noteTextField!]
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[noteTextField]|", options: .alignAllCenterX, metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[noteTextField]|", options: .alignAllCenterY, metrics: nil, views: views))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public var text: String {
        get {
            return (_noteTextField?.text)!
        }
        set {
            _noteTextField?.text = newValue
        }
    }
}
