//
//  BusinessDetailView.swift
//  CitySights
//
//  Created by Tauan Tathiell Camargo on 04/07/24.
//

import SwiftUI

struct BusinessDetailView: View {
    @Environment(BusinessViewModel.self) var businessViewModel
    
    var body: some View {
        let business = businessViewModel.businessSelected
        
        VStack (alignment: .leading) {
            ZStack {
                if let imageUrl = business?.imageUrl {
                    AsyncImage(url: URL(string: imageUrl)!) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 180)
                            .clipped()
                    } placeholder: {
                        ProgressView()
                            .frame(width: 50, height: 50)
                    }

                } else {
                    Image("Place")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
            }
            .frame(height: 164)
            
            if let isClose = business?.isClosed {
                ZStack(alignment: .leading) {
                    Rectangle()
                        .foregroundStyle(isClose ? .red : .green)
                    Text(isClose ? "Closed" : "Opened")
                        .foregroundStyle(.white)
                        .padding(.horizontal, 20)
                }
                .frame(height: 36)
            }
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 10) {
                    Text(business?.name ?? "Name")
                        .font(Font.system(size: 22))
                        .bold()
                    
                    VStack(alignment: .leading) {
                        Text("\(business?.location?.address1 ?? ""), \(business?.location?.city ?? "")")
                            .font(Font.system(size: 16))
                            .foregroundStyle(Color(red: 67/255, green: 71/255, blue: 76/255))
                        Text("\(business?.location?.state ?? ""), \(business?.location?.country ?? "")")
                            .font(Font.system(size: 16))
                            .foregroundStyle(Color(red: 67/255, green: 71/255, blue: 76/255))
                    }
                    
                    Text("Rating: \(String(business?.rating ?? 5.0))")
                    
                    Divider()
                        .padding(.top, 12)
                    
                    Text(business?.alias ?? "Alias")
                        .font(Font.system(size: 15))
                        .multilineTextAlignment(.leading)
                    
                    Divider()
                        .padding(.top, 12)
                    
                    HStack {
                        Image(systemName: "phone")
                        Text(business?.displayPhone ?? "")
                        Spacer()
                        Image(systemName: "arrow.right")
                    }
                    .padding(.top, 12)
                    
                    Divider()
                        .padding(.top, 12)
                    
                    HStack {
                        Image(systemName: "globe")
                        Text(business?.url ?? "")
                            .lineLimit(1)
                        Spacer()
                        Image(systemName: "arrow.right")
                    }
                    .padding(.top, 12)
                    
                    Divider()
                        .padding(.top, 12)
                    
                    HStack {
                        Image(systemName: "bubble.left.and.bubble.right")
                        Text("\(String(business?.reviewCount ?? 0)) reviews")
                        Spacer()
                        Image(systemName: "arrow.right")
                    }
                    .padding(.top, 12)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    BusinessDetailView()
}
