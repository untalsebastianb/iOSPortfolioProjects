//
//  CategoriesView.swift
//  RecipeSaver
//
//  Created by Juan Sebastian Bueno on 27/06/23.
//

import SwiftUI

struct CategoriesView: View {
    var body: some View {
        NavigationView {
            Text("Categories")
                .navigationTitle("Categories")
        }
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView()
    }
}
