//
//  DetailView.swift
//  SwiftUICrypto
//
//  Created by Juan Sebastian Bueno on 11/14/23.
//

import SwiftUI

struct DetailLoadingView: View {
    @Binding var coin: CoinModel?
    var body: some View {
        ZStack {
            if let coin = coin {
                DetailView(coin: coin)               
            }
        }
    }
}

struct DetailView: View {
    let coin: CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
    }
    var body: some View {
        Text(coin.name)                
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(coin: dev.coin)
    }
}
