//
//  UserContentListView.swift
//  ThreadsSwiftUI
//
//  Created by Juan Sebastian Bueno on 5/19/24.
//

import SwiftUI

struct UserContentListView: View {
    @State private var selectedFilter: ProfileThreadFilter = .threads
    @Namespace var animation
    private var filterBarWidht: CGFloat {
        let count = CGFloat(ProfileThreadFilter.allCases.count)
        return UIScreen.main.bounds.width / count - 20
    }
    var body: some View {
        VStack( content: {
            HStack(content: {
                ForEach(ProfileThreadFilter.allCases) { filter in
                    VStack(content: {
                        Text(filter.title)
                            .font(.subheadline)
                            .fontWeight(selectedFilter == filter ? .semibold : .regular)
                        
                        if selectedFilter == filter {
                            Rectangle()
                                .foregroundStyle(.black)
                                .frame(width: filterBarWidht, height: 1)
                                .matchedGeometryEffect(id: "item", in: animation)
                        } else {
                            Rectangle()
                                .foregroundStyle(.clear)
                                .frame(width: filterBarWidht, height: 1)
                        }
                    })
                    .onTapGesture {
                        withAnimation(.spring()) { 
                            selectedFilter = filter
                        }
                    }
                }
            })
            LazyVStack {
                ForEach(0 ... 10, id: \.self) { thread in
                    ThreadView(thread: DeveloperPreview.thread)
                }
            }
        })
        .padding(.vertical, 8)

    }
}

#Preview {
    UserContentListView()
}
