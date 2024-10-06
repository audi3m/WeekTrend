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
import WebKit

final class DetailViewController: UIViewController {
    
    var movieTitle: String
    var movieID: Int
    
    var list: [[String]] = [[], []]
    
    lazy var tableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.register(DetailTableViewCell.self, forCellReuseIdentifier: DetailTableViewCell.id)
        view.register(VideoTableViewCell.self, forCellReuseIdentifier: VideoTableViewCell.id)
        view.rowHeight = 200
        return view
    }()
    
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
        callSimilarAndRecommend()
        
    }
    
    func callVideoLink(completion: @escaping (URLRequest) -> Void) {
        TrendService.shared.request(api: .video(id: self.movieID), model: VideoResponse.self) { data, error in
            if let error {
                print(error)
            } else {
                guard let data = data?.results else { return }
                if let key = data.first?.key,
                   let url = URL(string: "https://www.youtube.com/embed/" + key) {
                    let request = URLRequest(url: url)
                    completion(request)
                    
                }
            }
        }
    }
    
    func callSimilarAndRecommend() {
        let group = DispatchGroup()
        
        group.enter()
        TrendService.shared.request(api: .similar(id: self.movieID), model: TrendResponse.self) { data, error in
            if let error {
                print(error)
            } else {
                guard let data = data?.results else { return }
                self.list[0] = data.map { $0.posterUrl }
            }
            group.leave()
        }
        
        group.enter()
        TrendService.shared.request(api: .recommend(id: self.movieID), model: TrendResponse.self) { data, error in
            if let error {
                print(error)
            } else {
                guard let data = data?.results else { return }
                self.list[1] = data.map { $0.posterUrl }
            }
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.tableView.reloadData()
        }
    }
    
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: VideoTableViewCell.id, for: indexPath) as! VideoTableViewCell
            callVideoLink { request in
                cell.webView.load(request)
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.id, for: indexPath) as! DetailTableViewCell
            cell.titleLabel.text = indexPath.row == 1 ? "비슷한 영화" : "추천 영화"
            cell.collectionView.dataSource = self
            cell.collectionView.delegate = self
            cell.collectionView.tag = indexPath.row
            cell.collectionView.register(PosterCollectionViewCell.self, forCellWithReuseIdentifier: PosterCollectionViewCell.id)
            cell.collectionView.reloadData()
            return cell
        }
    }
    
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list[collectionView.tag-1].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.id, for: indexPath) as! PosterCollectionViewCell
        let data = list[collectionView.tag-1][indexPath.item]
        if !data.isEmpty {
            cell.posterImageView.kf.setImage(with: URL(string: data)!)
        } else {
            cell.posterImageView.image = .movieclapper
        }
        return cell
    }
    
}

// Configure
extension DetailViewController {
    
    func configNavBar() {
        navigationItem.title = movieTitle
    }
    
    func configHierarchy() {
        view.addSubview(tableView)
    }
    
    func configLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configUI() {
        tableView.separatorStyle = .none
    }
    
    func setData() { }
    
}
