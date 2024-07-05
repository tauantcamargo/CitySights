//
//  BusinessViewModel.swift
//  CitySights
//
//  Created by Tauan Tathiell Camargo on 04/07/24.
//

import Foundation
import SwiftUI
import CoreLocation

@Observable
class BusinessViewModel: NSObject, CLLocationManagerDelegate {
    var businesses: [Business] = [Business]()
    var businessSelected: Business?
    
    var dataService = DataService()
    var locationManager = CLLocationManager()
    var currentUserLocation: CLLocationCoordinate2D?
    var locationAuthStatus: CLAuthorizationStatus = .notDetermined
    
    override init() {
        super.init()
        
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.delegate = self
    }
    
    func getBusinesses(query: String?, options: String?, category: String?) {
        Task {
            businesses = await dataService.businessSearch(userLocation: currentUserLocation, query: query, options: options, category: category)
        }
    }
    
    func getUserLocation() {
        if locationManager.authorizationStatus == .authorizedWhenInUse {
            currentUserLocation = nil
            locationManager.requestLocation()
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(error)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        self.locationAuthStatus = manager.authorizationStatus
        
        if manager.authorizationStatus == .authorizedWhenInUse {
            currentUserLocation = nil
            manager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        if currentUserLocation == nil {
            currentUserLocation = locations.last?.coordinate
            
            getBusinesses(query: nil, options: nil, category: nil)
        }
        
        manager.stopUpdatingLocation()
    }
}
