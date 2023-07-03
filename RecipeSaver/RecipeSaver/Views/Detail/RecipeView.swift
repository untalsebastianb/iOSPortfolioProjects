//
//  RecipeView.swift
//  RecipeSaver
//
//  Created by Juan Sebastian Bueno on 3/07/23.
//

import SwiftUI

struct RecipeView: View {
    var recipe: Recipe
    var body: some View {
        ScrollView {
            Image(recipe.image)
                .resizable()
                .frame(width: .infinity, height: 300)
                .background(LinearGradient(gradient: Gradient(colors: [Color(.gray).opacity(0.3), Color(.gray)]), startPoint: .top, endPoint: .bottom))
                .ignoresSafeArea(.container, edges: .top)


            VStack(spacing: 30) {
                Text(recipe.name)
                    .font(.largeTitle)
                    .bold()
                    .multilineTextAlignment(.center)

                VStack(alignment: .leading, spacing: 30) {
                    Text(recipe.description)

                    VStack(alignment: .leading, spacing: 20) {
                        Text("Ingredients")
                            .font(.headline)

                        Text(recipe.ingredients)
                    }

                    VStack(alignment: .leading, spacing: 20) {
                        Text("Directions")
                            .font(.headline)

                        Text(recipe.directions)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            }
        }
    }
}

struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(recipe: Recipe.all[0])
    }
}
