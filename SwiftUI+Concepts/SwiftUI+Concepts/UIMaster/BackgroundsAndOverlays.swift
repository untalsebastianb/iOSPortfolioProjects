//
//  BackgroundsAndOverlays.swift
//  SwiftUI+Concepts
//
//  Created by Juan Sebastian Bueno on 4/16/24.
//

import SwiftUI

struct BackgroundsAndOverlays: View {
    var body: some View {
        
        Image(systemName: "heart.fill")
            .foregroundStyle(.white)
            .font(.system(size: 40)) // or resizable frame40
            .background(
                Circle()
                    .fill(
                        LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading
                                       , endPoint: .trailing)
                    )
                    .frame(width: 100, height: 100)
                    .shadow(radius: 5, x: 0.0, y: 10)
                    .overlay(alignment: .bottomTrailing, content: { 
                        Circle()
                            .fill(.red)
                            .frame(width: 35, height: 35)
                            .overlay(alignment: .center) { 
                                Text("6")
                                    .font(.headline)
                                    .foregroundStyle(.white)
                            }
                        .shadow(radius: 5, x: 5, y: 5)
                    })
            )
//            .resizable()
//            .frame(width: 40, height: 40, alignment: .center)
        
        
//        Text("Hello, World!")
//            .background(
//                Circle()
//                    .fill(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/))
//                    .frame(width: 100, height: 100)
//            )
//            .background(
//                Circle()
//                    .fill(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/))
//                    .frame(width: 120, height: 120, alignment: .center)
//            )
        
//        Circle()
//            .fill(.pink)
//            .frame(width: 100, height: 100, alignment: .center)
//            .overlay { 
//                Text("1")
//                    .font(.largeTitle)
//                    .foregroundStyle(.white)
//            }
//            .background(
//                Circle()
//                    .fill(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/))
//                    .frame(width: 120, height: 120, alignment: .center)
//            )
        
//        VStack(spacing: 40) {
//            Rectangle()
//                .frame(width: 100, height: 100)
//                .overlay(alignment: .topLeading) { 
//                    Rectangle()
//                        .fill(.blue)
//                        .frame(width: 50, height: 50)
//                }
//                .background(alignment: .bottomTrailing) { 
//                    Rectangle()
//                        .fill(.red)
//                        .frame(width: 150, height: 150)
//                }
//            
//            Text("Hello World")
//                .background(.red)
//                .frame(width: 100, height: 70, alignment: .center)
//                .background(.blue)
//                .frame(width: 150, height: 150, alignment: .top)
//                .background(.green)
//            
//        }
    }
}

#Preview {
    BackgroundsAndOverlays()
}
