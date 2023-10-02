//
//  AddRecipeView.swift
//  RecipeSaver
//
//  Created by Juan Sebastian Bueno on 10/2/23.
//

import SwiftUI

struct AddRecipeView: View {
    @State private var name: String = ""
    @State private var selectedCategory: Category = .main
    @State private var description: String = ""
    @State private var ingredients: String = ""
    @State private var directions: String = ""
    @State private var navigateToRecipe = false
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var recipesVM: RecipesViewModel
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Name")) { 
                    TextField("Recipe Name", text: $name)
                }
                Section(header: Text("Category")) { 
                    Picker("Category", selection: $selectedCategory) {
                        ForEach(Category.allCases) {category in 
                            Text(category.rawValue)
                                .tag(category)
                        }
                    }
                }
                Section(header: Text("Description")) { 
                    TextEditor(text: $description)
                }
                Section(header: Text("Ingredients")) { 
                    TextEditor(text: $ingredients)
                }
                Section(header: Text("Directions")) { 
                    TextEditor(text: $directions)
                }
            }
            .toolbar(content: { 
                //MARK: X button
                ToolbarItem(placement: .navigationBarLeading) { 
                    Button { 
                        dismiss()
                    } label: { 
                        Label("Cancel", systemImage: "xmark")
                            .labelStyle(.iconOnly)
                    }

                }
                
                ToolbarItem(placement: .navigationBarTrailing) { 
                    NavigationLink(isActive: $navigateToRecipe) { 
                        RecipeView(recipe: recipesVM.recipes.sorted { $0.datePublished > $1.datePublished }[0])
                            .navigationBarBackButtonHidden(true)
                    } label: { 
                        Button { 
                            saveRecipe()
                            navigateToRecipe.toggle()
                        } label: { 
                            Label("Done", systemImage: "checkmark")
                                .labelStyle(.iconOnly)
                        }
                       
                    }
                    .disabled(name.isEmpty)
                }
            })
            .navigationTitle("New Recipe")
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationViewStyle(.stack)
    }
}

struct AddRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        AddRecipeView()
            .environmentObject(RecipesViewModel())
    }
}

extension AddRecipeView {
    private func saveRecipe() {
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        let datePublished = dateFormatter.string(from: now)
        let recipe = Recipe(name: name,
                            image: "",
                            description: description,
                            ingredients: ingredients,
                            directions: directions,
                            category: selectedCategory.rawValue,
                            datePublished: datePublished,
                            url: "")
        recipesVM.addRecipe(recipe: recipe)
    }
    
}
