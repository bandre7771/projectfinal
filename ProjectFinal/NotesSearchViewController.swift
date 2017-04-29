//
//  NotesSearchViewController.swift
//  ProjectFinal
//
//  Created by John Paul Young on 4/28/17.
//  Copyright © 2017 John Young. All rights reserved.
//

import UIKit

class NotesSearchViewController: UIViewController, UserInfoDelegate, NotesSearchViewDelegate {
    
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
    
    public func refresh() {
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = UIColor.white
        let clearSearch = UIBarButtonItem(title: "Clear Search", style: .plain, target: self, action: #selector(clearCurrentSearch))
        navigationItem.rightBarButtonItem = clearSearch
        notesSearchView.updateSearch(to: _currentSearch!)
    }
    
    // Private search releated methods
    private func currentSearchChanged(to search: String) {
        _currentSearch?.removeAll()
        // TODO: Add regex
        for note in UserInfo.Instance.notes {
            let lowerCaseNoteText: String = note.text.lowercased()
            let lowerCaseSearch: String = search.lowercased()
            if lowerCaseNoteText.contains(lowerCaseSearch) {
                _currentSearch?.append(note)
            }
        }
        refresh()
    }
    @objc private func clearCurrentSearch() {
        _currentSearch = UserInfo.Instance.notes
        refresh()
    }

    // MARK: NoteSearchViewDelegateMethods
    func noteSearchView(to search: String) {
        currentSearchChanged(to: search)
    }
    
    // MARK: UserInfoDelegate Methods
    func currentDayChanged(to date: Date) {}
    func taskListUpdated() {}
    func notesListChanged(_ notes: [Note]) { refresh() }
}
