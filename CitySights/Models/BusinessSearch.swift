//
//  BusinessSearch.swift
//  CitySights
//
//  Created by Tauan Tathiell Camargo on 04/07/24.
//

import Foundation

struct BusinessSearch: Decodable {
    var businesses: [Business] = [Business]()
    var total: Int?
    var region: Region?
}

struct Region: Decodable {
    var center: Coordinate?
}

struct Coordinate: Decodable {
    var longitude: Double?
    var latitude: Double?
}
