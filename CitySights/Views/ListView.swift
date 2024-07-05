//
//  ListView.swift
//  CitySights
//
//  Created by Tauan Tathiell Camargo on 04/07/24.
//

import SwiftUI

struct ListView: View {
    @Environment(BusinessViewModel.self) var businessViewModel
    
    var body: some View {
        List {
            ForEach(businessViewModel.businesses) { business in
                VStack(spacing: 20) {
                    HStack {
                        if let imageUrl = business.imageUrl {
                            AsyncImage(url: URL(string: imageUrl)!) { image in
                                image
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                                    .clipShape(RoundedRectangle(cornerRadius: 6))
                                    .padding(.trailing, 10)
                            } placeholder: {
                                ProgressView()
                                    .frame(width: 50, height: 50)
                            }
                        } else {
                            Image("Food")
                                .padding(.trailing, 10)
                        }
                        
                        VStack(alignment: .leading) {
                            Text(business.name ?? "")
                                .font(Font.system(size: 15))
                                .bold()
                            Text(TextHelper.distanceAwayText(meters: business.distance ?? 0))
                                .font(Font.system(size: 16))
                                .foregroundStyle(Color(red: 67/255, green: 71/255, blue: 76/255))
                        }
                        
                        Spacer()
                        Text("Rating: \(String(business.rating ?? 0))")
                    }
                    
                    Divider()
                }
                .onTapGesture {
                    businessViewModel.businessSelected = business
                }
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
    }
}

#Preview {
    ListView()
        .environment(BusinessViewModel())
}
