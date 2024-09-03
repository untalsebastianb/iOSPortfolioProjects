//
//  MyListButton.swift
//  SwiftUIApps
//
//  Created by Juan Sebastian Bueno on 9/3/24.
//

import SwiftUI

struct MyListButton: View {
    var isMyList: Bool = false
    var onButtonPressed: (() -> Void)? = nil

    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                Image(systemName: "checkmark")
                    .opacity(isMyList ? 1 : 0)
                    .rotationEffect(Angle(degrees: isMyList ? 0 : 180))
                Image(systemName: "plus")
                    .opacity(isMyList ? 0 : 1)
                    .rotationEffect(Angle(degrees: isMyList ? -180 : 0))
            }
            .font(.title)

            Text("My List")
                .font(.caption)
                .foregroundStyle(.netflixLightGray)
        }
        .foregroundStyle(.netflixWhite)
        .padding(8)
        .background(.clear)
        .animation(.bouncy, value: isMyList)
        .onTapGesture {
            onButtonPressed?()
        }
    }
}

fileprivate struct MyListButtonpreview: View {
    @State private var isMyList: Bool = false
    var body: some View {
        MyListButton(isMyList: isMyList, onButtonPressed: {
            isMyList.toggle()
        })
    }
}

#Preview {
    ZStack(content: {
        Color.black.ignoresSafeArea()    
        MyListButtonpreview()
    })
}
