//
//  ContentView.swift
//  DynamicIsland
//
//  Created by Sebastian on 17/09/22.
//

import SwiftUI

enum ImageFrame: CGFloat {
    case collapse = 30
    case expanded = 80
}

struct DynamicIslandView: View {
    
    @Binding var expanded: Bool
   
    
    var body: some View {
        VStack {
            HStack {
                Image("Batman")
                    .resizable()
                    .frame(width: expanded ? ImageFrame.expanded.rawValue : ImageFrame.collapse.rawValue, height: expanded ? ImageFrame.expanded.rawValue : ImageFrame.collapse.rawValue)
                    .clipShape(Circle())
                    .padding(10)
                
                if expanded {
                    VStack(alignment: .leading) {
                        Text("Batman")
                            .font(.title)
                        Text("Under the hood")
                            .font(.caption)
                            .opacity(0.5)
                    }.foregroundColor(.white)
                }
                
                Spacer()
                Image(systemName: "chart.bar.fill")
                    .foregroundColor(.white)
                    .padding(10)
            }
            if expanded {
                HStack {
                    Image(systemName: "backward.fill")
                    Image(systemName: "play.fill")
                    Image(systemName: "forward.fill")
                }
                .foregroundColor(.white)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: expanded ? 200 : 60)
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.6, blendDuration: 1.0)) {
                expanded.toggle()
            }
        }
        .background(.black)
        .clipShape(RoundedRectangle(cornerRadius: 40.0, style: .continuous))
        .padding()
    }
}

struct ContentView: View {
    
    @State private var expanded: Bool = false
        
    var body: some View {
        VStack {
            DynamicIslandView(expanded: $expanded)
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
