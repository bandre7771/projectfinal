//
//  DailyNoteList.swift
//  ProjectFinal
//
//  Created by Ben Andrews on 4/19/17.
//  Copyright © 2017 John Young. All rights reserved.
//

import UIKit

class DailyNoteList {
    private var _dailyNoteList: [Note]
    
    init(noteList: [Note]) {
        _dailyNoteList = noteList
    }
    
    init() {
        _dailyNoteList = []
    }
    
    public func addDailyNote(note: Note) {
        _dailyNoteList.append(note)
    }
    
    public func removeDailyNote(at index: Int) {
        _dailyNoteList.remove(at: index)
    }
    
    public func searchNotes(word: String) {
        // TODO: add functionality for searching Daily notes for a string
    }
}
