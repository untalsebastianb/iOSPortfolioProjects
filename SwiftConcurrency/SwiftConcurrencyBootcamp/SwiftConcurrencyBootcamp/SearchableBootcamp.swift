//
//  SearchableBootcamp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by Juan Sebastian Bueno on 3/18/24.
//

import SwiftUI
import Combine

enum CuisineOption: String {
    case american, italian, japanese, street
}

struct Restaurant: Identifiable, Hashable {
    let id: String
    let title: String
    let cuisine: CuisineOption
}

final class RestaurantManager {
    
    
    func getAllRestaurants() async throws -> [Restaurant] {
        [
            Restaurant(id: "1", title: "Burger2 Shack", cuisine: .american),
            Restaurant(id: "2", title: "Pasta Palace", cuisine: .italian),
            Restaurant(id: "3", title: "Sushi Heaven", cuisine: .japanese)
        ]
    }
}

@MainActor final class SearchableBootcampViewModel: ObservableObject {
    
    let manager = RestaurantManager()
    @Published private(set) var allRestaurants: [Restaurant] = []
    @Published private(set) var filteredRestaurants: [Restaurant] = []
    @Published var searchText: String = ""
    @Published var searchScope: SearchScopeOption = .all
    @Published private(set) var allSearchScopes: [SearchScopeOption] = []
    private var cancellables = Set<AnyCancellable>()
    var isSearching: Bool {
        !searchText.isEmpty
    }
    
    var showSearchSuggestion: Bool {
        searchText.count < 5
    }
    
    enum SearchScopeOption: Hashable {
        case all
        case cuisine(option: CuisineOption)
        
        var title: String {
            switch self {
            case .all:
                return "All"
            case .cuisine(option: let option):
                return option.rawValue.capitalized
            }
        }
    }
    
    init () {
        addSubscribers()
    }
    
    private func addSubscribers() {
        $searchText
            .combineLatest($searchScope)
            .debounce(for: 0.3, scheduler: DispatchQueue.main)
            .sink { [weak self] (searchText, searchScope) in
                self?.filterRestaurants(searchText: searchText, searchScope: searchScope)
            }
            .store(in: &cancellables)
    }
    
    private func filterRestaurants(searchText: String, searchScope: SearchScopeOption) {
        guard !searchText.isEmpty else {
            filteredRestaurants = []
            self.searchScope = .all
            return
        }
        // Filter on search Scope
        var restaurantsInScope = allRestaurants
        switch searchScope {
        case .all:
            break
        case .cuisine(option: let option):
            restaurantsInScope = allRestaurants.filter({ restaurant in
                return restaurant.cuisine == option
            })
        }
        
        
        // Filter on Search Text
        let search = searchText.lowercased()
        filteredRestaurants = restaurantsInScope.filter({ restaurant in
            let titleContainSearch = restaurant.title.lowercased().contains(search)
            let cuisineContainSearch = restaurant.cuisine.rawValue.lowercased().contains(search)
            return titleContainSearch || cuisineContainSearch
        })
    }
    
    func loadRestaurants() async {
        do {
            allRestaurants = try await manager.getAllRestaurants()
            print("🔥 \(allRestaurants)")
            let allCuisines = Set(allRestaurants.map { $0.cuisine })
            allSearchScopes = [.all] + allCuisines.map({ option in
                SearchScopeOption.cuisine(option: option)
            })
        } catch {
            print(error)
        }
    }
    
    func getSearchSuggestions() -> [String] {
        guard showSearchSuggestion else {
            return []
        }
        var suggestions: [String] = []
        let search = searchText.lowercased()
        if search.contains("pa") {
            suggestions.append("pasta")
        }
        if search.contains("su") {
            suggestions.append("sushi")
        }
        if search.contains("bu") {
            suggestions.append("burger")
        }
        suggestions.append("Market")
        suggestions.append("Grocery")
        suggestions.append(CuisineOption.italian.rawValue.capitalized)
        suggestions.append(CuisineOption.japanese.rawValue.capitalized)
        suggestions.append(CuisineOption.american.rawValue.capitalized)
        
        return suggestions
    }
    
    func getRestaurantSuggestions() -> [Restaurant] {
        guard showSearchSuggestion else {
            return []
        }
        var suggestions: [Restaurant] = []
        let search = searchText.lowercased()
        if search.contains("ita") {
            suggestions.append(contentsOf: allRestaurants.filter({ $0.cuisine == .italian}))
        }
        if search.contains("jap") {
            suggestions.append(contentsOf: allRestaurants.filter({ $0.cuisine == .japanese}))
        }
        
        return suggestions
    }
}

struct SearchableBootcamp: View {
    
    @StateObject private var viewModel = SearchableBootcampViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.isSearching ? viewModel.filteredRestaurants : viewModel.allRestaurants) { restaurant in
                    NavigationLink(value: restaurant) {
                        restaurantRow(restaurant: restaurant)                        
                    }
                }
            }
            .padding()
            .searchable(text: $viewModel.searchText, prompt: "Search restaurants...")
            .searchScopes($viewModel.searchScope, scopes: { 
                ForEach(viewModel.allSearchScopes, id: \.self) { scope in
                    Text(scope.title)
                        .tag(scope)
                }
            })
            .searchSuggestions({ 
                ForEach(viewModel.getSearchSuggestions(), id: \.self) { suggestion in   
                    Text(suggestion)
                        .searchCompletion(suggestion)
                }
                
                ForEach(viewModel.getRestaurantSuggestions(), id: \.self) { suggestion in   
                    NavigationLink(value: suggestion) {
                        Text(suggestion.title)
                    }
                }
            })
            .navigationTitle("Restaurants")
            .task {
                await viewModel.loadRestaurants()
            }
            .navigationDestination(for: Restaurant.self) { restaurant in
                Text(restaurant.title.uppercased())
            }
        }
    }
    
  
    
    private func restaurantRow(restaurant: Restaurant) -> some View {
        VStack(alignment: .leading, spacing: 10, content: {
            Text(restaurant.title)
                .font(.headline)
                .foregroundStyle(.red)
            Text(restaurant.cuisine.rawValue.capitalized)
                .font(.caption)
        })
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.black.opacity(0.05))
        .cornerRadius(20)
        .tint(.primary)
    }
}
#Preview {
    NavigationStack {
        SearchableBootcamp()        
    }
}
