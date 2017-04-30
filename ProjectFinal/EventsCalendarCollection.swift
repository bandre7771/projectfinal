//
//  EventsCalendarCollection.swift
//  ProjectFinal
//
//  Created by John Paul Young on 4/26/17.
//  Copyright © 2017 John Young. All rights reserved.
//

import Foundation


class EventsCalendarCollection: EventDelegate {
    private var _eventsToDisplay: [Event] = []
    private var _dailyDictionary: [Date : [Event]] = [Calendar.current.startOfDay(for: Date()): [Event(title: "Demo Event", startHour: 4, startMinute: 0, endHour: 8, endMinute: 0, date: Date()),
                                                        Event(title: "Demo Event", startHour: 12, startMinute: 0, endHour: 14, endMinute: 0, date: Date()),
                                                        Event(title: "Demo Event", startHour: 16, startMinute: 0, endHour: 17, endMinute: 0, date: Date()),
                                                        Event(title: "Demo Event", startHour: 16, startMinute: 50, endHour: 19, endMinute: 0, date: Date())]]
    private init() {
        for (_,value) in _dailyDictionary {
            for event in value {
                _eventsToDisplay.append(event)
            }
        }
    }

    // MARK: - Public Variables
    public static let Instance: EventsCalendarCollection = EventsCalendarCollection()

    public var count: Int {
        return _eventsToDisplay.count
    }

    // MARK: - Public Methods
    public func createNewEvent(event: Event) {
        //event.delegates.append(self)
        _eventsToDisplay.append(event)
        //delegate?.eventCreatedAtIndex(_events.count - 1)
    }

    public func deleteEventAtIndex(_ index: Int) {
        if(index >= 0 && index < _eventsToDisplay.count) {
            _eventsToDisplay.remove(at: index)
        //delegate?.eventDeletedAtIndex(index)
        } else {
            NSLog("Could not remove event")
        }
    }

    public func eventAtIndex(_ index: Int) -> Event {
        return _eventsToDisplay[index]
    }
    
    public func getAllEventsForCurrentDay() -> [Event] {
        return _eventsToDisplay
    }

    public func currentDayChanged(to date: Date) {
        _eventsToDisplay.removeAll()
        let start = Calendar.current.startOfDay(for: date)
        if _dailyDictionary[start] != nil {
            for event in _dailyDictionary[start]! {
                _eventsToDisplay.append(event)
            }
        }
    }
    
    // MARK: - EventDelegate Methods
    func eventChanged(_ event: Event) {
        let eventIndex: Int? = _eventsToDisplay.index(where: {searchEvent in searchEvent === event})
        if eventIndex != nil {
//            delegate?.eventChangedAtIndex(eventIndex!)
        }
    }
}
