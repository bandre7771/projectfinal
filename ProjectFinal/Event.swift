//
//  Event.swift
//  ProjectFinal
//
//  Created by John Paul Young on 4/18/17.
//  Copyright © 2017 John Young. All rights reserved.
//

import Foundation
import CoreLocation

class Event {
    var start: Date? = nil
    var title: String? = nil
    var date: Date?
    var time: Date?
    
    var day: Date {
        return NSCalendar.current.startOfDay(for: self.start!)
    }
    
}
