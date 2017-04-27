//
//  Event.swift
//  ProjectFinal
//
//  Created by John Paul Young on 4/18/17.
//  Copyright © 2017 John Young. All rights reserved.
//

import Foundation
import CoreLocation

protocol EventDelegate {
    func eventChanged(_ event: Event)
}


class Event {
    private var _title: String? = nil
    private var _date: Date? = nil
    private var _startTime: TimeInterval? = nil
    private var _endTime: TimeInterval? = nil
    init() {
        _title = String()
        _startTime = TimeInterval()
        _endTime = TimeInterval()
        _date = Date()
    }
    
    init(title: String, startHour: Int, startMinute: Int, endHour: Int, endMinute: Int, date: Date) {
        _title = title
        _startTime = secondsFromTime(hours: startHour, minutes: startMinute)
        _endTime = secondsFromTime(hours: endHour, minutes: endMinute)
        _date = date
    }
    
    private var _startOfDay: Date {
        return NSCalendar.current.startOfDay(for: _date!)
    }
    
    private func secondsFromTime(hours: Int, minutes: Int) -> TimeInterval {
        return TimeInterval((hours * 60 + minutes) * 60)
    }

    public var start: Date? {
        return Date(timeInterval: _startTime!, since: _startOfDay)
    }
    
    public var end: Date? {
        return Date(timeInterval: _endTime!, since: _startOfDay)
    }
    
    public var delegates: [EventDelegate] = Array()

    
    public var title: String? {
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:mm a"
            let startTime = dateFormatter.string(from: start!)
            let endTime = dateFormatter.string(from: end!)
            return "\(_title!) \(startTime) - \(endTime)"
        }
        set {
            _title = newValue
        }
    }
    
    public var date: Date? {
        return _date
    }
    
    public var startTime: TimeInterval? {
        return _startTime
    }
    
    public var endTime: TimeInterval? {
        return _endTime
    }
    
    
    public var eventStartTimeInSeconds: TimeInterval {
        return TimeInterval(Calendar.current.dateComponents([.second], from: _startOfDay, to: start!).second!)
    }
    public var eventStartTimeInMinutes: TimeInterval {
        return eventStartTimeInSeconds / 60
    }
    public var eventLengthInSeconds: TimeInterval {
        return TimeInterval(Calendar.current.dateComponents([.second], from: start!, to: end!).second!)
    }
    public var eventLengthInMinutes: TimeInterval {
        return eventLengthInSeconds / 60
    }
    public var eventLengthInHours: TimeInterval {
        return eventLengthInMinutes / 60
    }
    public var eventLengthInDays: TimeInterval {
        return eventLengthInHours / 24
    }
}
