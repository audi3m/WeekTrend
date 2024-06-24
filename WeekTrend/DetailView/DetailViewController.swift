//
//  DetailViewController.swift
//  WeekTrend
//
//  Created by J Oh on 6/11/24.
//

import UIKit
import Alamofire
import Kingfisher
import SnapKit

class DetailViewController: UIViewController {
    
    var movieTitle: String
    var movieID: Int
    
    let titleLabel = UILabel()
    let similarLabel = UILabel()
    let similarImageView1 = UIImageView()
    let similarImageView2 = UIImageView()
    let similarImageView3 = UIImageView()
    let recommendLabel = UILabel()
    let recommendImageView1 = UIImageView()
    let recommendImageView2 = UIImageView()
    let recommendImageView3 = UIImageView()
    
    
    init(movieTitle: String, movieID: Int) {
        self.movieTitle = movieTitle
        self.movieID = movieID
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configNavBar()
        
        configHierarchy()
        configLayout()
        configUI()
        
        setData()
        
        getSimilarMovies()
        getRecommendMovies()
        
    }
    
}

// Network
extension DetailViewController {
    
    func getSimilarMovies() {
        let url = TrendAPI.similarUrl + "\(movieID)" + "/similar"
        AF.request(url, headers: TrendAPI.header).responseDecodable(of: TrendResponse.self) { response in
            switch response.result {
            case .success(let value):
                let list = Array(value.results.prefix(3)).map { TrendAPI.posterUrl + $0.poster_path }
                self.setImage(self.similarImageView1, urlStr: list[0])
                self.setImage(self.similarImageView2, urlStr: list[1])
                self.setImage(self.similarImageView3, urlStr: list[2])
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getRecommendMovies() {
        let url = TrendAPI.similarUrl + "\(movieID)" + "/recommendations"
        AF.request(url, headers: TrendAPI.header).responseDecodable(of: TrendResponse.self) { response in
            switch response.result {
            case .success(let value):
                let list = Array(value.results.prefix(3)).map { TrendAPI.posterUrl + $0.poster_path }
                self.setImage(self.recommendImageView1, urlStr: list[0])
                self.setImage(self.recommendImageView2, urlStr: list[1])
                self.setImage(self.recommendImageView3, urlStr: list[2])
            case .failure(let error):
                print(error)
            }
        }
    }
}

// Configure
extension DetailViewController {
    
    func configNavBar() {
        navigationItem.title = "출연 / 제작"
    }
    
    func configHierarchy() {
        view.addSubview(titleLabel)
        view.addSubview(similarLabel)
        view.addSubview(similarImageView1)
        view.addSubview(similarImageView2)
        view.addSubview(similarImageView3)
        view.addSubview(recommendLabel)
        view.addSubview(recommendImageView1)
        view.addSubview(recommendImageView2)
        view.addSubview(recommendImageView3)
    }
    
    func configLayout() {
        
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        
        similarLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(10)
        }
        
        similarImageView1.snp.makeConstraints { make in
            make.top.equalTo(similarLabel.snp.bottom).offset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.width.equalTo(100)
            make.height.equalTo(140)
        }
        
        similarImageView2.snp.makeConstraints { make in
            make.centerY.equalTo(similarImageView1.snp.centerY)
            make.leading.equalTo(similarImageView1.snp.trailing).offset(10)
            make.width.equalTo(100)
            make.height.equalTo(140)
        }
        
        similarImageView3.snp.makeConstraints { make in
            make.centerY.equalTo(similarImageView1.snp.centerY)
            make.leading.equalTo(similarImageView2.snp.trailing).offset(10)
            make.width.equalTo(100)
            make.height.equalTo(140)
        }
        
        recommendLabel.snp.makeConstraints { make in
            make.top.equalTo(similarImageView1.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(10)
        }
        
        recommendImageView1.snp.makeConstraints { make in
            make.top.equalTo(recommendLabel.snp.bottom).offset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.width.equalTo(100)
            make.height.equalTo(140)
        }
        
        recommendImageView2.snp.makeConstraints { make in
            make.centerY.equalTo(recommendImageView1.snp.centerY)
            make.leading.equalTo(recommendImageView1.snp.trailing).offset(10)
            make.width.equalTo(100)
            make.height.equalTo(140)
        }
        
        recommendImageView3.snp.makeConstraints { make in
            make.centerY.equalTo(recommendImageView2.snp.centerY)
            make.leading.equalTo(recommendImageView2.snp.trailing).offset(10)
            make.width.equalTo(100)
            make.height.equalTo(140)
        }
        
    }
    
    func configUI() {
        
        titleLabel.font = .systemFont(ofSize: 25, weight: .heavy)
        similarLabel.font = .boldSystemFont(ofSize: 17)
        
        similarImageView1.contentMode = .scaleAspectFill
        similarImageView1.layer.cornerRadius = 5
        similarImageView1.layer.masksToBounds = true
        similarImageView2.contentMode = .scaleAspectFill
        similarImageView2.layer.cornerRadius = 5
        similarImageView2.layer.masksToBounds = true
        similarImageView3.contentMode = .scaleAspectFill
        similarImageView3.layer.cornerRadius = 5
        similarImageView3.layer.masksToBounds = true
        
        recommendLabel.font = .boldSystemFont(ofSize: 17)
        
        recommendImageView1.contentMode = .scaleAspectFill
        recommendImageView1.layer.cornerRadius = 5
        recommendImageView1.layer.masksToBounds = true
        recommendImageView2.contentMode = .scaleAspectFill
        recommendImageView2.layer.cornerRadius = 5
        recommendImageView2.layer.masksToBounds = true
        recommendImageView3.contentMode = .scaleAspectFill
        recommendImageView3.layer.cornerRadius = 5
        recommendImageView3.layer.masksToBounds = true
        
    }
    
    func setData() {
        titleLabel.text = movieTitle
        similarLabel.text = "비슷한 영화"
        recommendLabel.text = "추천 영화"
    }
    
    func setImage(_ imageView: UIImageView, urlStr: String) {
        let url = URL(string: urlStr)
        imageView.kf.setImage(with: url)
    }
    
}
