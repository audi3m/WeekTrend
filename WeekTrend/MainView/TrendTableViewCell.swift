//
//  TrendTableViewCell.swift
//  WeekTrend
//
//  Created by J Oh on 6/10/24.
//

import UIKit
import Alamofire
import Kingfisher
import SnapKit

class TrendTableViewCell: BaseTableViewCell {
    
    let dateLabel = UILabel()
    let genreLabel = UILabel()
    let cellBackgroundView = UIView()
    let trendImageView = UIImageView()
    let titleLabel = UILabel()
    let vudwjaLabel = PaddedLabel()
    let gradeLabel = PaddedLabel()
    let castLabel = UILabel()
    
    var trend: Trend? {
        didSet {
            configData()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    override func setHierarchy() {
        contentView.addSubview(dateLabel)
        contentView.addSubview(genreLabel)
        contentView.addSubview(cellBackgroundView)
        cellBackgroundView.addSubview(trendImageView)
        cellBackgroundView.addSubview(titleLabel)
        trendImageView.addSubview(vudwjaLabel)
        trendImageView.addSubview(gradeLabel)
        cellBackgroundView.addSubview(castLabel)
    }
    
    override func setLayout() {
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(15)
            make.leading.equalTo(cellBackgroundView.snp.leading)
        }
        
        genreLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(3)
            make.leading.equalTo(cellBackgroundView.snp.leading)
        }
        
        cellBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(genreLabel.snp.bottom).offset(10)
            make.centerX.equalTo(contentView.snp.centerX)
            make.width.equalTo(contentView.snp.width).multipliedBy(0.9)
            make.bottom.equalTo(contentView.snp.bottom).offset(-20)
        }
        
        trendImageView.snp.makeConstraints { make in
            make.top.equalTo(cellBackgroundView)
            make.horizontalEdges.equalTo(cellBackgroundView.snp.horizontalEdges)
            make.height.equalTo(cellBackgroundView.snp.width).multipliedBy(0.6)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(trendImageView.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(cellBackgroundView).inset(20)
        }
        
        vudwjaLabel.snp.makeConstraints { make in
            make.leading.equalTo(trendImageView.snp.leading).offset(12)
            make.bottom.equalTo(trendImageView.snp.bottom).offset(-12)
        }
        
        gradeLabel.snp.makeConstraints { make in
            make.leading.equalTo(vudwjaLabel.snp.trailing)
            make.width.equalTo(vudwjaLabel.snp.width)
            make.bottom.equalTo(trendImageView.snp.bottom).offset(-12)
        }
        
        castLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.horizontalEdges.equalTo(cellBackgroundView.snp.horizontalEdges).inset(20)
            make.bottom.equalTo(cellBackgroundView.snp.bottom).offset(-20)
        }
    }
    
    override func setUI() {
        
        dateLabel.font = .systemFont(ofSize: 13)
        dateLabel.textColor = .gray
        
        genreLabel.font = .systemFont(ofSize: 16, weight: .heavy)
        
        cellBackgroundView.layer.cornerRadius = 10
        cellBackgroundView.backgroundColor = .systemGray6
        
        trendImageView.contentMode = .scaleAspectFill
        trendImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        trendImageView.layer.cornerRadius = 10
        trendImageView.clipsToBounds = true
        
        titleLabel.font = .boldSystemFont(ofSize: 17)
        
        vudwjaLabel.backgroundColor = .gradeBG
        vudwjaLabel.text = "평점"
        vudwjaLabel.font = .boldSystemFont(ofSize: 13)
        vudwjaLabel.textColor = .white
        vudwjaLabel.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        vudwjaLabel.layer.cornerRadius = 5
        vudwjaLabel.clipsToBounds = true
        
        gradeLabel.backgroundColor = .white
        gradeLabel.font = .boldSystemFont(ofSize: 13)
        gradeLabel.textColor = .black
        gradeLabel.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        gradeLabel.layer.cornerRadius = 5
        gradeLabel.clipsToBounds = true
        
        castLabel.font = .systemFont(ofSize: 13)
        castLabel.textColor = .darkGray
    }
    
    private func configData() {
        guard let trend else { return }
        dateLabel.text = trend.release_date
        genreLabel.text = "#" + trend.genre
        trendImageView.kf.setImage(with: URL(string: trend.posterUrl))
        titleLabel.text = trend.title
        gradeLabel.text = "\(trend.vote_average.gradeFormat())"
        
//        getCast { casts in
//            self.castLabel.text = casts.joined(separator: ", ")
//        }
        
    }
    
//    private func getCast( completionHandler: @escaping ([String]) -> Void) {
//        guard let trend else { return }
//        let url = URL(string: trend.castUrl)!
//        AF.request(url, headers: TrendAPI.header).responseDecodable(of: CastResponse.self) { response in
//            switch response.result {
//            case .success(let value):
//                let list = Array(value.cast.prefix(10)).map { $0.name }
//                completionHandler(list)
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
    
}
