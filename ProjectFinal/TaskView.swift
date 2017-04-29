//
//  TaskView.swift
//  ProjectFinal
//
//  Created by Ben Andrews on 4/24/17.
//  Copyright © 2017 John Young. All rights reserved.
//

import UIKit
protocol TaskViewDelegate: class {
    func taskUpdated()
}

class TaskView: UIView, UITextFieldDelegate, UITextViewDelegate{
    private var _title: String
    private var _date: Date
    private var _group: String
    private var _priority: Int
    private var _status: Bool
    private var _note: String
    
    override init(frame: CGRect) {
        
        _title = ""
        _date = Date()
        _group = ""
        _priority = 0
        _status = false
        _note = ""
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect){
        let titleTextField: UITextField = UITextField(frame: CGRect(x: 10.0, y: 30.0, width: 100, height: 35))
        titleTextField.placeholder = "Title"
        titleTextField.keyboardType = UIKeyboardType.default
        titleTextField.returnKeyType = UIReturnKeyType.done
        titleTextField.clearButtonMode = UITextFieldViewMode.whileEditing
        titleTextField.borderStyle = UITextBorderStyle.roundedRect
        titleTextField.text = _title
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.none
        dateFormatter.dateStyle = DateFormatter.Style.medium
        
        let dateTextField: UITextField = UITextField(frame: CGRect(x: 170.0, y: 30, width: 130, height: 35))
        dateTextField.placeholder = "Date"
        dateTextField.keyboardType = UIKeyboardType.default
        dateTextField.returnKeyType = UIReturnKeyType.done
        dateTextField.clearButtonMode = UITextFieldViewMode.whileEditing
        dateTextField.borderStyle = UITextBorderStyle.roundedRect
        dateTextField.text = dateFormatter.string(from: _date)
        
        
        let groupTextField: UITextField = UITextField(frame: CGRect(x: 10.0, y: 70.0, width: 100, height: 35))
        groupTextField.placeholder = "Group"
        groupTextField.keyboardType = UIKeyboardType.default
        groupTextField.returnKeyType = UIReturnKeyType.done
        groupTextField.clearButtonMode = UITextFieldViewMode.whileEditing
        groupTextField.borderStyle = UITextBorderStyle.roundedRect
        groupTextField.text = _group
        
        let priorityTextField: UITextField = UITextField(frame: CGRect(x: 10.0, y: 110.0, width: 100, height: 35))
        priorityTextField.placeholder = "Priority"
        priorityTextField.keyboardType = UIKeyboardType.default
        priorityTextField.returnKeyType = UIReturnKeyType.done
        priorityTextField.clearButtonMode = UITextFieldViewMode.whileEditing
        priorityTextField.borderStyle = UITextBorderStyle.roundedRect
        priorityTextField.text = _priority.description
        
        
        let statusTextField: UITextField = UITextField(frame: CGRect(x: 10.0, y: 150.0, width: 100, height: 35))
        statusTextField.placeholder = "Status"
        statusTextField.keyboardType = UIKeyboardType.default
        statusTextField.returnKeyType = UIReturnKeyType.done
        statusTextField.clearButtonMode = UITextFieldViewMode.whileEditing
        statusTextField.borderStyle = UITextBorderStyle.roundedRect
        let statusText = _status ? "Done" : "Not Done"
        statusTextField.text = statusText
        
        let noteTextView: UITextView = UITextView(frame: CGRect(x: 10.0, y: 190, width: 300, height: 250))
        noteTextView.keyboardType = UIKeyboardType.default
        noteTextView.returnKeyType = UIReturnKeyType.done
        noteTextView.text = _note
//        noteTextView.contentVerticalAlignment = UIControlContentVerticalAlignment.top
        
        
        titleTextField.delegate = self
        dateTextField.delegate = self
        groupTextField.delegate = self
        priorityTextField.delegate = self
        statusTextField.delegate = self
        noteTextView.delegate = self
        self.addSubview(titleTextField)
        self.addSubview(dateTextField)
        self.addSubview(groupTextField)
        self.addSubview(priorityTextField)
        self.addSubview(statusTextField)
        self.addSubview(noteTextView)
    }
    
    weak var delegate: TaskViewDelegate? = nil
    
    // MARK: TextView Delegates
    func textViewDidEndEditing(_ textView: UITextView) {
        _note = textView.text
        delegate?.taskUpdated()
    }
    
    // MARK: Textfield Delegates
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("TextField did begin editing method called")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("TextField did end editing method called")
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.none
        dateFormatter.dateStyle = DateFormatter.Style.medium
        
        if textField.placeholder == "Title" {
             _title = textField.text!
        }
        else if textField.placeholder == "Date" {
            _date = dateFormatter.date(from: textField.text!)!
        }
        else if textField.placeholder == "Group" {
            _group = textField.text!
        }
        else if textField.placeholder == "Priority" {
            _priority = Int(textField.text!)!
        }
        else if textField.placeholder == "Status" {
            _status = (textField.text! == "Done") ? true : false
        }
        
        delegate?.taskUpdated()
        
//        switch textField.placeholder {
//        case "Title":
//            _title = textField.text!
//        case "Date":
//            _date = dateFormatter.date(from: textField.text!)!
//        case "Group":
//            _group.name = textField.text!
//        case "Priority":
//            _priority = Int(textField.text!)!
//        case "Status":
//            _status = (textField.text! == "Done") ? true : false
//        default:
//            break
//        }
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
    
    public var group: String {
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
    
    public var note: String {
        get{
            return _note
        }
        set{
            _note = newValue
        }
    }
    
}
