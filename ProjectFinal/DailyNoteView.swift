//
//  DailyNoteView.swift
//  ProjectFinal
//
//  Created by John Paul Young on 4/29/17.
//  Copyright © 2017 John Young. All rights reserved.
//

import UIKit

protocol DailyNoteViewDelegate: class {
    func noteViewTapped()
}

class DailyNoteView: UIView {
    
    private var _textView: UILabel? = nil
    private var _selfRect: CGRect? = nil
    
    public var delegate: DailyNoteViewDelegate? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        autoresizesSubviews = true
        _textView = UILabel()
        _textView?.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        _textView?.translatesAutoresizingMaskIntoConstraints = false
        _textView?.backgroundColor = UIColor.white
        _textView?.text = "Tap Here to Add Note"
        _textView?.adjustsFontSizeToFitWidth = true
        _textView?.numberOfLines = 0
        addSubview(_textView!)
        let views: [String : UIView] = ["textView": _textView!]
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[textView]-|", options: .alignAllCenterX, metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[textView]-|", options: .alignAllCenterY, metrics: nil, views: views))
        _selfRect = CGRect.zero
        backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let context: CGContext = UIGraphicsGetCurrentContext()!
        _selfRect = bounds
        context.move(to: (_selfRect?.origin)!)
        context.addLine(to: CGPoint(x: (_selfRect?.maxX)!, y: (_selfRect?.minY)!))
        context.setStrokeColor(UIColor.gray.cgColor)
        context.setLineWidth(1)
        context.drawPath(using: .stroke)
    }
    
    public var text: String {
        get {
            return (_textView?.text)!
        } set {
            var result = newValue
            if result.isEmpty {
                result = "Tap Here to Add Note"
                _textView?.textColor = UIColor.lightGray
            } else {
                _textView?.textColor = UIColor.black
            }
            _textView?.text = result
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch = touches.first!
        let touchPoint = touch.location(in: self)
        if (bounds.contains(touchPoint)) {
            delegate?.noteViewTapped()
            NSLog("Tapped note")
        }
    }
}
