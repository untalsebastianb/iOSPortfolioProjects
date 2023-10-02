//
//  RecipesViewModel.swift
//  RecipeSaver
//
//  Created by Juan Sebastian Bueno on 10/2/23.
//

import Foundation

public class RecipesViewModel: ObservableObject {
    @Published private(set)var recipes: [Recipe] = []
    
    init() {
        recipes = Recipe.all
    }
    
    func addRecipe(recipe: Recipe) {
        recipes.append(recipe)
    }
}
