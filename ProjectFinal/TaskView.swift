//
//  TaskView.swift
//  ProjectFinal
//
//  Created by Ben Andrews on 4/24/17.
//  Copyright © 2017 John Young. All rights reserved.
//

import UIKit

protocol TaskViewDelegate: class {
    func taskViewDelegate()
}

class TaskView: UIView, UITextFieldDelegate, UITextViewDelegate {

    private var _statusText: UILabel? = nil
    
    private var _task: Task? = nil
    private var _titletitleTextField: UITextField? = nil
    private var _dateLabel: UILabel? = nil
    private var _titleTextField: UITextField? = nil
    private var _groupTextField: UITextField? = nil
    private var _priorityTextField: UITextField? = nil
    private var _statusSwitch: UISwitch? = nil
    private var _noteTextView: UITextView? = nil
    
    weak var delegate: TaskViewDelegate? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        _task = Task()
        _task?.title = ""
        _task?.date = Date()
        _task?.group = ""
        _task?.priority = 0
        _task?.status = false
        _task?.notes.text = ""
        
        _titleTextField = UITextField(frame: CGRect(x: 10.0, y: 30.0, width: 100, height: 35))
        _titleTextField?.placeholder = "Title"
        _titleTextField?.keyboardType = UIKeyboardType.default
        _titleTextField?.returnKeyType = UIReturnKeyType.done
        _titleTextField?.clearButtonMode = UITextFieldViewMode.whileEditing
        _titleTextField?.backgroundColor = UIColor.white
        _titleTextField?.text = _task?.title
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.none
        dateFormatter.dateStyle = DateFormatter.Style.medium
        
        _dateLabel = UILabel()
        _dateLabel?.backgroundColor = UIColor.white
        _dateLabel?.text = dateFormatter.string(from: (_task?.date)!)
        _dateLabel?.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dateTapped))
        _dateLabel?.addGestureRecognizer(tapGesture)

        _groupTextField = UITextField(frame: CGRect(x: 10.0, y: 70.0, width: 100, height: 35))
        _groupTextField?.placeholder = "Group"
        _groupTextField?.keyboardType = UIKeyboardType.default
        _groupTextField?.returnKeyType = UIReturnKeyType.done
        _groupTextField?.clearButtonMode = UITextFieldViewMode.whileEditing
        _groupTextField?.backgroundColor = UIColor.white
        _groupTextField?.text = _task?.group
        
        _priorityTextField = UITextField(frame: CGRect(x: 10.0, y: 110.0, width: 100, height: 35))
        _priorityTextField?.placeholder = "Priority"
        _priorityTextField?.keyboardType = UIKeyboardType.default
        _priorityTextField?.returnKeyType = UIReturnKeyType.done
        _priorityTextField?.clearButtonMode = UITextFieldViewMode.whileEditing
        _priorityTextField?.backgroundColor = UIColor.white
        _priorityTextField?.text = _task?.priority.description
        
        _statusSwitch = UISwitch(frame: CGRect(x: 10, y: 150, width: 300, height: 250))
        _statusSwitch?.addTarget(self, action: #selector(statusChanged), for: .valueChanged)
        _statusSwitch?.setOn((_task?.status)!, animated: true)
        
        _statusText = UILabel(frame: CGRect(x: 70.0, y: 150.0, width: 100, height: 35))
        _statusText?.text = (_task?.status)! ? "Done" : "Not Done"
        _statusText?.textColor = UIColor.white
        
        _noteTextView = UITextView(frame: CGRect(x: 10.0, y: 190, width: 300, height: 250))
        _noteTextView?.keyboardType = UIKeyboardType.default
        _noteTextView?.returnKeyType = UIReturnKeyType.done
        _noteTextView?.text = _task?.notes.text
        
        _titleTextField?.delegate = self
        _groupTextField?.delegate = self
        _priorityTextField?.delegate = self
        _noteTextView?.delegate = self
        self.addSubview(_titleTextField!)
        self.addSubview(_dateLabel!)
        self.addSubview(_groupTextField!)
        self.addSubview(_priorityTextField!)
        self.addSubview(_statusSwitch!)
        self.addSubview(_statusText!)
        self.addSubview(_noteTextView!)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var r: CGRect = bounds
        (_titleTextField!.frame, r) = r.divided(atDistance: r.height*(1/10), from: .minYEdge)
        (_dateLabel!.frame, r) = r.divided(atDistance: r.height*(1/9), from: .minYEdge)
        (_groupTextField!.frame, r) = r.divided(atDistance: r.height*(1/8), from: .minYEdge)
        (_priorityTextField!.frame, r) = r.divided(atDistance: r.height*(1/7), from: .minYEdge)
        (_statusText!.frame, r) = r.divided(atDistance: r.height*(1/9), from: .minYEdge)
        (_statusSwitch!.frame, r) = r.divided(atDistance: r.height*(1/6), from: .minYEdge)
        (_noteTextView!.frame, r) = r.divided(atDistance: r.height, from: .minYEdge)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func refresh() {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.none
        dateFormatter.dateStyle = DateFormatter.Style.medium

        _titleTextField?.text = _task?.title
        _dateLabel?.text = dateFormatter.string(from: (_task?.date)!)
        _groupTextField?.text = _task?.group
        _priorityTextField?.text = _task?.priority.description
        _statusSwitch?.setOn((_task?.status)!, animated: true)
        _noteTextView?.text = _task?.notes.text
    }
    
    
    func dateTapped() {
        delegate?.taskViewDelegate()
    }
    
    // MARK: TextView Delegates
    func textViewDidEndEditing(_ textView: UITextView) {
        _task?.notes.text = textView.text
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
             _task?.title = textField.text!
        }
        else if textField.placeholder == "Date" {
            _task?.date = dateFormatter.date(from: textField.text!)!
        }
        else if textField.placeholder == "Group" {
            _task?.group = textField.text!
        }
        else if textField.placeholder == "Priority" {
            if Int(textField.text!) != nil && !(textField.text?.isEmpty)! {
                _task?.priority = Int(textField.text!)!
            }
        }
        else if textField.placeholder == "Status" {
            _task?.status = (textField.text! == "Done") ? true : false
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
            _task?.title = textField.text!
        }
        else if textField.placeholder == "Date" {
            _task?.date = dateFormatter.date(from: textField.text!)!
        }
        else if textField.placeholder == "Group" {
            _task?.group = textField.text!
        }
        else if textField.placeholder == "Priority" {
            if Int(textField.text!) != nil && !(textField.text?.isEmpty)! {
                _task?.priority = Int(textField.text!)!
            }
        }
        else if textField.placeholder == "Status" {
            _task?.status = (textField.text! == "Done") ? true : false
        }
        return true;
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("TextField should return method called")
        textField.resignFirstResponder();
        return true;
    }
    
    func statusChanged(mySwitch: UISwitch) {
        _task?.status = mySwitch.isOn
        _statusText?.text = (_task?.status)! ? "Done" : "Not Done"
    }
    
    // MARK - Public access vars
    public var task: Task {
        get{
            return _task!
        }
        set{
            _task = newValue
            refresh()
        }
    }
}
