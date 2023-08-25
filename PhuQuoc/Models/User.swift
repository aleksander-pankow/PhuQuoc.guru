//
//  User.swift
//  PhuQuoc
//
//  Created by Aleksander Pankow on 29/06/2023.
//

import Foundation

struct User:Codable{
    let name: String
    let birth: Date?
    let coupons: [String]?
    let favorite: [String]?
    let gender: String?
    let photo: String?
    let phone: String?
    let visits: [String]?
}
