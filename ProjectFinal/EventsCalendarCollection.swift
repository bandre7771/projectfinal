//
//  EventsCalendarCollection.swift
//  ProjectFinal
//
//  Created by John Paul Young on 4/26/17.
//  Copyright © 2017 John Young. All rights reserved.
//

import Foundation

protocol EventsCalendarCollectionDelegate {
    func eventCreatedAtIndex(_ index: Int)
    func eventDeletedAtIndex(_ index: Int)
    func eventChangedAtIndex(_ index: Int)
}

class EventsCalendarCollection: EventDelegate {
    private var _events: [Event] = []
    
    private init() {
        let date = Date()
        
        let demoEvent1: Event = Event(title: "Demo Event", startHour: 8, startMinute: 0, endHour: 10, endMinute: 0, date: date)
        let demoEvent2: Event = Event(title: "Demo Event", startHour: 12, startMinute: 0, endHour: 14, endMinute: 0, date: date)
        let demoEvent3: Event = Event(title: "Demo Event", startHour: 16, startMinute: 0, endHour: 17, endMinute: 0, date: date)
        let demoEvent4: Event = Event(title: "Demo Event", startHour: 16, startMinute: 50, endHour: 19, endMinute: 0, date: date)
        
        _events.append(demoEvent1)
        _events.append(demoEvent2)
        _events.append(demoEvent3)
        _events.append(demoEvent4)
   }
    
    
    // MARK: - Public Variables
    public static let Instance: EventsCalendarCollection = EventsCalendarCollection()
    
    public var delegate: EventsCalendarCollectionDelegate? = nil
    
    public var count: Int {
        return _events.count
    }
    
    // MARK: - Public Methods
    public func createNewEvent(event: Event) {
        event.delegates.append(self)
        _events.append(event)
        delegate?.eventCreatedAtIndex(_events.count - 1)
    }
    
    public func deleteEventAtIndex(_ index: Int) {
        if(index >= 0 && index < _events.count) {
            _events.remove(at: index)
            delegate?.eventDeletedAtIndex(index)
        } else {
            NSLog("Could not remove event")
        }
    }
    
    public func eventAtIndex(_ index: Int) -> Event {
        return _events[index]
    }
    
    // MARK: - Persistence Methods
    public func load() {
        //TODO: Implement Persistance Load
    }
    public func save() {
        //TODO: Implement Persistance Save
    }
    
    // MARK: - EventDelegate Methods
    func eventChanged(_ event: Event) {
        let eventIndex: Int? = _events.index(where: {searchEvent in searchEvent === event})
        if eventIndex != nil {
            delegate?.eventChangedAtIndex(eventIndex!)
        }
    }
}
