//
//  GenericsBootcamp.swift
//  SwiftUI+Concepts
//
//  Created by Juan Sebastian Bueno on 3/21/24.
//

import SwiftUI

class GenericsViewModel: ObservableObject {
    @Published var dataArray: [String] = []
    
    init() {
        dataArray = ["one", "two", "three"]
    }
    
    func removeDataFromDataArray() {
        dataArray.removeAll()
    }
}

struct GenericsBootcamp: View {
    
    @StateObject private var vm = GenericsViewModel()
    
    var body: some View {
        VStack {
            ForEach(vm.dataArray, id: \.self) { item in
                Text(item)
                    .onTapGesture {
                        vm.removeDataFromDataArray()
                    }
            }
        }
    }
}

#Preview {
    GenericsBootcamp()
}
