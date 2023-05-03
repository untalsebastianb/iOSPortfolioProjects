//
//  ContentView.swift
//  Ricky&Morty
//
//  Created by Juan Sebastian Bueno on 2/05/23.
//

import SwiftUI

struct ContentView: View {

    @StateObject var viewModel = ViewModel()

    var body: some View {
        VStack {
            Text("Async/Await vs Callbacks")
            VStack {
                AsyncImage(url: viewModel.characterBasicInfo.image)
                Text("Name: \(viewModel.characterBasicInfo.name)")
                Text("First episode: \(viewModel.characterBasicInfo.fistEpisodeTitle)")
                Text("Dimension: \(viewModel.characterBasicInfo.dimension)")
            }
        }
        .onAppear{
            Task {
                await viewModel.executeRequestAsync()
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
