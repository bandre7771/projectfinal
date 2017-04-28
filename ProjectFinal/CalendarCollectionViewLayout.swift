//
//  CalendarCollectionViewLayout.swift
//  ProjectFinal
//
//  Created by John Paul Young on 4/24/17.
//  Copyright © 2017 John Young. All rights reserved.
//

import UIKit

protocol CalendarCollectionViewLayoutDelegate: class {
    func collectionView(_ collectionView: UICollectionView, heightForItemAt indexPath: IndexPath) -> CGFloat
    func collectionView(_ collectionView: UICollectionView, yOriginForItemAt indexPath: IndexPath) -> CGFloat
}


class CalendarCollectionViewLayout: UICollectionViewLayout {
    override init() {
        super.init()
        let nib: UINib = UINib(nibName: "TimeRowHeader", bundle: nil)
        register(nib, forDecorationViewOfKind: String(describing: TimeRowHeader.self))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    weak var delegate: CalendarCollectionViewLayoutDelegate? = nil
    
    var numberOfColumns: Int = 1
    
    private var _cache = [CalendarCollectionViewLayoutAttributes]()
   
    private var _width: CGFloat {
        get {
            return (collectionView?.bounds.width)!
        }
    }
    
    override class var layoutAttributesClass: AnyClass {
        return CalendarCollectionViewLayoutAttributes.self as AnyClass
    }
    
    override var collectionViewContentSize: CGSize {
        let minutesInADay: CGFloat = 1440
        return CGSize(width: _width, height: minutesInADay)
    }
    
    override func prepare() {
        if _cache.isEmpty {
            let leftOffset: CGFloat = 25
            let columnWidth = (_width / CGFloat(numberOfColumns)) - leftOffset
            
            var xOffsets: [CGFloat] = [CGFloat].init()
            for column in 0..<numberOfColumns {
                xOffsets.append((CGFloat(column) * columnWidth) + leftOffset)
                
            }
            var column = 0
            for item in 0..<(collectionView?.numberOfItems(inSection: 0))! {
                let indexPath: IndexPath = IndexPath(item: item, section: 0)
                let height: CGFloat = (delegate?.collectionView(collectionView!, heightForItemAt: indexPath))!
                let yOrigin: CGFloat = (delegate?.collectionView(collectionView!, yOriginForItemAt: indexPath))!
                let frame: CGRect = CGRect(x: xOffsets[column], y: yOrigin, width: columnWidth, height: height)
                let attributes = CalendarCollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = frame
                attributes.eventHeight = height
                attributes.eventYOrigin = yOrigin
                _cache.append(attributes)
                column = column >= (numberOfColumns - 1) ? 0 : column + 1
            }
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes: [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes].init()
        for attributes in _cache {
            if attributes.frame.intersects(rect) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }
}

class CalendarCollectionViewLayoutAttributes: UICollectionViewLayoutAttributes {
    var eventHeight: CGFloat = 0
    var eventYOrigin: CGFloat = 0
    override func copy(with zone: NSZone? = nil) -> Any {
        let copy = super.copy(with: zone) as! CalendarCollectionViewLayoutAttributes
        copy.eventHeight = eventHeight
        copy.eventYOrigin = eventYOrigin
        return copy
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        if let attributes = object as? CalendarCollectionViewLayoutAttributes {
            if attributes.eventHeight == eventHeight && attributes.eventYOrigin == eventYOrigin {
                return super.isEqual(object)
            }
        }
        return false
    }
}
