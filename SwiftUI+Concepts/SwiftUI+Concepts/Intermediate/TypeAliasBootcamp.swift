//
//  TypeAliasBootcamp.swift
//  SwiftUI+Concepts
//
//  Created by Juan Sebastian Bueno on 3/22/24.
//

typealias TvShow = MovieModel

import SwiftUI

struct MovieModel {
    let title: String
    let director: String
    let count: Int
}

struct TypeAliasBootcamp: View {
    
    @State var item: MovieModel = MovieModel(title: "sunshine", director: "JB", count: 12234)
    @State var tvShow: TvShow = TvShow(title: "Friends", director: "JSB", count: 12)
    var body: some View {
        VStack {
            Text(item.title)
            Text(item.director)
            Text("\(item.count)")
            
            Text(tvShow.title)
            Text(tvShow.director)
            Text("\(tvShow.count)")
        }
    }
}

#Preview {
    TypeAliasBootcamp()
}
