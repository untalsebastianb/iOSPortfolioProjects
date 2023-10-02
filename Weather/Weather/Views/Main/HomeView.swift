//
//  HomeView.swift
//  Weather
//
//  Created by Juan Sebastian Bueno on 9/30/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            ZStack {
                // MARK: Background Color
                Color.background
                    .ignoresSafeArea()
                
                // MARK: Background Image
                Image("Background")
                    .resizable()
                    .ignoresSafeArea()
                
                // MARK: House Image
                Image("House")
                    .frame(maxHeight: .infinity, alignment: .top)
                    .padding(.top, 257)
                
                // MARK: Info Weather Vstack
                VStack {
                    Text("Montreal")
                        .font(.largeTitle)
                    
                    
                    VStack { 
                        Text(attributedString)
                        Text("H24°   L:18°")
                            .font(.title3)
                            .fontWeight(.semibold)
                    }
                    Spacer()
                    
                }
                .padding(.top, 51)
                
    //            MARK: Tab Bar
                TabBar { 
                }

            }
            .navigationBarHidden(true)
        }
    }
    private var attributedString: AttributedString {
        var string = AttributedString("19°" + "\n " + "Mostly Clear")
        if let temp = string.range(of: "19°") {
            string[temp].font = .system(size: 96, weight: .thin)
            string[temp].foregroundColor = .primary
        }
        
        if let pipe = string.range(of: "|") {
            string[pipe].font = .title3.weight(.semibold)
            string[pipe].foregroundColor = .secondary
        }
        
        if let weather = string.range(of: "Mostly Clear") {
            string[weather].font = .title3.weight(.semibold)
            string[weather].foregroundColor = .secondary
        }
        return string
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
    }
}
