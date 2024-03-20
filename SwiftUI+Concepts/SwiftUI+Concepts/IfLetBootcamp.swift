//
//  IfLetBootcamp.swift
//  SwiftUI+Concepts
//
//  Created by Juan Sebastian Bueno on 3/20/24.
//

import SwiftUI

struct IfLetBootcamp: View {
    
    @State var currentUserID: String? = "123"
    @State var displayText: String? = nil
    @State var isLoading: Bool = true
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Here we are practicing safe coding")
                if let text = displayText {
                    Text(text)
                        .font(.headline)                    
                }
                if isLoading {
                    ProgressView()
                }
                Spacer()
            }
            .navigationTitle("Safe coding")
            .onAppear{
                loadDataGuard()
            }
        }
    }
    
    func loadData() {
        if let userId = currentUserID {
            isLoading = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                displayText = "this is the new data User id is: \(userId)"
                isLoading = false
            })            
        } else {
            displayText = "Error. there is no user ID!"
        }
        
    }
    
    func loadDataGuard() {
        guard let userID = currentUserID else {
            displayText = "Error. there is no user ID!"
            return
        }
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            displayText = "this is the new data User id is: \(userID)"
            isLoading = false
        })    
    }
}

#Preview {
    IfLetBootcamp()
}
