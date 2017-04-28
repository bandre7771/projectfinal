//
//  CalendarCollectionView.swift
//  ProjectFinal
//
//  Created by John Paul Young on 4/22/17.
//  Copyright © 2017 John Young. All rights reserved.
//

import UIKit

class CalendarCollectionView: UICollectionView, UICollectionViewDataSource, CalendarCollectionViewLayoutDelegate {
    private var _cellSize: CGSize? = nil
    private var _sectionInset: UIEdgeInsets? = nil
    private var _calendarCollectionViewLayout: CalendarCollectionViewLayout? = nil
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        _calendarCollectionViewLayout = CalendarCollectionViewLayout()
        _calendarCollectionViewLayout?.numberOfColumns = 1
        super.init(frame: frame, collectionViewLayout: _calendarCollectionViewLayout!)
        _calendarCollectionViewLayout?.delegate = self
        _sectionInset = UIEdgeInsets()
        _cellSize = CGSize.zero
        _calendarCollectionViewLayout = CalendarCollectionViewLayout()
        dataSource = self
        register(EventCell.self, forCellWithReuseIdentifier: String(describing: EventCell.self))
        backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return EventsCalendarCollection.Instance.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: EventCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: EventCell.self), for: indexPath) as! EventCell
        let event: Event = EventsCalendarCollection.Instance.eventAtIndex(indexPath.row)
        cell.setEvents(event: event)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, heightForItemAt indexPath: IndexPath) -> CGFloat {
        let event = EventsCalendarCollection.Instance.eventAtIndex(indexPath.row)
        return CGFloat(event.eventLengthInMinutes)
    }
    func collectionView(_ collectionView: UICollectionView, yOriginForItemAt indexPath: IndexPath) -> CGFloat {
        let event = EventsCalendarCollection.Instance.eventAtIndex(indexPath.row)
        return CGFloat(event.eventStartTimeInMinutes)
    }
    
}
