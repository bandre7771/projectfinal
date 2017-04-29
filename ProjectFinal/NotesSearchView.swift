//
//  NotesSearchView.swift
//  ProjectFinal
//
//  Created by John Paul Young on 4/28/17.
//  Copyright © 2017 John Young. All rights reserved.
//

import UIKit

class NotesSearchView: UIView {
    private var _searchBarView: SearchBarView? = nil
    private var _noteListTableView: NotesListTableView? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        _searchBarView = SearchBarView()
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
}
