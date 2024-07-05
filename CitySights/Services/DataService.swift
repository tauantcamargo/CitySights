//
//  DataService.swift
//  CitySights
//
//  Created by Tauan Tathiell Camargo on 04/07/24.
//

import Foundation
import CoreLocation

struct DataService {
    let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String
    
    func businessSearch(userLocation: CLLocationCoordinate2D?, query: String?, options: String?, category: String?) async -> [Business] {
        guard apiKey != nil else {
            return [Business]()
        }
        
        var lat =  35.665517
        var long = 139.770398
        
        if let userLocation = userLocation {
            lat = userLocation.latitude
            long = userLocation.longitude
        }
        
        var endpointUrl = "https://api.yelp.com/v3/businesses/search?latitude=\(lat)&longitude=\(long)"
        
        if query != nil && query != "" {
            endpointUrl.append("&term=\(query!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)")
        }
        
        if options != nil && options != "" {
            endpointUrl.append("&attributes=\(options!)")
        }
        
        if let category = category {
            endpointUrl.append("&category=\(category)")
        }
        
        if let url = URL(string: "\(endpointUrl)&limit=10") {
            var request = URLRequest(url: url)
            request.addValue("Bearer \(apiKey ?? "")", forHTTPHeaderField: "Authorization")
            request.addValue("application/json", forHTTPHeaderField: "accept")
            
            do {
                let (data, _) =  try await URLSession.shared.data(for: request)
                
                let decoder = JSONDecoder()
                
                do {
                    let response = try decoder.decode(BusinessSearch.self, from: data)
                    
                    return response.businesses
                } catch {
                    print("Error trying to parese data from api \(error)")
                }
            } catch {
                print("Error to request api \(error)")
            }
        }
        
        return [Business]()
    }
}
