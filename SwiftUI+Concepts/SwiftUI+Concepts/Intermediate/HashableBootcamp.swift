//
//  HashableBootcamp.swift
//  SwiftUI+Concepts
//
//  Created by Juan Sebastian Bueno on 3/21/24.
//

import SwiftUI

struct myCustomModel: Hashable {
    let title: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
}

struct HashableBootcamp: View {
    
    let data: [myCustomModel] = [
        myCustomModel(title: "1"),
        myCustomModel(title: "2"),
        myCustomModel(title: "3"),
        myCustomModel(title: "4"),
        myCustomModel(title: "5")
    ]
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                ForEach(data, id: \.self) { item in
                    //-> Hash value Text(item.hashValue.description)
                    Text(item.title)
                        .font(.headline)
                }
            }
        }
    }
}

#Preview {
    HashableBootcamp()
}
