//
//  PopOver.swift
//  SwiftUI+Concepts
//
//  Created by Juan Sebastian Bueno on 4/21/24.
//


// Shets 
// animations
// transitions

import SwiftUI

struct PopOver: View {
    @State var showNewScreen: Bool = false
    var body: some View {
        ZStack(content: {
            Color.orange.ignoresSafeArea()
            
            VStack(content: {
                Button(action: {
                    
//                        showNewScreen.toggle()
                    withAnimation(.spring()) { 
                        showNewScreen.toggle()
                    }
                }, label: {
                    Text("Button")
                        .font(.largeTitle)
                })
                Spacer()
            })
            // Method 1 - Sheet - this is a new environment!!
//            .sheet(isPresented: $showNewScreen, content: {
//                NewScreen()
//            })
            
            // Method 2 - Transition
            ZStack {
                if showNewScreen {
                    NewScreen(showNewScreen: $showNewScreen)
                        .padding(.top)
                        .transition(.opacity)
//                        .transition(.move(edge: .bottom))
                }
            }
            .zIndex(2.0)
            
//            // method 3 - animation offset
//            NewScreen(showNewScreen: $showNewScreen)
//                .padding(.top, 100)
//                .offset(y: showNewScreen ? 0 : UIScreen.main.bounds.height)
        })
    }
}

struct NewScreen: View {
    // when the screen is not a sheet anymore, need to use binding to toggle state
    @Environment(\.dismiss) var dismiss
    @Binding var showNewScreen: Bool 
    var body: some View {
        NavigationStack{
            ZStack(content: {
                Color.purple.ignoresSafeArea()
            })
            .toolbar(content: {
                ToolbarItem { 
                    Button(action: {
                        withAnimation(.spring()) { 
                            showNewScreen.toggle()
                        }
                    }, label: {
                        Image(systemName: "xmark")
                    })
                    .foregroundStyle(.black)
                }
            })
        }
    }
}

#Preview {
    PopOver()
}
