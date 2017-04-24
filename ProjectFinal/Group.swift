//
//  Group.swift
//  ProjectFinal
//
//  Created by Ben Andrews on 4/19/17.
//  Copyright © 2017 John Young. All rights reserved.
//

import UIKit

class Group {
    private var _name: String
    
    init(name: String) {
        _name = name
    }
    
    init() {
        _name = ""
    }
    
    // MARK - Public Accessible Variables
    public var name: String {
        get{
            return name
        }
        set{
            _name = name
        }
    }
}
