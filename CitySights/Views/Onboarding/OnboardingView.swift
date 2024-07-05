//
//  OnboardingView.swift
//  CitySights
//
//  Created by Tauan Tathiell Camargo on 05/07/24.
//

import SwiftUI

struct OnboardingView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(BusinessViewModel.self) var businessViewModel
    @State var selectedView = 0
    
    var body: some View {
        ZStack {
            Color(selectedView == 0 ? .green : .mint)
            
            TabView(selection: $selectedView) {
                OnboardingViewDetails(color: .green, title: "Welcome to City Sights", description: "City Sights help us to find best of the city!", buttonLabel: "Continue", buttonAction: {
                    withAnimation {
                        selectedView = 1
                    }
                })
                .tag(0)
                
                OnboardingViewDetails(color: .mint, title: "Welcome to City Sights", description: "City Sights help us to find best of the city!", buttonLabel: "Continue", buttonAction: {
                    withAnimation {
                        dismiss()
                        businessViewModel.getUserLocation()
                    }
                })
                .tag(1)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            VStack {
                Spacer()
                HStack (spacing: 16) {
                    Spacer()
                    Circle()
                        .frame(width: 10)
                        .foregroundStyle(selectedView == 0 ? .white : .gray)
                    Circle()
                        .frame(width: 10)
                        .foregroundStyle(selectedView == 1 ? .white : .gray)
                    Spacer()
                }
                .padding(.bottom, 220)
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    OnboardingView()
        .environment(BusinessViewModel())
}
