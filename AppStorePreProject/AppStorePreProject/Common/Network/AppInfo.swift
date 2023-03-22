//
//  AppInfo.swift
//  AppStorePreProject
//
//  Created by 김소영 on 2023/03/21.
//

import UIKit

struct AppInfoResult: Codable {
    let supportedDevices: [String]?
    let screenshotUrls: [String]?
    let artworkUrl60: String?
    let artworkUrl512: String?
    let artworkUrl100: String?
    let artistViewUrl: String?
    let kind: String?
    let currency: String?
    let artistId: Int?
    let artistName: String?
    let genres:[String]?
    let price: Double?
    let description: String?
    let releaseDate: String?
    let releaseNotes: String?
    let sellerName: String?
    let bundleId: String?
    let trackId: Int?
    let trackName: String?
    let currentVersionReleaseDate: String?
    let averageUserRatingForCurrentVersion: Double?
    let userRatingCountForCurrentVersion: Int?
    let averageUserRating: Double?
    let trackViewUrl: String?
    let trackContentRating: String?
    let languageCodesISO2A: [String]?
    let sellerUrl: String?
    let formattedPrice: String?
    let fileSizeBytes: String?
    let contentAdvisoryRating: String?
}

struct ApiResponse: Codable {
    let resultCount: Int
    let results: [AppInfoResult]
}
