//
//  DetailTableViewCell.swift
//  WeekTrend
//
//  Created by J Oh on 6/11/24.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configHierarchy()
        configLayout()
        configUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// Configure
extension DetailTableViewCell {
    func configHierarchy() {
        
    }
    
    func configLayout() {
        
    }
    
    func configUI() {
        
    }
}
