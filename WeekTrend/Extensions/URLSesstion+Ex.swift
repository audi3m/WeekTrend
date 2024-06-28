//
//  URLSesstion+Ex.swift
//  WeekTrend
//
//  Created by J Oh on 6/28/24.
//

import Foundation

extension URLSession {
    
    typealias completionHandler = (Data?, URLResponse?, Error?) -> Void
    
    @discardableResult
    func customDataTask(_ endPoint: URLRequest, 
                        completionHandler: @escaping completionHandler) -> URLSessionDataTask {
        let task = dataTask(with: endPoint, completionHandler: completionHandler)
        task.resume()
        return task
    }
    
    static func request<T: Decodable>(_ session: URLSession = .shared,
                                    endPoint: URLRequest,
                                    completion: @escaping (T?, APIError?) -> Void) {
        
        session.customDataTask(endPoint) { data, response, error in
            DispatchQueue.main.async {
                guard error == nil else {
                    completion(nil, .failedRequest)
                    return
                }
                guard let data else { 
                    completion(nil, .invalidData)
                    return
                }
                guard let response = response as? HTTPURLResponse else { 
                    completion(nil, .invalidResponse)
                    return
                }
                guard response.statusCode == 200 else {
                    completion(nil, .noData)
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    completion(result, nil)
                } catch {
                    print(error)
                    completion(nil, .invalidData)
                }
            }
        }
    }
}

enum APIError: Int, Error {
    case failedRequest = 401
    case noData = 403
    case invalidResponse // 404
    case invalidData // 405
}
