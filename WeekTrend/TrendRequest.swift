//
//  TrendRequest.swift
//  WeekTrend
//
//  Created by J Oh on 6/26/24.
//

import Foundation
import Alamofire

enum TrendRequest {
    
    case trendingMovie
    case cast(id: Int)
    case similar(id: Int)
    case recommend(id: Int) 
    
    var baseUrl: String {
        return "https://api.themoviedb.org/3/"
    }
    
    var endPoint: URL {
        switch self {
        case .trendingMovie:
            return URL(string: baseUrl + "trending/movie/week")!
        case .cast(let id):
            return URL(string: baseUrl + "movie/\(id)/credits")!
        case .similar(let id):
            return URL(string: baseUrl + "movie/\(id)/similar")!
        case .recommend(let id):
            return URL(string: baseUrl + "movie/\(id)/recommendations")!
        }
    }
    
    var header: HTTPHeaders {
        return [ "Authorization": TrendAPI.key ]
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameters: Parameters {
        ["": ""]
    }
    
}

