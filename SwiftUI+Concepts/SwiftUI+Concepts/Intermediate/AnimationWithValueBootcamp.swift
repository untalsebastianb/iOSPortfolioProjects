//
//  AnimationWithValueBootcamp.swift
//  SwiftUI+Concepts
//
//  Created by Juan Sebastian Bueno on 9/4/24.
//

import SwiftUI

struct AnimationWithValueBootcamp: View {
    @State private var animate1: Bool = false
    @State private var animate2: Bool = false
    var body: some View {
        ZStack(content: {
            VStack(spacing: 40) { 
                Button("Action 1", action: {
                    animate1.toggle()
                })
                Button("Action 2", action: {
                    animate2.toggle()
                })
                ZStack {
                    Rectangle()
                        .frame(width: 100, height: 100)
                        .frame(maxWidth: .infinity, alignment: animate1 ? .leading : .trailing)
                        .frame(maxHeight: .infinity, alignment: animate2 ? .top : .bottom)
                        .background(.gray)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.red)
            }
        })
        .animation(.bouncy, value: animate1)
        .animation(.linear(duration: 1), value: animate2)
        // with this I can not do animation in only one value
//        .animation(.smooth)
    }
}

#Preview {
    AnimationWithValueBootcamp()
}
