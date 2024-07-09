//
//  Transition.swift
//  SwiftUI+Concepts
//
//  Created by Juan Sebastian Bueno on 4/21/24.
//

import SwiftUI

struct Transition: View {
    @State var showView: Bool = false
    var body: some View {
        ZStack(alignment: .bottom) { 
            VStack {
                Button("Button") { 
                    // to make transitions work animation needs to be on the state toggle
                    withAnimation(.spring) { 
                        showView.toggle()
                    }
                }
                Spacer()
            }
            
            // the view is already in the hierarchy 
            // transition is when view is added to hierarchy
            if showView {
                RoundedRectangle(cornerSize: CGSize(width: 20, height: 10))
                    .frame(height: UIScreen.main.bounds.height * 0.5)
                    .transition(.asymmetric(insertion: .opacity, 
                                            removal: .move(edge: .bottom)))
//                    .animation(.easeIn(duration: 20), value: showView)             
            }
            /**
             
             is for having an personalize transition
             .transition(.asymmetric(insertion: .opacity, 
                                     removal: .move(edge: .bottom)))
             
             is for the corner of the view not the screen
             .transition(.move(edge: .trailing))
             
             // really good one
             .transition(.opacity)
             */
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    Transition()
}
