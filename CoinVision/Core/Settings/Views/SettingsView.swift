//
//  SettingsView.swift
//  CoinVision
//
//  Created by Emre Tatlıcı on 6.12.2024.
//

import SwiftUI

struct SettingsView: View {
    
    let defaultURL = URL(string: "https://www.google.com")!
    let youtubeURL = URL(string: "https://www.youtube.com/@emretatlc3218")!
    let githubURL = URL(string: "https://github.com/EmreTatlici/CoinToTheMoon.git")!
    let coingeckoURL = URL(string: "https://www.coingecko.com")!
    let personalURL = URL(string: "https://medium.com/@iosemretatlici")!
    
    var body: some View {
        NavigationView {
            List {
                toTheMoonSettingsSection
                coinGeckoSection
                developerSection
                applicationSection
                
            }
            .font(.headline)
            .accentColor(.blue)
            .listStyle(GroupedListStyle())
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    XMarkButton()
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}


extension SettingsView {
    private var toTheMoonSettingsSection: some View {
        Section(header: Text("Coin Vision")) {
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Text("This app was made by Emre Tatlici. Built with SwiftUI, MVVM, Combine, and CoreData, it delivers real-time insights and seamless data tracking.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
                
            }
            .padding(.vertical)
            Link("Subscribe on Youtube ", destination: youtubeURL)

        }
    }
    
    private var coinGeckoSection: some View {
        Section(header: Text("CoinGecko")) {
            VStack(alignment: .leading) {
                Image("coingecko")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Text("The cryptocurrency data that is used in this app comes from a free API from CoinGecko! Prices may be slightly delayed.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
                
            }
            .padding(.vertical)
            Link("Visit CoinGecko", destination: coingeckoURL)

        }
    }
    
    private var developerSection: some View {
        Section(header: Text("Developer")) {
            VStack(alignment: .leading) {
                Image("developerPhoto")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 125)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Text("I’m Emre Tatlici, the developer behind Coin Vision. This app uses SwiftUI and is written 100% in swift. The Project benefits from multi-threading, publishers/subscribers, and data persistance.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
                
            }
            .padding(.vertical)
            Link("Support me on Medium", destination: personalURL)
            Link("Follow me on Github", destination: githubURL)

        }
    }
    
    private var applicationSection: some View {
        Section(header: Text("Application")) {
            
            Link("Terms of Service", destination: defaultURL)
            Link("Privacy of Policy", destination: defaultURL)
            Link("Company Website", destination: defaultURL)
            Link("Learn More", destination: defaultURL)


        }
    }
}
