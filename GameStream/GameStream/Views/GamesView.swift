//
//  GamesView.swift
//  GameStream
//
//  Created by Sebastian on 14/04/22.
//

import SwiftUI

struct GamesView: View {
    var body: some View {
        Text("Hello, fron games view!")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .onAppear {
                print("First element of json:")
                print("The view is showing")
            }
    }
}

struct GamesView_Previews: PreviewProvider {
    static var previews: some View {
        GamesView()
    }
}
