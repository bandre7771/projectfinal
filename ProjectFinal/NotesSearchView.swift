//
//  NotesSearchView.swift
//  ProjectFinal
//
//  Created by John Paul Young on 4/28/17.
//  Copyright © 2017 John Young. All rights reserved.
//

import UIKit

protocol NotesSearchViewDelegate: class {
    func noteSearchView(to search: String)
}

class NotesSearchView: UIView, SearchBarViewDelegate {
    private var _searchBarView: SearchBarView? = nil
    private var _noteListTableView: NotesListTableView? = nil
    
    weak var delegate: NotesSearchViewDelegate? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        _searchBarView = SearchBarView()
        _searchBarView?.delegate = self
        addSubview(_searchBarView!)
        
        _noteListTableView = NotesListTableView()
        addSubview(_noteListTableView!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var r: CGRect = bounds
        (_searchBarView!.frame, r) = r.divided(atDistance: r.height*0.08, from: .minYEdge)
        (_noteListTableView!.frame, r) = r.divided(atDistance: r.height, from: .minYEdge)
    }
    
    public func updateSearch(to notes: [Note]) {
        _noteListTableView?.notes = notes.sorted(by: >)
    }
    
    func searchBarView(to search: String) {
        delegate?.noteSearchView(to: search)
        NSLog("Current note search: \(search)")
    }
}
