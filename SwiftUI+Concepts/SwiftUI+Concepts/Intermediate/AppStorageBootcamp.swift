//
//  AppStorageBootcamp.swift
//  SwiftUI+Concepts
//
//  Created by Juan Sebastian Bueno on 9/4/24.
//

import SwiftUI

struct AppStorageBootcamp: View {
    @State var currentUserName: String?
    @AppStorage("current-name") var currentUserNameStorage: String?

    var body: some View {
        VStack(spacing: 20, content: {
            if let currentUserName {
                Text(" user Defaults -> \(currentUserName)")                
            }
            
            if let currentUserNameStorage {
                Text(" @AppStorage -> \(currentUserNameStorage)")                
            }
            Button("Save", action: {
                let name = "Juancho"
                let name2 = "Juancho@AppStorage"
                currentUserName = name
                currentUserNameStorage = name2
                UserDefaults.standard.setValue(name, forKey: "name")
            })
        })
        .onAppear(perform: {
            currentUserName = UserDefaults.standard.string(forKey: "name")
        })
    }
}

#Preview {
    AppStorageBootcamp()
}
