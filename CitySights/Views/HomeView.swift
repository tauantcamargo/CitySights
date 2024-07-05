//
//  ContentView.swift
//  CitySights
//
//  Created by Tauan Tathiell Camargo on 03/07/24.
//

import SwiftUI

struct HomeView: View {
    @Environment(BusinessViewModel.self) var businessViewModel
    @State var query = ""
    @State var selectedTab = 0
    @State var popularOn: Bool = false
    @State var selectedCategory = "restaurants"
    @FocusState var isSearchFocus: Bool
    @State var showOptions = false
    
    var body: some View {
        @Bindable var businessViewModel = businessViewModel
        
        VStack {
            HStack {
                TextField("What are you looking for?", text: $query)
                    .textFieldStyle(.roundedBorder)
                    .focused($isSearchFocus)
                    .onTapGesture {
                        withAnimation {
                            showOptions = true
                        }
                    }
                Button {
                    withAnimation {
                        isSearchFocus = false
                        showOptions = false
                        businessViewModel.getBusinesses(query: query, options: popularOn ? "hot_and_new" : nil, category: selectedCategory)
                    }
                } label: {
                    Text("Go")
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                        .foregroundStyle(.white)
                        .background(.blue)
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal, 20)
            
            if showOptions {
                VStack {
                    Toggle("Popular", isOn: $popularOn)
                    
                    HStack {
                        Text("Category")
                        Spacer()
                        Picker("Category", selection: $selectedCategory) {
                            Text("Restaurants")
                                .tag("restaurants")
                            Text("Sports")
                                .tag("sports")
                            Text("Cinemas")
                                .tag("cinemas")
                            Text("Arts")
                                .tag("arts")
                        }
                    }
                }
                .padding(.horizontal, 20)
                .transition(.push(from: .top))
            }
            
            Picker("", selection: $selectedTab) {
                Text("List")
                    .tag(0)
                Text("Map")
                    .tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            
            if businessViewModel.locationAuthStatus == .denied {
                
                VStack {
                    Spacer()
                    Text("Please allow location service for this app to see sights near you!")
                    if let url = URL(string: UIApplication.openSettingsURLString) {
                        Button {
                            UIApplication.shared.open(url)
                        } label: {
                            Text("Open app settings")
                        }
                    }
                   
                    Spacer()
                }
            }
            else if selectedTab == 1 {
                MapView()
                    .onTapGesture {
                        withAnimation {
                            showOptions = false
                            isSearchFocus = false
                        }
                    }
            } else {
                ListView()
                    .onTapGesture {
                        withAnimation {
                            showOptions = false
                            isSearchFocus = false
                        }
                    }
            }
        }
        .sheet(item: $businessViewModel.businessSelected) { item in
            BusinessDetailView()
        }
    }
}

#Preview {
    HomeView()
        .environment(BusinessViewModel())
}
