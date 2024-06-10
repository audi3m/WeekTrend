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
    
    var movieID: Int
    
    init(movieID: Int) {
        self.movieID = movieID
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configNavBar()
        
        configHierarchy()
        configLayout()
        configUI()
        
        getMovieDetail()
        
    }
    
}

// Network
extension DetailViewController {
    
    func getMovieDetail() {
//        let url = ""
//        AF.request(url, headers: TrendAPI.header).responseDecodable(of: CastResponse.self) { response in
//            switch response.result {
//            case .success(let value):
//                let list = Array(value.cast.prefix(5)).map { $0.name }
//                self.castLabel.text = list.joined(separator: ", ")
//            case .failure(let error):
//                print(error)
//            }
//        }
    }
}

// Configure
extension DetailViewController {
    
    func configNavBar() {
        navigationItem.title = "출연 / 제작"
        
        
        
    }
    
    
    func configHierarchy() {
        
    }
    
    func configLayout() {
        
    }
    
    func configUI() {
        
    }
}
