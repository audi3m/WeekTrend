//
//  Trend.swift
//  WeekTrend
//
//  Created by J Oh on 6/10/24.
//

import Foundation
import Alamofire

class TrendApi {
    static let shared = TrendApi()
    
    private init() { }
    
    func getSimilarMovies(movieID: Int, completionHandler: @escaping ([String]) -> Void) {
        let url = TrendAPI.similarUrl + "\(movieID)" + "/similar"
        AF.request(url, headers: TrendAPI.header).responseDecodable(of: TrendResponse.self) { response in
            switch response.result {
            case .success(let value):
                let list = value.results.map { TrendAPI.posterUrl + $0.poster_path }
                completionHandler(list)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getRecommendMovies(movieID: Int, completionHandler: @escaping ([String]) -> Void) {
        let url = TrendAPI.similarUrl + "\(movieID)" + "/recommendations"
        AF.request(url, headers: TrendAPI.header).responseDecodable(of: TrendResponse.self) { response in
            switch response.result {
            case .success(let value):
                let list = value.results.map { TrendAPI.posterUrl + $0.poster_path }
                completionHandler(list)
            case .failure(let error):
                print(error)
            }
        }
    }
}

struct TrendResponse: Decodable {
    let page: Int
    let results: [Trend]
}

struct Trend: Decodable {
    let id: Int
    let title: String
    let release_date: String
    let vote_average: Double
    let genre_ids: [Int]
    let poster_path: String
    
    var genre: String {
        let id = self.genre_ids.first ?? 0
        return genres[id] ?? "UNKOWN"
    }
    
    var posterUrl: String {
        "\(TrendAPI.posterUrl)\(poster_path)"
    }
    
    var castUrl: String {
        "\(TrendAPI.castUrl)\(id)/credits"
    }
    
}

struct CastResponse: Decodable {
    let cast: [Cast]
}

struct Cast: Decodable {
    let name: String
}

let genres: [Int: String] = [
    0: "UNKOWN",
    28: "Action",
    12: "Adventure",
    16: "Animation",
    35: "Comedy",
    80: "Crime",
    99: "Documentary",
    18: "Drama",
    10751: "Family",
    14: "Fantasy",
    36: "History",
    27: "Horror",
    10402: "Music",
    9648: "Mystery",
    10749: "Romance",
    878: "Science Fiction",
    10770: "TV Movie",
    53: "Thriller",
    10752: "War",
    37: "Western"
]

