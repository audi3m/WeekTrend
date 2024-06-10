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
        callRequest()
        
        setNavBar()
        setTableView()
        
        configHierarchy()
        configLayout()
        configUI()
        
    }
    
    func setNavBar() {
        navigationItem.title = "Trend"
        let listButton = UIBarButtonItem(image: .list, style: .plain, target: self, action: #selector(listButtonClicked))
        let searchButton = UIBarButtonItem(image: .magnifyingglass, style: .plain, target: self, action: #selector(searchButtonClicked))
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.leftBarButtonItem = listButton
        navigationItem.rightBarButtonItem = searchButton
    }
    
    
    
    func configHierarchy() {
        view.addSubview(tableView)
    }
    
    func configLayout() {
        tableView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
        }
    }
    
    func configUI() {
        
    }
    
    func callRequest() {
        let url = TrendAPI.url
        AF.request(url, headers: TrendAPI.header).responseDecodable(of: TrendResponse.self) { response in
            switch response.result {
            case .success(let value):
                self.list = value.results
            case .failure(let error):
                print(error)
            }
        }
        
        
    }
    
    @objc func searchButtonClicked() {
        
    }
    
    @objc func listButtonClicked() {
        
    }
    
}

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
        let vc = DetailViewController(movieID: trend.id)
        navigationController?.pushViewController(vc, animated: true)
        
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    
    func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TrendTableViewCell.self, forCellReuseIdentifier: TrendTableViewCell.id)
        tableView.separatorStyle = .none
    }
    
}
