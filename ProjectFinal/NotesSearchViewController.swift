//
//  NotesSearchViewController.swift
//  ProjectFinal
//
//  Created by John Paul Young on 4/28/17.
//  Copyright © 2017 John Young. All rights reserved.
//

import UIKit

class NotesSearchViewController: UIViewController, UserInfoDelegate, NotesSearchViewDelegate, NoteViewControllerDelegate {
    
    private var _currentSearch: [Note]? = nil
    
    init() {
        super.init(nibName: "DayCompositViewController", bundle: nil)
        UserInfo.Instance.delegateNotesSearch = self
        self.edgesForExtendedLayout = []
        _currentSearch = []
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var notesSearchView: NotesSearchView {
        return view as! NotesSearchView
    }
    
    override func loadView() {
        view = NotesSearchView()
        refresh()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Notes"
        notesSearchView.delegate = self
        _currentSearch = UserInfo.Instance.notes
        refresh()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (UserInfo.Instance.searchViewTutorial) {
            let alert = UIAlertController(title: "Notes", message: "This page allows you to search through your daily notes and edit them as you please. To add a new note, tap the note preview displayed at the bottom of the day view inside the day tab", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Got it!", style: UIAlertActionStyle.default, handler: {(action: UIAlertAction) in ()}))
            self.present(alert, animated: true, completion: nil)
            UserInfo.Instance.searchViewTutorial = false
        }
    }
    
    public func refresh() {
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = UIColor.white
        let clearSearch = UIBarButtonItem(title: "Clear Search", style: .plain, target: self, action: #selector(clearCurrentSearch))
        navigationItem.rightBarButtonItem = clearSearch
        notesSearchView.updateSearch(to: _currentSearch!)
    }
    
    // Private search related methods
    private func currentSearchChanged(to search: String) {
        _currentSearch?.removeAll()
        let lowerCaseSearch: String = search.lowercased()
        if !lowerCaseSearch.isEmpty {
            for note in UserInfo.Instance.notes {
                let lowerCaseNoteText: String = note.text.lowercased()
                if lowerCaseNoteText.contains(lowerCaseSearch) {
                    _currentSearch?.append(note)
                }
            }
            refresh()
        } else {
            clearCurrentSearch()
        }
    }
    
    @objc private func clearCurrentSearch() {
        _currentSearch = UserInfo.Instance.notes
        refresh()
    }

    // MARK: NoteSearchViewDelegateMethods
    func noteSearchView(to search: String) {
        currentSearchChanged(to: search)
    }
    
    func noteSearchView(updated note: Note) {
        let noteViewController: NoteViewController = NoteViewController(Note: note)
        noteViewController.delegate = self
        navigationController?.pushViewController(noteViewController , animated: true)
    }
    
    // MARK: UserInfoDelegate Methods
    func taskListUpdated() {}
    func notesListChanged(_ notes: [Note]) {
        _currentSearch = UserInfo.Instance.notes
         refresh()
    }

    // MARK: NoteViewControllerDelegate Methods
    func noteViewController(save note: Note) {
        UserInfo.Instance.addOrUpdateNote(note)
        navigationController?.popViewController(animated: true)
        refresh()
    }
}
