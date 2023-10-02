//
//  CategoriesView.swift
//  RecipeSaver
//
//  Created by Juan Sebastian Bueno on 27/06/23.
//

import SwiftUI

struct CategoriesView: View {
    @EnvironmentObject var recipesVM: RecipesViewModel
    var body: some View {
        NavigationView {
            List {
                ForEach(Category.allCases) { category in
                    NavigationLink {
                        ScrollView {
                            RecipeList(recipes: recipesVM.recipes.filter{ $0.category == category.rawValue })
                        }
                        .navigationTitle(category.rawValue + "s")
                    } label: {
                        Text(category.rawValue + "s")
                    }

                }
            }
                .navigationTitle("Categories")
        }
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView()
            .environmentObject(RecipesViewModel())
    }
}
