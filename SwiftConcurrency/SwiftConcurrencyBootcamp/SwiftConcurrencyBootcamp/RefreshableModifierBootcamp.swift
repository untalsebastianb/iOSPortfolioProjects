//
//  RefreshableModifierBootcamp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by Juan Sebastian Bueno on 3/16/24.
//

import SwiftUI

final class RefreshableDataService {
    func getData() async throws -> [String] {
        try? await Task.sleep(nanoseconds: 5_000_000_000) 
        return ["Apple", "Orange", "Banana"].shuffled()
    }
}

@MainActor
final class RefreshableModifierBootcampViewModel: ObservableObject {
    @Published private(set) var items: [String] = []
    private let manager = RefreshableDataService()
    
    
    func loadData() async {
            do {
                items = try await manager.getData()
            } catch {
                print(error)
            }
    }
    
}

struct RefreshableModifierBootcamp: View {
    
    @StateObject private var viewModel = RefreshableModifierBootcampViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    ForEach(viewModel.items, id: \.self) { item in
                        Text(item)
                            .font(.headline)
                    }
                }
            }
            .refreshable {
                await viewModel.loadData()
            }
            .navigationTitle("Refreshable")
//            .onAppear(perform: {
//                viewModel.loadData()
//            })
            .task { 
                await viewModel.loadData()
            }
        }
    }
}

#Preview {
    RefreshableModifierBootcamp()
}
