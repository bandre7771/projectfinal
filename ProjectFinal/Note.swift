//
//  Note.swift
//  ProjectFinal
//
//  Created by Ben Andrews on 4/19/17.
//  Copyright © 2017 John Young. All rights reserved.
//

import UIKit

protocol NoteDelegate {
    func noteChanged(_ note: Note)
}


class Note {
    private var _text: String
    private var _date: Date
    
    public var delegates: [NoteDelegate]? = nil
    
    init(text: String, date: Date) {
        _text = text
        _date = date
        delegates = []
    }
    
    init(){
        _text = ""
        _date = Date()
        delegates = []
    }
    
    // MARK - Public Accessible Variables
    public var text: String {
        get{
            return _text
        }
        set{
            _text = newValue
        }
    }
    
    public var date: Date {
        get {
            return _date
        }
    }
}

extension Note: Comparable {
    
    static func == (lhs: Note, rhs: Note) -> Bool {
        return lhs.date == rhs.date && lhs.text == lhs.text
    }
    
    static func < (lhs: Note, rhs: Note) -> Bool {
        return lhs.date < rhs.date ||
            (lhs.date == rhs.date && lhs.text < rhs.text)
    }
    
    static func >(lhs: Note, rhs: Note) -> Bool {
        return lhs.date > rhs.date ||
            (lhs.date == rhs.date && lhs.text > rhs.text)
    }

}
