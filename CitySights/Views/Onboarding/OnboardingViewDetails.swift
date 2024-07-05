//
//  OnboardingViewDetails.swift
//  CitySights
//
//  Created by Tauan Tathiell Camargo on 05/07/24.
//

import SwiftUI

struct OnboardingViewDetails: View {
    var color: Color
    var title: String
    var description: String
    var buttonLabel: String
    var buttonAction: () -> Void
    
    var body: some View {
        ZStack {
            Color(color)
            
            VStack {
                Spacer()
                
                Image("onboarding")
                
                Text(title)
                    .font(Font.system(size: 22))
                    .bold()
                    .padding(.top, 32)
                Text(description)
                    .padding(.top, 4)
                
                Spacer()
                
                Button {
                    buttonAction()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 14)
                            .foregroundStyle(.white)
                            .frame(height: 50)
                        Text(buttonLabel)
                            .foregroundStyle(.black)
                            .bold()
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 81)
            }
            .foregroundStyle(.white)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    OnboardingViewDetails(color: .mint, title: "Welcome", description: "Description text", buttonLabel: "Continue", buttonAction: { print("Hello")})
}
