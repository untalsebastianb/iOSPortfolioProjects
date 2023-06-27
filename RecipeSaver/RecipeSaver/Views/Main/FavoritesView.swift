//
//  FavoritesView.swift
//  RecipeSaver
//
//  Created by Juan Sebastian Bueno on 27/06/23.
//

import SwiftUI

struct FavoritesView: View {
    var body: some View {
        NavigationView {
            Text("Favorites")
                .navigationTitle("Favorites")
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
