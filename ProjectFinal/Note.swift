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
    private let _date: Date
    
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
}
