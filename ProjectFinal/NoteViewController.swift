//
//  NoteViewController.swift
//  ProjectFinal
//
//  Created by John Paul Young on 4/29/17.
//  Copyright © 2017 John Young. All rights reserved.
//

import UIKit

protocol NoteViewControllerDelegate: class {
    func noteViewController(save note: Note)
}

class NoteViewController: UIViewController {
    private var _currentNote: Note? = nil
    
    public var delegate: NoteViewControllerDelegate? = nil
    
    init(Note: Note) {
        super.init(nibName: nil, bundle: nil)
        _currentNote = Note
        noteView.text = Note.text
        edgesForExtendedLayout = []
        title = noteMonthDayYear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public var noteView: NoteView {
        return view as! NoteView
    }
    
    override func loadView() {
        view = NoteView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Perform any additional setup after loading the view, typically from a nib.
        let save: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveNote))
        navigationItem.rightBarButtonItem = save
    }
    
    public func saveNote(){
        _currentNote?.text = noteView.text
        delegate?.noteViewController(save: _currentNote!) // To pop view off
    }
    
    private var noteMonthDayYear: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd YYYY"
        let monthDayYear: String = dateFormatter.string(from: (_currentNote?.date)!)
        return monthDayYear
    }
}
