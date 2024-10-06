//
//  PosterCollectionViewCell.swift
//  WeekTrend
//
//  Created by J Oh on 6/25/24.
//

import UIKit
import SnapKit

final class PosterCollectionViewCell: BaseCollectionViewCell {
    
    let posterImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    override func setHierarchy() {
        contentView.addSubview(posterImageView)
    }
    
    override func setLayout() {
        posterImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
    
    override func setUI() {
        posterImageView.backgroundColor = .lightGray
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.layer.cornerRadius = 10
        posterImageView.clipsToBounds = true
    }
    
}
