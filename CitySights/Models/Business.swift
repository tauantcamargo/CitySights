//
//  Business.swift
//  CitySights
//
//  Created by Tauan Tathiell Camargo on 04/07/24.
//

import Foundation


struct Business: Decodable, Identifiable {
    var id: String?
    var alias: String?
    var name: String?
    var imageUrl: String?
    var isClosed: Bool?
    var url: String?
    var reviewCount: Int?
    var categories: [Categories] = [Categories]()
    var rating: Double?
    var coordinates: Coordinate?
    var transactions: [String] = [String]()
    var price: String?
    var location: Location?
    var phone: String?
    var displayPhone: String?
    var distance: Double?
    var attributes: Attribute?
    
    enum CodingKeys: String, CodingKey {
        case imageUrl = "image_url"
        case isClosed = "is_closed"
        case reviewCount = "review_count"
        case displayPhone = "display_phone"
        
        case id
        case alias
        case name
        case url
        case categories
        case rating
        case coordinates
        case transactions
        case price
        case location
        case phone
        case distance
        case attributes
    }
}

struct Categories: Decodable {
    var alias: String?
    var title: String?
}

struct Location: Decodable {
    var address1: String?
    var address2: String?
    var address3: String?
    var city: String?
    var zipCode: String?
    var country: String?
    var state: String?
    var displayAddress: [String] = [String]()
    
    enum CodingKeys: String, CodingKey {
        case zipCode = "zip_code"
        case displayAddress = "display_address"
    
        case address1
        case address2
        case address3
        case city
        case country
        case state
    }
}

struct Attribute: Decodable {
    var businessTempClosed: Bool?
    var menuUrl: String?
    var open24Hours: Bool?
    var waitlistReservation: Bool?
    
    enum CodingKeys: String, CodingKey {
        case businessTempClosed = "business_temp_closed"
        case menuUrl = "menu_url"
        case open24Hours = "open24_hours"
        case waitlistReservation = "waitlist_reservation"
    }
}
