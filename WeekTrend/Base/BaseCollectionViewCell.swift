//
//  BaseCollectionViewCell.swift
//  WeekTrend
//
//  Created by J Oh on 6/26/24.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setHierarchy()
        setLayout()
        setUI()
    }
    
    func setHierarchy() { }
    func setLayout() { }
    func setUI() { }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
