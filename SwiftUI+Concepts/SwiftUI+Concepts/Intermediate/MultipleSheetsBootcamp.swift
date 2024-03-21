//
//  MultipleSheetsBootcamp.swift
//  SwiftUI+Concepts
//
//  Created by Juan Sebastian Bueno on 3/21/24.
//

import SwiftUI

struct RandomModel: Identifiable {
    let id = UUID().uuidString
    let title: String
} 

// 1 - Use Binding

/**
 struct NextScreen: View {
     @Binding var selectedModel: RandomModel
     var body: some View {
         Text(selectedModel.title)
             .font(.largeTitle)
     }
 }
 */
// 2 - use multiple .sheets
/**
 
 they can not be in the same parent hierarchy
 
 VStack(spacing: 20) { 
     Button { 
//                selectecModel = RandomModel(title: "ONE")
         showSheet.toggle()
     } label: { 
         Text("Button1")
     }
     .sheet(isPresented: $showSheet, content: {
         NextScreen(selectedModel: RandomModel(title: "One"))
     })
     
     Button { 
//                selectecModel = RandomModel(title: "TWO")
         showSheet2.toggle()
     } label: { 
         Text("Button2")
     }
     .sheet(isPresented: $showSheet2) {
         NextScreen(selectedModel: RandomModel(title: "TWO"))
     }

 }
 */

// 3 use $item

struct MultipleSheetsBootcamp: View {
    @State var selectecModel: RandomModel? = nil
    var body: some View {
        ScrollView {
            VStack(spacing: 20) { 
                
                ForEach(0..<50) { index in
                    Button { 
                        selectecModel = RandomModel(title: "\(index)")
                    } label: { 
                        Text("Button: \(index)")
                    }
                }
            }
        }
        .sheet(item: $selectecModel) { model in
            NextScreen(selectedModel: model)
        }
    }
}

struct NextScreen: View {
    let selectedModel: RandomModel
    var body: some View {
        Text(selectedModel.title)
            .font(.largeTitle)
    }
}

#Preview {
    MultipleSheetsBootcamp()
}
