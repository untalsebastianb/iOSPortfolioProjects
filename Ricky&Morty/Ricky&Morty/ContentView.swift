//
//  ContentView.swift
//  Ricky&Morty
//
//  Created by Juan Sebastian Bueno on 2/05/23.
//

import SwiftUI

struct ContentView: View {

    let viewModel = ViewModel()

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .onAppear{
            viewModel.executeRequest()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
