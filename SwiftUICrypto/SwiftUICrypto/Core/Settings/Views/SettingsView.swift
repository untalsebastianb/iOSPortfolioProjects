//
//  SettingsView.swift
//  SwiftUICrypto
//
//  Created by Juan Sebastian Bueno on 12/11/23.
//

import SwiftUI

struct SettingsView: View {
    
    let defaultURL = URL(string: "https://www.google.com")!
    let youtubeURL = URL(string: "https://www.youtube.com")!
    let coffeURL = URL(string: "https://www.buymeacoffee.com")!
    let coinGeckoURL = URL(string: "https://coingecko.com")!
    let personalURL = URL(string: "https://github.com/untalsebastianb/iOSPortfolioProjects")!
    
    var body: some View {
        NavigationView { 
            List { 
                swiftUISection  
                coinGeckoSection
                developerSection
                applicationSection
            }
            .font(.headline)
            .tint(.blue)
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

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

extension SettingsView {
    private var swiftUISection: some View {
        Section { 
            VStack(alignment: .leading) { 
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("This app is Completely done with SwiftUI, using MVVM Architechture, Combine and Core Data")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
            }
            .padding(.vertical)
            Link("Watch Youtube", destination: youtubeURL)
            Link("Buy me a ☕️", destination: coffeURL)
        } header: { 
            Text("SwiftUI")
        }
    }
    
    private var coinGeckoSection: some View {
        Section { 
            VStack(alignment: .leading) { 
                Image("coingecko")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("The Crypto currency data that is used in this app comes from CoinGecko!")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
            }
            .padding(.vertical)
            Link("Visit coin gecko", destination: coinGeckoURL)
        } header: { 
            Text("CoinGecko")
        }
    }
    
    private var developerSection: some View {
        Section { 
            VStack(alignment: .leading) { 
                Image("developer")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("Hi, I'm Juancho and this is a portfolio App I've build using SwiftUI!")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
            }
            .padding(.vertical)
            Link("Visit Website 🙋🏻‍♂️", destination: personalURL)
        } header: { 
            Text("Developer")
        }
    }
    
    private var applicationSection: some View {
        Section { 
            Link("Terms of Service", destination: coinGeckoURL)
            Link("Privacy Policy", destination: coinGeckoURL)
            Link("Company Website", destination: coinGeckoURL)
            Link("Learn More", destination: coinGeckoURL)
        } header: { 
            Text("Application")
        }
    }
}
