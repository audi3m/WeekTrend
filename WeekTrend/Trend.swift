//
//  Trend.swift
//  WeekTrend
//
//  Created by J Oh on 6/10/24.
//

import Foundation

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






//{
//    "backdrop_path": "/fY3lD0jM5AoHJMunjGWqJ0hRteI.jpg",
//    "id": 940721,
//    "original_title": "ゴジラ-1.0",
//    "overview": "In postwar Japan, Godzilla brings new devastation to an already scorched landscape. With no military intervention or government help in sight, the survivors must join together in the face of despair and fight back against an unrelenting horror.",
//    "poster_path": "/hkxxMIGaiCTmrEArK7J56JTKUlB.jpg",
//    "media_type": "movie",
//    "adult": false,
//    "original_language": "ja",
//    "genre_ids": [
//        878,
//        27,
//        28
//    ],
//    "popularity": 898.788,
//    "release_date": "2023-11-03",
//    "video": false,
//    "vote_average": 7.631,
//    "vote_count": 1569
//}
