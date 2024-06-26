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
        TrendApi.shared.tmdbRequest(api: .trendingMovie) { (data, error) in
            if let error {
                print(error)
            } else {
                guard let data else { return }
                self.list = data
            }
        }
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
        let data = list[indexPath.row]
        cell.trend = data
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let trend = list[indexPath.row]
        let vc = DetailViewController(movieTitle: trend.title, movieID: trend.id)
        navigationController?.pushViewController(vc, animated: true)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TrendTableViewCell.self, forCellReuseIdentifier: TrendTableViewCell.id)
        tableView.separatorStyle = .none
    }
    
}
