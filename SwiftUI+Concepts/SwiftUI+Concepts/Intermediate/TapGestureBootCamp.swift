//
//  TapGestureBootCamp.swift
//  SwiftUI+Concepts
//
//  Created by Juan Sebastian Bueno on 7/20/24.
//

import SwiftUI

struct TapGestureBootCamp: View {

    @State var isSelected: Bool = false
    
    var body: some View {
        VStack(spacing: 40) {
            RoundedRectangle(cornerRadius: 25.0)
                .frame(height: 200)
                .foregroundStyle(isSelected ? Color.green : Color.red)
            
            
            Button { 
                isSelected.toggle()
            } label: { 
                Text("Button")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(25)
            }
            
            Text("Tap Gesture")
                .font(.headline)
                .foregroundStyle(.white)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(25)
//                .onTapGesture {
//                    isSelected.toggle()
//                }
                .onTapGesture(count: 2, perform: {
                    isSelected.toggle()
                })

        }
        .padding()
    }
}

#Preview {
    TapGestureBootCamp()
}
