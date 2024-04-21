//
//  AnimationTiming.swift
//  SwiftUI+Concepts
//
//  Created by Juan Sebastian Bueno on 4/21/24.
//

import SwiftUI

struct AnimationTiming: View {
    @State var isAnimating: Bool = false
    let timing: Double = 0.5
    
    var body: some View {
        VStack {
            Button("animate") { 
                isAnimating.toggle()   
            }
            // same speed from start to end
            RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                .frame(width: isAnimating ? 350 : 50, height: 100)
                .animation(.spring(response: 0.5, 
                                   dampingFraction: 0.2, 
                                   blendDuration: 1.0)
                           , value: isAnimating)
            
            // slow first and fast ending 
            RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                .frame(width: isAnimating ? 350 : 50, height: 100)
                .animation(.easeIn(duration: timing), value: isAnimating)
            
            // slow fast slow
            RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                .frame(width: isAnimating ? 350 : 50, height: 100)
                .animation(.easeInOut(duration: timing), value: isAnimating)
            
            // fast slow
            RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                .frame(width: isAnimating ? 350 : 50, height: 100)
                .animation(.easeOut(duration: timing), value: isAnimating)
        }
    }
}

#Preview {
    AnimationTiming()
}
