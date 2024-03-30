//
//  ViewBuilderBootcamp.swift
//  SwiftUI+Concepts
//
//  Created by Juan Sebastian Bueno on 3/30/24.
//

import SwiftUI

struct HeaderViewRegular: View {
    let title: String
    let description: String?
    let iconName: String?
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.semibold)
            if let description = description {
                Text(description)
                    .font(.callout)                
            }
            if let iconName = iconName {
                Image(systemName: iconName)
            }
            
            Divider()
        }
    }
}

struct HeaderViewGeneric<T: View>: View {
    let title: String
    let content: T
    
    // with this i can use the closure
    init(title: String, @ViewBuilder content: () -> T) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            content
            
            Divider()
        }
    }
}

struct CustomHStack<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    var body: some View {
        HStack {
            content
        }
    }
}

struct ViewBuilderBootcamp: View {
    var body: some View {
        VStack {
            HeaderViewRegular(title: "Hellow", description: "SB", iconName: "heart.fill")
            HeaderViewRegular(title: "Hi", description: nil, iconName: nil)
            HeaderViewGeneric(title: "With CLosure") { 
                Text(" view with CL")
                HStack {
                    Text("Hi")
                    Text("there")
                    Image(systemName: "heart")
                }
            }
            
            CustomHStack { 
                Text("this")
                Text("is")
                Text("my")
                Text("custom HSTACK")
            }
            
//            HeaderViewGeneric(title: "Generic Title", content: Image(systemName: "heart.fill"))
            
//            HeaderViewGeneric(title: "Bolt", content:
//                                HStack {
//                Text("Hello")
//                Image(systemName: "bolt.fill")
//            }
//            )
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        Spacer()
    }
}

struct LocalViewBuilder: View {
    
    enum ViewType {
        case one, two, three
    }
    
    let type: ViewType
    
    var body: some View {
        VStack {
            headerSection
        }
    }
    
    @ViewBuilder
    private var headerSection: some View {
        switch type {
        case .one:
            viewOne
        case .two:
            viewTwo
        case .three:
            viewThree
        }
    }
    
    private var viewOne: some View {
        Text("One")
    }
    
    private var viewTwo: some View {
        VStack {
            Text("Two")
            Image(systemName: "heart")
        }
    }
    
    private var viewThree: some View {
        Image(systemName: "heart.fill")
    }
}

#Preview {
    LocalViewBuilder(type: .three)
}
