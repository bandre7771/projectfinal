//
//  CalendarCollectionViewController.swift
//  ProjectFinal
//
//  Created by John Paul Young on 4/22/17.
//  Copyright © 2017 John Young. All rights reserved.
//

import UIKit

class CalendarCollectionViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    private var _collectionViewFlowLayout: UICollectionViewFlowLayout? = nil
    private var _cellSize: CGSize? = nil
    private var _sectionInset: UIEdgeInsets? = nil
    
    init() {
        super.init(nibName: nil, bundle: nil)
        _collectionViewFlowLayout = UICollectionViewFlowLayout()
        _sectionInset = UIEdgeInsets()
        _cellSize = CGSize.zero
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    }

    private var collectionView: UICollectionView {
        return view as! UICollectionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "DayView"
        
        _collectionViewFlowLayout = UICollectionViewFlowLayout()
        _sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 75, right: 20)
        _collectionViewFlowLayout?.sectionInset = _sectionInset!
        _collectionViewFlowLayout?.scrollDirection = UICollectionViewScrollDirection.vertical
        _cellSize = CGSize(width: 100, height: 100)
        _collectionViewFlowLayout?.itemSize = _cellSize!
        
        view = UICollectionView(frame: self.view.frame, collectionViewLayout: _collectionViewFlowLayout!)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(EventCell.self, forCellWithReuseIdentifier: String(describing: EventCell.self))
        collectionView.backgroundColor = UIColor.white
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        NSLog("\(indexPath.item): clicked")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2 // TODO: Return event count for current day
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: EventCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: EventCell.self), for: indexPath) as! EventCell
        let event: Event = Event()
        if(indexPath.item == 0){
            cell.setSelected(selected: true)
        }
        event.title = "Title \(indexPath.item)"
        cell.setEvents(event: event)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath)  -> CGSize {
        _cellSize?.width = collectionView.bounds.width
        var cellSize: CGSize = _cellSize!
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return _sectionInset!
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
}
