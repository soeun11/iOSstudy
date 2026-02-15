//
//  AppDetailItem.swift
//  TCA
//
//  Created by 소은 on 2/15/26.
//

import Foundation

struct AppDetailItem: Decodable {
    let id: Int
    let name: String
    let iconUrl: String
    let userRatingCount: Int
    let averageUserRating: Float
    let genres: [String]
    let screenshotUrls: [String]
    
    enum CodingKeys: String, CodingKey {
        case name = "trackName"
        case id = "trackId"
        case iconUrl = "artworkUrl100"
        case userRatingCount
        case averageUserRating
        case genres
        case screenshotUrls
    }
}
