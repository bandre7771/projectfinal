//
//  Note.swift
//  ProjectFinal
//
//  Created by Ben Andrews on 4/19/17.
//  Copyright © 2017 John Young. All rights reserved.
//

import UIKit

class Note {
    private var _text: String
    private var _date: Date
    
    init(text: String, date: Date) {
        _text = text
        _date = date
    }
    
    init(){
        _text = ""
        _date = Date()
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
