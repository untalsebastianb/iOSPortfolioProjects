//
//  NetflixFilterBarView.swift
//  SwiftUIApps
//
//  Created by Juan Sebastian Bueno on 8/30/24.
//

import SwiftUI

struct FilterModel: Hashable, Equatable {
    let title: String
    let isDropDown: Bool
    
    static var mockArray: [FilterModel] {
        [
           FilterModel(title: "Tv Shows", isDropDown: false),
           FilterModel(title: "Movies", isDropDown: true),
           FilterModel(title: "Categories", isDropDown: true),
           
        ]
    }
}

struct NetflixFilterBarView: View {
    var filters: [FilterModel] = FilterModel.mockArray
    var selectedFilter: FilterModel? = nil 
    var onFilterPressed: ((FilterModel) -> Void)? = nil
    var onXmarkPressed: (() -> Void)? = nil
    var body: some View {
        ScrollView(.horizontal) { 
            HStack(content: {
                if selectedFilter != nil {
                    Image(systemName: "xmark")
                        .padding(8)
                        .background(
                            Circle()
                                .stroke(lineWidth: 1)
                        )
                        .foregroundStyle(.netflixLightGray)
                        .background(Color.black.opacity(0.001))
                        .onTapGesture {
                            onXmarkPressed?()
                        }
                        .offset(x: selectedFilter == nil ? 0 : -10)
                        .transition(.move(edge: .leading))
                        .padding(.leading, 16)
                }
                ForEach(filters, id: \.self) { filter in
                    // it just paint the filter i choose
                    if selectedFilter == nil || selectedFilter == filter {
                        NetflixFilterCell(
                            title: filter.title,
                            isDropdown: filter.isDropDown,
                            isSelected: selectedFilter == filter
                        )
                        .background(.black.opacity(0.001))
                        .onTapGesture {
                            onFilterPressed?(filter)
                        }
                        .padding(.leading, (selectedFilter == nil) && filter == filters.first ? 16 : 0)                        
                    }
                }
            })
            .padding(1)
        }
        .scrollIndicators(.hidden)
        .animation(.bouncy, value: selectedFilter)
    }
}

// make preview works like it was call site 🚨🎯
fileprivate struct NetflixFilterBarViewPreview: View {
    @State private var filters = FilterModel.mockArray
    @State private var selectedFilter: FilterModel? = nil
    var body: some View {
        VStack { 
//            if selectedFilter == nil {
//                Text("Select a filter")
//                    .foregroundStyle(.white)
//            }
            NetflixFilterBarView(
                filters: filters,
                selectedFilter: selectedFilter,
                onFilterPressed: { filter in
                   selectedFilter = filter
                },
                onXmarkPressed: { 
                    selectedFilter = nil
                })
            // i can do changes here is @State changes!!
//            if selectedFilter?.title == "Movies" {
//                Text("movies view")
//                    .foregroundStyle(.white)
//            }
            Text("Shuffle Filters")
                .foregroundStyle(.white)
                .onTapGesture { 
                    selectedFilter = nil
                    filters.reverse()
                }
        } 
        .frame(height: 500)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        NetflixFilterBarViewPreview()
    }
}
