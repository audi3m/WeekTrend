//
//  VideoTableViewCell.swift
//  WeekTrend
//
//  Created by J Oh on 7/2/24.
//

import UIKit
import SnapKit
import WebKit

final class VideoTableViewCell: BaseTableViewCell {
    
    let webView = WKWebView()
    
    override func setHierarchy() {
        contentView.addSubview(webView)
    }
    
    override func setLayout() {
        webView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func setUI() {
        
    }
    
}
