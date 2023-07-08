//
//  NetworkManager.swift
//  PhuQuoc
//
//  Created by Aleksander Pankow on 29/06/2023.
//

import Foundation

enum NetworkState: Error {
    case badURL
    case noData
    case loading
    case loaded
    case error
    case none
}
