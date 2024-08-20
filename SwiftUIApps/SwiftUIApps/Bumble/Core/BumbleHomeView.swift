//
//  BumbleHomeView.swift
//  SwiftUIApps
//
//  Created by Juan Sebastian Bueno on 8/19/24.
//

import SwiftUI

/***
 one way to center things in with Zstack giving different frame alignment
 this time we are using .frame(maxWidth, and aligned every item to each side with no Zstack
 ***/

struct BumbleHomeView: View {
    @State private var options: [String] = ["Everyone", "Trending"]
    @AppStorage("bumble_home_filter") private var selectedFilter = "Everyone"
    var body: some View {
        ZStack { 
            VStack(spacing: 12, content: {
                header
                BumbleFilterView(options: options, selection: $selectedFilter)
                    .background(
                        Divider(), alignment: .bottom
                    )
                Spacer()
            })
            .padding(8)
        }
    }
    
    private var header: some View {
        HStack(spacing: 0, content: {
            HStack(spacing: 0, content: {
                Image(systemName: "line.horizontal.3")
                    .padding(8)
                    .background(.black.opacity(0.001))
                    .onTapGesture {
                        
                    }
                Image(systemName: "arrow.uturn.left")
                    .padding(8)
                    .background(.black.opacity(0.001))
                    .onTapGesture {
                        
                    }
                
            })
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("bumble")
                .font(.title)
                .foregroundStyle(.bumbleYellow)
                .frame(maxWidth: .infinity, alignment: .center)
            
            Image(systemName: "slider.horizontal.3")
                .padding(8)
                .background(.black.opacity(0.001))
                .onTapGesture {
                    
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
        })
        .font(.title2)
        .fontWeight(.medium)
        .foregroundStyle(.bumbleBlack)
    }
}

#Preview {
    BumbleHomeView()
}
