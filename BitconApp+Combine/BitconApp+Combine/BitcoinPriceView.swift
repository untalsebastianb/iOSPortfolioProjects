//
//  ContentView.swift
//  BitconApp+Combine
//
//  Created by Sebastian on 10/02/23.
//

import SwiftUI

extension Color {
    static let bitcoinGreen: Color = Color.green.opacity(0.9)
}

struct BitcoinPriceView: View {
    
    @ObservedObject var viewModel: BitcoinPriceViewModel
    @State private var selectedCurrency: Currency = .usd
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Updated \(viewModel.lastUpdated)")
                .padding([.top, .bottom])
                .foregroundColor(.bitcoinGreen)
            
            TabView(selection: $selectedCurrency) {
                ForEach(viewModel.priceDetails.indices, id: \.self) { index in
                    let priceDetails = viewModel.priceDetails[index]
                    PriceDetailsView(priceDetails: priceDetails)
                        .tag(priceDetails.currency)
                }
            }
            .tabViewStyle(PageTabViewStyle())
            
            VStack(spacing: 0) {
                HStack(alignment: .center) {
                    Picker(selection: $selectedCurrency, label: Text("Currency")) {
                        Text("\(Currency.usd.icon) \(Currency.usd.code)").tag(Currency.usd)
                        Text("\(Currency.gbp.icon) \(Currency.gbp.code)").tag(Currency.gbp)
                        Text("\(Currency.eur.icon) \(Currency.eur.code)").tag(Currency.eur)
                    }
                    .padding(.leading)
                    
                    Spacer()
                    
                    Button(action: viewModel.onAppear) {
                        Image(systemName: "arrow.clockwise")
                            .font(.largeTitle)
                    }
                    .padding(.trailing)
                    
                    
                }
                .padding(.top)
                
                Link("Powered by Coindex", destination: URL(string: "https://coindesk.com/price/bitcoin")!)
                    .font(.caption)
            }
            .foregroundColor(.bitcoinGreen)
        }
        .onAppear(perform: viewModel.onAppear)
        .pickerStyle(MenuPickerStyle())
    }
}

struct PriceDetailsView: View {
    
    let priceDetails: PriceDetails
    
    var body: some View {
        ZStack {
            Color.bitcoinGreen
            VStack {
                Text(priceDetails.currency.icon)
                    .font(.largeTitle)
                Text("1 Bitcoin =")
                    .font(.title2)
                Text("\(priceDetails.rate) \(priceDetails.currency.code)")
                    .bold()
                    .font(.largeTitle)
            }
            .foregroundColor(.white)
        }
    }
}

struct BitcoinPriceView_Previews: PreviewProvider {
    static var previews: some View {
        BitcoinPriceView(viewModel: BitcoinPriceViewModel())
    }
}
