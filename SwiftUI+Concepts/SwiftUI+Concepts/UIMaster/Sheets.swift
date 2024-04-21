//
//  Sheets.swift
//  SwiftUI+Concepts
//
//  Created by Juan Sebastian Bueno on 4/21/24.
//

import SwiftUI

struct Sheets: View {
    @State var showSheet: Bool = false
    @Environment(\.presentationMode) var presentation
    var body: some View {
        ZStack(content: {
            Color.green
                .ignoresSafeArea()
            
            Button(action: {
                showSheet.toggle()
            }, label: {
                Text("Button")
                    .foregroundStyle(.green)
                    .font(.headline)
                    .padding(20)
                    .background(.white).cornerRadius(10)
            })
            .fullScreenCover(isPresented: $showSheet, content: {
                SecondScreen()
            })
//            .sheet(isPresented: $showSheet, content: {
//                SecondScreen()
//            })
        })
    }
    
//    private func secondScreen() -> some View {
//        ZStack(alignment: .topLeading, content: {
//            Color.red
//                .ignoresSafeArea()
//            
//            Button(action: {
//                presentation.wrappedValue.dismiss()
//            }, label: {
//                Image(systemName: "xmark")
//                    .foregroundStyle(.red)
//                    .font(.headline)
//                    .padding(20)
//                    .background(.white).cornerRadius(10)
//            })
//        })
//    }
}

struct SecondScreen: View {
    @Environment(\.presentationMode) var presentation
    var body: some View {
        NavigationStack {
            ZStack(alignment: .topLeading, content: {
                Color.red
                    .ignoresSafeArea()
            })
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) { 
                    Button(action: {
                        presentation.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "xmark")
                    })
                }
            })
        }
    }
}

#Preview {
    Sheets()
}
