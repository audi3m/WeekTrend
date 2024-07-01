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

class DetailViewController: UIViewController {
    
    let webView = WKWebView()
    private let loading = UIActivityIndicatorView()
    var movieTitle: String
    var movieID: Int
    
    var list: [[String]] = [[], []]
    
    lazy var tableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.register(DetailTableViewCell.self, forCellReuseIdentifier: DetailTableViewCell.id)
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
        callVideoLink()
        callSimilarAndRecommend()
        
    }
    
    func callVideoLink() {
        TrendService.shared.request(api: .video(id: self.movieID), model: VideoResponse.self) { data, error in
            if let error {
                print(error)
            } else {
                guard let data = data?.results else { return }
                if let key = data.first?.key,
                   let url = URL(string: "https://www.youtube.com/embed/" + key) {
//                   let url = URL(string: "https://www.youtube.com/watch?v=" + key) {
                    let request = URLRequest(url: url)
                    self.webView.load(request)
                    
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
        list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.id, for: indexPath) as! DetailTableViewCell
        cell.titleLabel.text = indexPath.row == 0 ? "비슷한 영화" : "추천 영화"
        cell.collectionView.dataSource = self
        cell.collectionView.delegate = self
        cell.collectionView.tag = indexPath.row
        cell.collectionView.register(PosterCollectionViewCell.self, forCellWithReuseIdentifier: PosterCollectionViewCell.id)
        cell.collectionView.reloadData()
        return cell
    }
    
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.id, for: indexPath) as! PosterCollectionViewCell
        let data = list[collectionView.tag][indexPath.item]
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
        view.addSubview(webView)
        webView.addSubview(loading)
        view.addSubview(tableView)
    }
    
    func configLayout() {
        webView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(300)
        }
        
        loading.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(webView.snp.bottom)
            make.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configUI() {
        webView.backgroundColor = .lightGray
        
        tableView.separatorStyle = .none
        
        loading.style = .medium
        loading.hidesWhenStopped = true
    }
    
    func setData() {
        
    }
    
}

extension DetailViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        loading.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loading.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        loading.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        loading.stopAnimating()
    }
}
