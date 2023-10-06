//
//  ContentView.swift
//  SwiftUICrypto
//
//  Created by Juan Sebastian Bueno on 10/6/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
            Color.theme.background
                .ignoresSafeArea()
            
            VStack {
                Text("Accent Color")
                    .foregroundColor(Color.theme.accent)
                
                Text("Red color")
                    .foregroundColor(Color.theme.red)
                
                Text("Green color")
                    .foregroundColor(Color.theme.green)
                
                Text("Secondary text Color")
                    .foregroundColor(Color.theme.secondaryText)
            }
            .font(.headline)
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
