//
//  Trend.swift
//  WeekTrend
//
//  Created by J Oh on 6/10/24.
//

import Foundation
import Alamofire

final class TrendService {
    static let shared = TrendService() 
    private init() { }
    
    typealias CompletionHandler = ([Trend]?, Error?) -> Void
    
    func tmdbRequest(api: TrendRequest, completionHandler: @escaping CompletionHandler) {
        AF.request(api.endPoint,
                   method: api.method,
                   parameters: api.parameters,
                   encoding: URLEncoding(destination: .queryString),
                   headers: api.header).responseDecodable(of: TrendResponse.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(value.results, nil)
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }
    
    func request<T: Decodable>(api: TrendRequest, model: T.Type, completionHandler: @escaping (T?, ResponseError?) -> Void) {
         
        var request = URLRequest(url: api.endPoint, timeoutInterval: 10)
        request.setValue(TrendAPI.key, forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            DispatchQueue.main.async {
                guard error == nil else {
                    print("Failed Request")
                    completionHandler(nil, .failedRequest)
                    return
                }
                
                guard let data else {
                    print("No Data Returned")
                    completionHandler(nil, .noData)
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    print("Unable Response")
                    completionHandler(nil, .invalidResponse)
                    return
                }
                
                guard response.statusCode == 200 else {
                    print("Failed Response")
                    completionHandler(nil, .failedRequest)
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    completionHandler(result, nil)
                    print("Success")
                } catch {
                    print("Error")
                    completionHandler(nil, .invalidData)
                }
            }
        }.resume()
        
    }
    
    enum ResponseError: Int, Error {
        case failedRequest = 401
        case noData = 403
        case invalidResponse // 404
        case invalidData // 405
    }
}

struct VideoResponse: Decodable {
    let results: [VideoInfo]
}

struct VideoInfo: Decodable {
    let key: String
    let site: String
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
    let poster_path: String?
    
    var genre: String {
        let id = self.genre_ids.first ?? 0
        return genres[id] ?? "UNKOWN"
    }
    
    var posterUrl: String {
        if let poster_path {
            return "\(TrendAPI.posterUrl)\(poster_path)"
        } else {
            return ""
        }
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

