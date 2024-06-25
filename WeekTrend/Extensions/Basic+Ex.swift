//
//  Basic+Ex.swift
//  WeekTrend
//
//  Created by J Oh on 6/10/24.
//

import UIKit

extension UITableViewCell {
    static var id: String {
        String(describing: self)
    }
}

extension UICollectionViewCell {
    static var id: String {
        String(describing: self)
    }
}

extension UIViewController {
    static var id: String {
        String(describing: self)
    }
}
