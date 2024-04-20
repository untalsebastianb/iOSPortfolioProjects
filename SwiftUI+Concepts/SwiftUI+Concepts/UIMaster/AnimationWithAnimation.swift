//
//  AnimationWithAnimation.swift
//  SwiftUI+Concepts
//
//  Created by Juan Sebastian Bueno on 4/20/24.
//

import SwiftUI

struct AnimationWithAnimation: View {
    @State var isAnimated: Bool = false
    var body: some View {
        VStack {
            Button("Button") { 
                isAnimated.toggle()
//                withAnimation(.default.delay(2.0)) {
//                    isAnimated.toggle()                    
//                }
                
//                withAnimation(Animation.default.repeatCount(5, autoreverses: false)) {
//                    isAnimated.toggle()                    
//                }
                
//                withAnimation(Animation.default.repeatForever(autoreverses: true)) {
//                    isAnimated.toggle()                    
//                }
            }
            Spacer()
            RoundedRectangle(cornerRadius: isAnimated ? 50 : 25)
                .fill(isAnimated ? .red : .green)
                .frame(width: isAnimated ? 100 : 300,
                       height: isAnimated ? 100 : 300)
                .rotationEffect(Angle(degrees: isAnimated ? 360 : 0))
                .offset(y: isAnimated ? 300: 0)
                .animation(.default, value: isAnimated)
            Spacer()
        }
    }
}

#Preview {
    AnimationWithAnimation()
}
