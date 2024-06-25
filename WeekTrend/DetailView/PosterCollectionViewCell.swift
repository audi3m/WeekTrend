//
//  PosterCollectionViewCell.swift
//  WeekTrend
//
//  Created by J Oh on 6/25/24.
//

import UIKit
import SnapKit

class PosterCollectionViewCell: UICollectionViewCell {
    
    let posterImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(posterImageView)
        
        posterImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
        posterImageView.backgroundColor = .lightGray
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.layer.cornerRadius = 10
        posterImageView.clipsToBounds = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
