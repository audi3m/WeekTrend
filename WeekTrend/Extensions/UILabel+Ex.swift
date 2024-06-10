//
//  UILabel+Ex.swift
//  WeekTrend
//
//  Created by J Oh on 6/10/24.
//

import UIKit

class PaddedLabel: UILabel {
    private var padding = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    
    convenience init(padding: UIEdgeInsets) {
        self.init()
        self.padding = padding
        config()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.config()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }
    
    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right
        
        return contentSize
    }
    
    
    func config() {
        self.textAlignment = .center
        self.textColor = .white
    }
    
}
