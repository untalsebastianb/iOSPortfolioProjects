//
//  AligmentGuideBootcamp.swift
//  SwiftUI+Concepts
//
//  Created by Juan Sebastian Bueno on 3/27/24.
//

import SwiftUI

struct AligmentGuideBootcamp: View {
    var body: some View {
        
//        GeometryExample()
//        GeoEx2()

        VStack(alignment: .leading) {
            Text("Hello, World!")
                .background(.red)
                
            
            Text("this is Other, World!")
                .background(.blue)
        }.overlay(ShowSize())
        .background(.orange)
    }
}

struct ShowSize: View {
    var comment: String = ""
    var body: some View {
        GeometryReader(content: { proxy in
            ZStack(alignment: .topLeading, content: {
                Rectangle()
                    .strokeBorder(.red, style: StrokeStyle(dash: [1, 0, 1]))
                Text("w:\(String(format: "%.2f", proxy.size.width)) h:\(String(format: "%.2f", proxy.size.height)) - \(comment)")
                    .font(.footnote)
                    .foregroundColor(.white)
                    .padding(5)
                    .background(Color.black.opacity(0.5))
                    .offset(y: proxy.size.height)
            })
        })
    }
}


struct GeoEx2: View {
    var body: some View {
        VStack {
            GeometryReader { geometry in
                Rectangle()
                    .fill(Color.red)
                    .frame(width: geometry.size.width, height: 50)
                    .overlay(
                        Text("Hello, World!")
                            .background(Color.blue)
                            .onAppear {
                                print("Text width: \(geometry.size.width), height: \(geometry.size.height)")
                            }
                    )
            }
            .frame(height: 200)
        }
    }
}

struct GeometryExample: View {
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("Width: \(geometry.size.width)")
                Text("Height: \(geometry.size.height)")
            }
            .frame(width: 200, height: 100)
            .border(Color.black)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


#Preview {
    AligmentGuideBootcamp()
}
