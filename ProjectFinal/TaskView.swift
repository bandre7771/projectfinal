//
//  TaskView.swift
//  ProjectFinal
//
//  Created by Ben Andrews on 4/24/17.
//  Copyright © 2017 John Young. All rights reserved.
//

import UIKit

class TaskView: UIView, UITextFieldDelegate, UITextViewDelegate{
//    private var _title: String
//    private var _date: Date
//    private var _group: String
//    private var _priority: Int
//    private var _status: Bool
//    private var _note: String
    private var _statusText: UILabel
    
    private var _task: Task
    
    override init(frame: CGRect) {
        _task = Task()
        _task.title = ""
        _task.date = Date()
        _task.group = ""
        _task.priority = 0
        _task.status = false
        _task.notes.text = ""
        _statusText = UILabel()
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
        titleTextField.text = _task.title
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.none
        dateFormatter.dateStyle = DateFormatter.Style.medium
        
        let dateTextField: UITextField = UITextField(frame: CGRect(x: 170.0, y: 30, width: 130, height: 35))
        dateTextField.placeholder = "Date"
        dateTextField.keyboardType = UIKeyboardType.default
        dateTextField.returnKeyType = UIReturnKeyType.done
        dateTextField.clearButtonMode = UITextFieldViewMode.whileEditing
        dateTextField.borderStyle = UITextBorderStyle.roundedRect
        dateTextField.text = dateFormatter.string(from: _task.date)
        
        
        let groupTextField: UITextField = UITextField(frame: CGRect(x: 10.0, y: 70.0, width: 100, height: 35))
        groupTextField.placeholder = "Group"
        groupTextField.keyboardType = UIKeyboardType.default
        groupTextField.returnKeyType = UIReturnKeyType.done
        groupTextField.clearButtonMode = UITextFieldViewMode.whileEditing
        groupTextField.borderStyle = UITextBorderStyle.roundedRect
        groupTextField.text = _task.group
        
        let priorityTextField: UITextField = UITextField(frame: CGRect(x: 10.0, y: 110.0, width: 100, height: 35))
        priorityTextField.placeholder = "Priority"
        priorityTextField.keyboardType = UIKeyboardType.default
        priorityTextField.returnKeyType = UIReturnKeyType.done
        priorityTextField.clearButtonMode = UITextFieldViewMode.whileEditing
        priorityTextField.borderStyle = UITextBorderStyle.roundedRect
        priorityTextField.text = _task.priority.description
        
        let statusSwitch: UISwitch = UISwitch(frame: CGRect(x: 10.0, y: 150.0, width: 40, height: 35))
        statusSwitch.addTarget(self, action: #selector(statusChanged), for: .valueChanged)
        statusSwitch.setOn(_task.status, animated: true)
        
        _statusText = UILabel(frame: CGRect(x: 70.0, y: 150.0, width: 100, height: 35))
        _statusText.text = _task.status ? "Done" : "Not Done"
        _statusText.textColor = UIColor.white
//        let statusTextField: UITextField = UITextField(frame: CGRect(x: 10.0, y: 150.0, width: 100, height: 35))
//        statusTextField.placeholder = "Status"
//        statusTextField.keyboardType = UIKeyboardType.default
//        statusTextField.returnKeyType = UIReturnKeyType.done
//        statusTextField.clearButtonMode = UITextFieldViewMode.whileEditing
//        statusTextField.borderStyle = UITextBorderStyle.roundedRect
//        let statusText = _status ? "Done" : "Not Done"
//        statusTextField.text = statusText
        
        let noteTextView: UITextView = UITextView(frame: CGRect(x: 10.0, y: 190, width: 300, height: 250))
        noteTextView.keyboardType = UIKeyboardType.default
        noteTextView.returnKeyType = UIReturnKeyType.done
        noteTextView.text = _task.notes.text
//        noteTextView.contentVerticalAlignment = UIControlContentVerticalAlignment.top
        
        
        titleTextField.delegate = self
        dateTextField.delegate = self
        groupTextField.delegate = self
        priorityTextField.delegate = self
        //statusTextField.delegate = self
        noteTextView.delegate = self
        self.addSubview(titleTextField)
        self.addSubview(dateTextField)
        self.addSubview(groupTextField)
        self.addSubview(priorityTextField)
        self.addSubview(statusSwitch)
        self.addSubview(_statusText)
        self.addSubview(noteTextView)
    }
    
    
    // MARK: TextView Delegates
    func textViewDidEndEditing(_ textView: UITextView) {
        _task.notes.text = textView.text
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
             _task.title = textField.text!
        }
        else if textField.placeholder == "Date" {
            _task.date = dateFormatter.date(from: textField.text!)!
        }
        else if textField.placeholder == "Group" {
            _task.group = textField.text!
        }
        else if textField.placeholder == "Priority" {
            _task.priority = Int(textField.text!)!
        }
        else if textField.placeholder == "Status" {
            _task.status = (textField.text! == "Done") ? true : false
        }
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
        print("TextField should end editing method called")
        return true;
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("While entering the characters this method gets called")
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.none
        dateFormatter.dateStyle = DateFormatter.Style.medium
        
        if textField.placeholder == "Title" {
            _task.title = textField.text!
        }
        else if textField.placeholder == "Date" {
            _task.date = dateFormatter.date(from: textField.text!)!
        }
        else if textField.placeholder == "Group" {
            _task.group = textField.text!
        }
        else if textField.placeholder == "Priority" {
            _task.priority = Int(textField.text!)!
        }
        else if textField.placeholder == "Status" {
            _task.status = (textField.text! == "Done") ? true : false
        }
        return true;
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("TextField should return method called")
        textField.resignFirstResponder();
        return true;
    }
    
    func statusChanged(mySwitch: UISwitch) {
        _task.status = mySwitch.isOn
        _statusText.text = _task.status ? "Done" : "Not Done"
    }
    
    // MARK - Public access vars
    public var task: Task {
        get{
            return _task
        }
        set{
            _task = newValue
        }
    }
//    public var title: String {
//        get{
//            return _title
//        }
//        set{
//            _title = newValue
//        }
//    }
//    
//    public var date: Date {
//        get{
//            return _date
//        }
//        set{
//            _date = newValue
//        }
//    }
//    
//    public var group: String {
//        get{
//            return _group
//        }
//        set{
//            _group = newValue
//        }
//    }
//    
//    public var priority: Int {
//        get{
//            return _priority
//        }
//        set{
//            _priority = newValue
//        }
//    }
//    
//    public var status: Bool {
//        get{
//            return _status
//        }
//        set{
//            _status = newValue
//        }
//    }
//    
//    public var note: String {
//        get{
//            return _note
//        }
//        set{
//            _note = newValue
//        }
//    }
    
}
