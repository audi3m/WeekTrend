//
//  ViewController.swift
//  WeekTrend
//
//  Created by J Oh on 6/10/24.
//

import UIKit
import Alamofire
import SnapKit

class ViewController: UIViewController {
    
    let tableView = UITableView()
    
    var list: [Trend] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configNavBar()
        view.addSubview(tableView)
        setTableView()
        configLayout()
        callRequest()
    }
    
    private func callRequest() {
        let url = TrendRequest.trendingMovie.endPoint
        var request = URLRequest(url: url)
        request.setValue(TrendAPI.key, forHTTPHeaderField: "Authorization")
        URLSession.request(endPoint: request) { (data: TrendResponse?, error: APIError?) in
            if let error {
                print("Error code: \(error.rawValue)")
                return
            }
            
            if let data {
                self.list = data.results
            }
        }
        
//        TrendApi.shared.tmdbRequest(api: .trendingMovie) { (data, error) in
//            if let error {
//                print(error)
//            } else {
//                guard let data else { return }
//                self.list = data
//            }
//        }
    }
    
}

// Navigation Bar Buttons
extension ViewController {
    @objc func searchButtonClicked() { }
    @objc func listButtonClicked() { }
}

// Configure
extension ViewController {
    private func configNavBar() {
        navigationItem.title = "Trend"
        let listButton = UIBarButtonItem(image: .list, style: .plain, target: self, action: #selector(listButtonClicked))
        let searchButton = UIBarButtonItem(image: .magnifyingglass, style: .plain, target: self, action: #selector(searchButtonClicked))
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.leftBarButtonItem = listButton
        navigationItem.rightBarButtonItem = searchButton
    }
    
    private func configLayout() {
        tableView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
        }
    }
    
}

// TableView
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TrendTableViewCell.id, for: indexPath) as! TrendTableViewCell
        let trend = list[indexPath.row]
        cell.trend = trend
        getCast(trend: trend) { casts in
            DispatchQueue.main.async {
                cell.castLabel.text = casts.joined(separator: ", ")
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let trend = list[indexPath.row]
        let vc = DetailViewController(movieTitle: trend.title, movieID: trend.id)
        navigationController?.pushViewController(vc, animated: true)
        tableView.reloadRows(at: [indexPath], with: .automatic)
        print("\(trend.id)")
    }
    
    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TrendTableViewCell.self, forCellReuseIdentifier: TrendTableViewCell.id)
        tableView.separatorStyle = .none
    }
    
    private func getCast(trend: Trend, completionHandler: @escaping ([String]) -> Void) {
        let url = URL(string: trend.castUrl)!
        AF.request(url, headers: TrendAPI.header).responseDecodable(of: CastResponse.self) { response in
            switch response.result {
            case .success(let value):
                let list = Array(value.cast.prefix(10)).map { $0.name }
                completionHandler(list)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
