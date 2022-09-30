//
//  ContentView.swift
//  Instagram-SwiftUI
//
//  Created by Sebastian on 29/09/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Text("Hola")
                }
                .toolbar {
                    self.toolbarView()
                }
            }
        }
    }
    
    
    @ToolbarContentBuilder
    func toolbarView() -> some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button(action: {}) {
                Image("camera-Icon")
            }
        }
        
        ToolbarItem(placement: .principal) {
            Image("instagram-logo")
        }
        
        ToolbarItem(placement: .navigationBarTrailing) {
            HStack {
                Button(action: {}) {
                    Image("igtv")
                }
                Button(action: {}) {
                    Image("messanger")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
