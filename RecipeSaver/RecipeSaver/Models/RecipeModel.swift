//
//  RecipeModel.swift
//  RecipeSaver
//
//  Created by Juan Sebastian Bueno on 27/06/23.
//

import Foundation

enum Category: String, CaseIterable, Identifiable {
    var id: String { self.rawValue }
    case breakfast = "Breakfast"
    case soup = "Soup"
    case salad = "Salad"
    case appetizer = "Appetizer"
    case main = "Main"
    case side = "Side"
    case dessert = "Dessert"
    case snack = "Snack"
    case drink = "Drink"
}

struct Recipe: Identifiable {
    let id = UUID()
    let name: String
    let image: String
    let description: String
    let ingredients: String
    let directions: String
    let category: Category.RawValue
    let datePublished: String
    let url: String
}

extension Recipe {
    static let all: [Recipe] = [
        // Example recipes
        Recipe(name: "Alfredo Sauce", image: "recipe0", description: "Creamy homemade Alfredo sauce.", ingredients: "1 cup heavy cream, 1/2 cup grated Parmesan cheese, 2 cloves of garlic, salt and pepper to taste.", directions: "In a saucepan, heat the heavy cream over medium heat. Add grated Parmesan cheese, minced garlic, salt, and pepper. Stir until the cheese melts and the sauce thickens. Serve over pasta.", category: "Main", datePublished: "2022-05-15", url: "https://www.example.com/alfredo-sauce"),
        Recipe(name: "Chicken Stir-Fry", image: "recipe1", description: "Quick and easy chicken stir-fry with vegetables.", ingredients: "1 lb chicken breast, sliced\n2 cups mixed vegetables\n3 tablespoons soy sauce\n1 tablespoon sesame oil\n1 teaspoon ginger, minced\n1 clove garlic, minced\nSalt and pepper to taste", directions: "In a large skillet, heat the sesame oil over medium-high heat. Add minced ginger and garlic, and sauté for a minute. Add chicken slices and cook until browned. Add mixed vegetables and cook until tender. Stir in soy sauce, salt, and pepper. Serve hot.", category: "Main", datePublished: "2022-07-02", url: "https://www.example.com/chicken-stir-fry"),
        Recipe(name: "Classic Margherita Pizza", image: "recipe2", description: "Authentic Italian Margherita pizza with fresh basil and tomatoes.", ingredients: "1 pizza dough\n1/2 cup tomato sauce\n1 cup mozzarella cheese\nFresh basil leaves\nSliced tomatoes\nSalt and pepper to taste", directions: "Preheat the oven to 450°F (230°C). Roll out the pizza dough into a round shape. Spread tomato sauce evenly on the dough. Sprinkle mozzarella cheese over the sauce. Arrange sliced tomatoes on top. Season with salt and pepper. Bake in the preheated oven for about 12-15 minutes or until the crust is golden and the cheese is melted. Garnish with fresh basil leaves. Slice and serve.", category: "Main", datePublished: "2022-09-20", url: "https://www.example.com/margherita-pizza"),
        Recipe(name: "Chocolate Chip Cookies", image: "recipe3", description: "Classic homemade chocolate chip cookies.", ingredients: "1 cup butter, softened\n1 cup granulated sugar\n1 cup brown sugar\n2 large eggs\n1 teaspoon vanilla extract\n2 1/2 cups all-purpose flour\n1 teaspoon baking soda\n1/2 teaspoon salt\n2 cups chocolate chips", directions: "Preheat the oven to 375°F (190°C). In a large bowl, cream together the butter, granulated sugar, and brown sugar until smooth. Beat in the eggs and vanilla extract. In a separate bowl, whisk together the flour, baking soda, and salt. Gradually add the dry ingredients to the butter mixture and mix well. Stir in the chocolate chips. Drop rounded tablespoons of dough onto ungreased baking sheets. Bake for 9-11 minutes or until golden brown. Allow to cool on baking sheets for a few minutes, then transfer to wire racks to cool completely.", category: "Dessert", datePublished: "2022-11-10", url: "https://www.example.com/chocolate-chip-cookies"),
        Recipe(name: "Grilled Steak", image: "recipe4", description: "Juicy and flavorful grilled steak.", ingredients: "2 lbs steak (such as ribeye or sirloin)\n2 tablespoons olive oil\n2 cloves garlic, minced\n1 teaspoon salt\n1/2 teaspoon black pepper\n1 teaspoon dried herbs (such as thyme or rosemary)", directions: "Preheat the grill to high heat. In a small bowl, mix together the olive oil, minced garlic, salt, pepper, and dried herbs. Brush the mixture onto both sides of the steak. Place the steak on the hot grill and cook for about 4-5 minutes per side for medium-rare, or adjust the cooking time to your desired level of doneness. Remove the steak from the grill and let it rest for a few minutes before slicing. Serve hot.", category: "Main Dish", datePublished: "2022-08-05", url: "https://www.example.com/grilled-steak"),
        Recipe(name: "Caprese Salad", image: "recipe5", description: "Fresh and light Caprese salad with tomatoes, mozzarella, and basil.", ingredients: "4 ripe tomatoes\n8 oz fresh mozzarella cheese\nFresh basil leaves\n2 tablespoons extra virgin olive oil\n1 tablespoon balsamic vinegar\nSalt and pepper to taste", directions: "Slice the tomatoes and mozzarella cheese into thick slices. Arrange them on a serving platter, alternating tomato and mozzarella slices. Place fresh basil leaves on top. Drizzle with olive oil and balsamic vinegar. Season with salt and pepper. Let the salad sit for a few minutes to allow the flavors to meld together. Serve at room temperature.", category: "Salad", datePublished: "2022-06-30", url: "https://www.example.com/caprese-salad"),
        Recipe(name: "Chicken Parmesan", image: "recipe6", description: "Classic Italian chicken Parmesan with crispy breaded chicken and melted cheese.", ingredients: "4 boneless, skinless chicken breasts\n1 cup breadcrumbs\n1/2 cup grated Parmesan cheese\n2 eggs, beaten\n1 cup marinara sauce\n1 cup shredded mozzarella cheese\n1/4 cup chopped fresh basil\nSalt and pepper to taste", directions: "Preheat the oven to 375°F (190°C). Season the chicken breasts with salt and pepper. In a shallow dish, mix together the breadcrumbs and grated Parmesan cheese. Dip each chicken breast into the beaten eggs, then coat with the breadcrumb mixture. Place the breaded chicken breasts in a greased baking dish. Bake for 25 minutes or until the chicken is cooked through and the breading is crispy. Spoon marinara sauce over the chicken and sprinkle with shredded mozzarella cheese. Return to the oven and bake for an additional 5 minutes or until the cheese is melted and bubbly. Garnish with chopped fresh basil before serving.", category: "Italian", datePublished: "2022-12-02", url: "https://www.example.com/chicken-parmesan"),
        Recipe(name: "Berry Smoothie", image: "recipe7", description: "Refreshing and healthy berry smoothie.", ingredients: "1 cup mixed berries (strawberries, blueberries, raspberries)\n1 banana\n1 cup Greek yogurt\n1/2 cup milk (or dairy-free alternative)\n1 tablespoon honey\nIce cubes", directions: "In a blender, combine the mixed berries, banana, Greek yogurt, milk, honey, and a handful of ice cubes. Blend until smooth and creamy. If desired, add more milk for a thinner consistency. Pour into glasses and serve immediately.", category: "Beverage", datePublished: "2022-09-15", url: "https://www.example.com/berry-smoothie"),
        Recipe(name: "Vegetable Stir-Fry", image: "recipe8", description: "Colorful and nutritious vegetable stir-fry.", ingredients: "2 cups mixed vegetables (such as bell peppers, broccoli, carrots, snap peas)\n2 tablespoons soy sauce\n1 tablespoon sesame oil\n1 tablespoon vegetable oil\n1 teaspoon ginger, minced\n1 clove garlic, minced\nSalt and pepper to taste", directions: "Heat the vegetable oil and sesame oil in a large skillet or wok over medium-high heat. Add minced ginger and garlic, and sauté for a minute. Add mixed vegetables and stir-fry until tender-crisp. Stir in soy sauce, salt, and pepper. Cook for an additional minute. Serve hot as a side dish or over rice or noodles as a main course.", category: "Snack", datePublished: "2022-10-18", url: "https://www.example.com/vegetable-stir-fry"),
        Recipe(name: "Banana Bread", image: "recipe9", description: "Moist and delicious homemade banana bread.", ingredients: "3 ripe bananas\n1/2 cup unsalted butter, melted\n1 cup granulated sugar\n2 large eggs\n1 teaspoon vanilla extract\n1 3/4 cups all-purpose flour\n1 teaspoon baking soda\n1/2 teaspoon salt\n1/2 cup chopped walnuts (optional)", directions: "Preheat the oven to 350°F (175°C). In a mixing bowl, mash the ripe bananas with a fork. Add melted butter, granulated sugar, eggs, and vanilla extract. Mix well. In a separate bowl, whisk together the flour, baking soda, and salt. Gradually add the dry ingredients to the banana mixture and stir until just combined. Fold in chopped walnuts, if desired. Pour the batter into a greased loaf pan. Bake for 55-60 minutes or until a toothpick inserted into the center comes out clean. Allow the banana bread to cool in the pan for 10 minutes, then transfer to a wire rack to cool completely before slicing.", category: "Snack", datePublished: "2022-07-25", url: "https://www.example.com/banana-bread")
    ]
}
