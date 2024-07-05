//
//  MapView.swift
//  CitySights
//
//  Created by Tauan Tathiell Camargo on 04/07/24.
//

import SwiftUI
import MapKit

struct MapView: View {
    @Environment(BusinessViewModel.self) var businessViewModel
    @State var selectedBusinessId : String?
    
    var body: some View {
        Map(selection: $selectedBusinessId) {
            ForEach(businessViewModel.businesses) {business in
                Marker(business.name ?? "Restaurant", coordinate: CLLocationCoordinate2D(latitude: business.coordinates?.latitude ?? 0.0, longitude: business.coordinates?.longitude ?? 0.0))
                .tag(business.id ?? "None")
            }
        }
        .onChange(of: selectedBusinessId) { oldValue, newValue in
            let business = businessViewModel.businesses.first { business in
                business.id == selectedBusinessId
            }
            
            if let business = business {
                businessViewModel.businessSelected = business
            }
        }
    }
}

#Preview {
    MapView()
        .environment(BusinessViewModel())
}
