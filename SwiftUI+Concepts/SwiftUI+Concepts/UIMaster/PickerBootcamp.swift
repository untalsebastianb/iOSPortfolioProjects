//
//  PickerBootcamp.swift
//  SwiftUI+Concepts
//
//  Created by Juan Sebastian Bueno on 6/2/24.
//

import SwiftUI

struct PickerBootcamp: View {
    
    @ObservedObject var viewModel = ViewModel()
    
    let filterOptions: [String] = [
        "Most Recent", "Most Popular", "Most Liked"]
    
    @State var selection: String = "1"
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor.brown
    }
    
    var body: some View {
            Picker(selection: $selection) {
                ForEach(filterOptions, id: \.self) { option in
                    Text(option)
                        .tag(option)
                }
            } label: {
                Text("Filter")
            }
            .pickerStyle(.palette) // .automatic .segement whatever
        
        HStack{}
            .task {
                await viewModel.testMainActor()
            }
    }
}

class ViewModel: ObservableObject {
    
    func testMainActor() async {
        for i in 0..<1_00 {
             // Some intensive work
            print(i)
         }
        Task {@MainActor in
            print("hola")
        }
    }
    
    
}

#Preview {
    PickerBootcamp()
}
