//
//  TaskView.swift
//  ProjectFinal
//
//  Created by Ben Andrews on 4/24/17.
//  Copyright © 2017 John Young. All rights reserved.
//

import UIKit

class TaskView: UIView, UITextFieldDelegate{
    private var _title: String
    private var _date: Date
    private var _group: Group
    private var _priority: Int
    private var _status: Bool
    
    override init(frame: CGRect) {
        
        _title = ""
        _date = Date()
        _group = Group()
        _priority = 0
        _status = false
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect){
        let titleTextField: UITextField = UITextField(frame: CGRect(x: 50.0, y: 50.0, width: 100, height: 40))
        titleTextField.placeholder = "Title"
        titleTextField.keyboardType = UIKeyboardType.default
        titleTextField.returnKeyType = UIReturnKeyType.done
        titleTextField.clearButtonMode = UITextFieldViewMode.whileEditing
        titleTextField.borderStyle = UITextBorderStyle.roundedRect
        titleTextField.text = _title
        
        let dateTextField: UITextField = UITextField(frame: CGRect(x: 50.0, y: 100, width: 100, height: 40))
        dateTextField.placeholder = "Date"
        dateTextField.keyboardType = UIKeyboardType.default
        dateTextField.returnKeyType = UIReturnKeyType.done
        dateTextField.clearButtonMode = UITextFieldViewMode.whileEditing
        dateTextField.borderStyle = UITextBorderStyle.roundedRect
        dateTextField.text = _date.description
        
        let groupTextField: UITextField = UITextField(frame: CGRect(x: 50.0, y: 150.0, width: 100, height: 40))
        groupTextField.placeholder = "Title"
        groupTextField.keyboardType = UIKeyboardType.default
        groupTextField.returnKeyType = UIReturnKeyType.done
        groupTextField.clearButtonMode = UITextFieldViewMode.whileEditing
        groupTextField.borderStyle = UITextBorderStyle.roundedRect
        groupTextField.text = _group.name
        
        let priorityTextField: UITextField = UITextField(frame: CGRect(x: 50.0, y: 200.0, width: 100, height: 40))
        priorityTextField.placeholder = "Title"
        priorityTextField.keyboardType = UIKeyboardType.default
        priorityTextField.returnKeyType = UIReturnKeyType.done
        priorityTextField.clearButtonMode = UITextFieldViewMode.whileEditing
        priorityTextField.borderStyle = UITextBorderStyle.roundedRect
        priorityTextField.text = _priority.description
        
        
        let statusTextField: UITextField = UITextField(frame: CGRect(x: 50.0, y: 250.0, width: 30, height: 40))
        statusTextField.placeholder = "Title"
        statusTextField.keyboardType = UIKeyboardType.default
        statusTextField.returnKeyType = UIReturnKeyType.done
        statusTextField.clearButtonMode = UITextFieldViewMode.whileEditing
        statusTextField.borderStyle = UITextBorderStyle.roundedRect
        statusTextField.text = _status.description
        
        titleTextField.delegate = self
        dateTextField.delegate = self
        groupTextField.delegate = self
        priorityTextField.delegate = self
        statusTextField.delegate = self
        self.addSubview(titleTextField)
        self.addSubview(dateTextField)
        self.addSubview(groupTextField)
        self.addSubview(priorityTextField)
        self.addSubview(statusTextField)
    }
    
    // MARK: Textfield Delegates
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("TextField did begin editing method called")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("TextField did end editing method called")
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("TextField should begin editing method called")
        return true;
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        print("TextField should clear method called")
        return true;
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("TextField should snd editing method called")
        return true;
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("While entering the characters this method gets called")
        return true;
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("TextField should return method called")
        textField.resignFirstResponder();
        return true;
    }
    
    // MARK - Public access vars
    public var title: String {
        get{
            return _title
        }
        set{
            _title = newValue
        }
    }
    
    public var date: Date {
        get{
            return _date
        }
        set{
            _date = newValue
        }
    }
    
    public var group: Group {
        get{
            return _group
        }
        set{
            _group = newValue
        }
    }
    
    public var priority: Int {
        get{
            return _priority
        }
        set{
            _priority = newValue
        }
    }
    
    public var status: Bool {
        get{
            return _status
        }
        set{
            _status = newValue
        }
    }
    
}
