//
//  CitySightsApp.swift
//  CitySights
//
//  Created by Tauan Tathiell Camargo on 03/07/24.
//

import SwiftUI

@main
struct CitySightsApp: App {
    @State var businessViewModel = BusinessViewModel()
    @AppStorage("onboarding") var needsOnboarding = true
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(businessViewModel)
                .fullScreenCover(isPresented: $needsOnboarding) {
                    needsOnboarding = false
                } content: {
                    OnboardingView()
                        .environment(businessViewModel)
                }
                .onAppear {
                    if needsOnboarding == false && businessViewModel.locationAuthStatus == .notDetermined {
                        businessViewModel.getUserLocation()
                    }
                }
        }
    }
}
