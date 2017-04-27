//
//  UICollectionReusableViews
//  ProjectFinal
//
//  Created by John Paul Young on 4/18/17.
//  Copyright © 2017 John Young. All rights reserved.
//
//  References https://cocoapods.org/?q=MS%20CALENDAR MS CALENDAREXAMPLE by Eric Horacek on 2/26/13 this is a objective-c to swift conversion.

import UIKit

class TimeRowHeader: UICollectionReusableView {
    private var _title: UILabel? = nil
    private var _time: Date? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self._title = UILabel()
        self._title?.backgroundColor = UIColor.clear
        self._title?.font = UIFont.systemFont(ofSize: 12.0)
        self._title?.text = "No Title"
        self.addSubview(self._title!)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self._title?.frame.origin.y = self.frame.midY - (_title?.frame.height)!/2 //Center on Y axis
        self._title?.frame.origin.x = self.frame.maxX - ((_title?.frame.width)! + 5.0)
    }
    
    func setTime(time: Date) {
        _time = time
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h a"
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US") as Locale!
        self._title?.text = dateFormatter.string(from: time)
        self.setNeedsLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class EventCell: UICollectionViewCell {
    private var _title: UILabel? = nil
    private var _location: UILabel? = nil
    private var _borderView: UIView? = nil
    private var _event: Event? = nil
    
    private var _borderColor: UIColor {
        let color: UIColor = self.backgroundColorHighlighted(selected: false)
        color.withAlphaComponent(1.0)
        return color
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.rasterizationScale = UIScreen.main.scale
        self.layer.shouldRasterize = true
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        self.layer.shadowRadius = 5.0
        self.layer.shadowOpacity = 0.0
        
        self._title = UILabel()
        self._title?.numberOfLines = 0
        self._title?.lineBreakMode = NSLineBreakMode.byWordWrapping
        self._title?.backgroundColor = UIColor.clear
        self.contentView.addSubview(self._title!)
        
        self._event = Event()
        
        self.updateColors()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        _title?.frame.origin = bounds.origin
        _title?.frame.origin.y = bounds.minY + 10
        _title?.frame.origin.x = bounds.minX + 10
        _title?.sizeToFit()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSelected(selected: Bool) {
        if(selected && (self.isSelected != selected)) {
            UIView.animate(withDuration: 0.1, animations: { () -> Void in
                                                            self.transform = CGAffineTransform.init(scaleX: 1.025, y: 1.025)
                                                            self.layer.shadowOpacity = 0.2
                                                            }, completion: { (finished: Bool) -> Void in
                                                                            UIView.animate(withDuration: 0.1, animations: { () -> Void in
                                                                                                                            self.transform = CGAffineTransform.identity
                                                                                                                            })
                                                                            })
        } else if (selected) {
            self.layer.shadowOpacity = 0.1
        } else {
            self.layer.shadowOpacity = 0.0
        }
        self.updateColors()
        NSLog("setSelected \(selected ? "TRUE" : "FALSE")")
    }
    
    func setEvents(event: Event) {
        _event = event
        self._title?.attributedText = NSAttributedString.init(string: event.title!, attributes: titleAttributesHighlighted(highlighted: self.isSelected))
    }
    
    func updateColors() {
        self.contentView.backgroundColor = self.backgroundColorHighlighted(selected: self.isSelected)
        self._borderView?.backgroundColor = self._borderColor
        self._title?.textColor = self.textColorHighlighted(selected: self.isSelected)
        self._location?.textColor = self.textColorHighlighted(selected: self.isSelected)
    }
    
    func titleAttributesHighlighted(highlighted: Bool) -> [String: Any] {
        let paragraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.left
        paragraphStyle.hyphenationFactor = 1.0
        paragraphStyle.lineBreakMode = NSLineBreakMode.byTruncatingTail
        var result: [String: Any] = [String: Any]()
        result = [  NSFontAttributeName: UIFont.systemFont(ofSize: 12.0),
                    NSForegroundColorAttributeName: self.textColorHighlighted(selected: highlighted),
                    NSParagraphStyleAttributeName: paragraphStyle ]
        return result
    }
    
    func subtitleAttribruteHighlighted(highlighted: Bool) -> [String: Any] {
        let paragraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.left
        paragraphStyle.hyphenationFactor = 1.0
        paragraphStyle.lineBreakMode = NSLineBreakMode.byTruncatingTail
        var result: [String: Any] = [String: Any]()
        result = [  NSFontAttributeName: UIFont.systemFont(ofSize: 12.0),
                    NSForegroundColorAttributeName: self.textColorHighlighted(selected: highlighted),
                    NSParagraphStyleAttributeName: paragraphStyle ]
        return result
    }
    
    func backgroundColorHighlighted(selected: Bool) -> UIColor {
        return selected ? hexStringToUIColor(from: "#35b1f1", alphaValue: 1.0) : hexStringToUIColor(from: "#35b1f1", alphaValue: 0.2)
    }
    
    func textColorHighlighted(selected: Bool) -> UIColor {
        return selected ? UIColor.white : hexStringToUIColor(from: "#21729c", alphaValue: 1.0)
    }
}

class TimeRowHeaderBackground: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//class CurrentTimeIndicator: UICollectionReusableView {
//    private var _time: UILabel? = nil
//    private var _minuteTimer: Timer? = nil
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//        self.backgroundColor = UIColor.white
//        
//        self._time = UILabel()
//        self._time?.font = UIFont.boldSystemFont(ofSize: 10.0)
//        self._time?.textColor = hexStringToUIColor(from: "#fd3935", alphaValue: 1)
//        self.addSubview(self._time!)
//        
////        let calendar: Calendar = Calendar.current
////        let oneMinuteInFuture: Date = Date.init(timeIntervalSinceNow: 60)
////        let components: DateComponents = calendar.component(, from: oneMinuteInFuture)
////        let nextMinuteBoundary = calendar.date(from: components)
//        
////        self._minuteTimer = Timer.init(fireAt: nextMinuteBoundary, interval: 60, target: self, selector: #selector(), userInfo: nil, repeats: true)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func layoutSubviews() {
//        _time?.frame.size.width = self.frame.width - 10.0
//        _time?.frame.origin.y = self.frame.midY - (_time?.bounds.width)!/2
//    }
//}
/**
 Takes in a hex string such as #ffffff and returns a UIColor
 - Author arshad https://gist.github.com/arshad/de147c42d7b3063ef7bc
 */
func hexStringToUIColor(from hex:String, alphaValue: CGFloat) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    
    if ((cString.characters.count) != 6) {
        return UIColor.gray
    }
    
    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: alphaValue
    )
}
