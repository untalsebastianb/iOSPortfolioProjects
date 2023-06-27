//
//  HomeView.swift
//  RecipeSaver
//
//  Created by Juan Sebastian Bueno on 27/06/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            Text("My recipes")
                .navigationTitle("My Recipes")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
