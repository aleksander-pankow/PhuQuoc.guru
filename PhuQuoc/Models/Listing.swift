//
//  Listing.swift
//  PhuQuoc
//
//  Created by Aleksander Pankow on 29/05/2023.
//

import Foundation

struct Rating: Codable {
    let base: Int
    let rating: Double
    let count: Int
    let countText: String?
    
    private enum CodingKeys: String, CodingKey {
        case base, rating, count
        case countText = "count_text"
    }
}

struct Photos: Codable {
    let title, src: String
    
    private enum CodingKeys: String, CodingKey {
        case title, src
    }
}

struct Listing: Codable, Equatable {
    
    static func == (lhs: Listing, rhs: Listing) -> Bool {
        // Compare the 'id' property
        return lhs.id == rhs.id
    }
    
    let id: Int
    let rating: Rating
    let address: String
    let latitude: Double
    let longitude: Double
    let url: String
    let title: String
    let content: String
    let excerpt: String
    let price: Int
    let thumbnail: String
    let photos: [Photos]
    let distance: String?
    let distanceWithUnit: String?
    let isFeatured: Bool
    let authorID: String?
    let authorName: String?
    let viewCount: Int

    private enum CodingKeys: String, CodingKey {
        case id
        case rating, address, latitude, longitude, url, title, content, excerpt, price, thumbnail, distance, photos
        case distanceWithUnit = "distance_with_unit"
        case isFeatured = "isFeatured"
        case authorID = "author_id"
        case authorName = "author_name"
        case viewCount = "viewCount"
    }
}

struct JSONResponse: Codable {
    let items: [Listing]
    let pages: Int
}
