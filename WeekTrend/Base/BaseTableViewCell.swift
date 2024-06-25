//
//  BaseTableViewCell.swift
//  WeekTrend
//
//  Created by J Oh on 6/25/24.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setHierarchy()
        setLayout()
        setView()
    }
    

    func setHierarchy() {
        print("Base", #function)
        
        
    }

    func setLayout() {
        print("Base", #function)
        
        
    }

    func setView() {
        print("Base", #function)
        
        
    }
    
    
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
}
