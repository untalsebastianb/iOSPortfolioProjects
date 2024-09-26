//
//  EnvironmentObjectBootcamp.swift
//  SwiftUI+Concepts
//
//  Created by Juan Sebastian Bueno on 9/5/24.
//

import SwiftUI

class EnvironmentViewModel: ObservableObject {
    @Published var dataArray: [String] = []
    
    init() {
       getData() 
    }
    
    func getData() {
        self.dataArray.append(contentsOf: [
            "iPhone", "iPad", "iMac", "apple watch"
        ])
        
    }
}

struct EnvironmentObjectBootcamp: View {
    @StateObject var viewModel: EnvironmentViewModel = EnvironmentViewModel()
    var body: some View {
        NavigationView { 
            List {
                ForEach(viewModel.dataArray, id: \.self) { item in
                    NavigationLink(destination: {
                        DetailView(selectedItem: item)
                    }, label: { 
                        Text(item)
                    })
                }
            }
            .navigationTitle("iOS devices")
        }
        .environmentObject(viewModel)
    }
}

struct DetailView: View {
    let selectedItem: String
    var body: some View {
        ZStack { 
            Color.orange.ignoresSafeArea()
            NavigationLink(destination: {
                FinalView()
            }, label: {
                Text(selectedItem)
                    .font(.headline)
                    .foregroundStyle(.white)
                    .padding()
                    .background(.black)
                    .cornerRadius(32)                
            })
            
        }
    }
}

struct FinalView: View {
    @EnvironmentObject var viewModel: EnvironmentViewModel
    var body: some View {
        ZStack(content: {
            LinearGradient(colors: [
                .red, 
                .green,
                .yellow
                
            ], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
            
            ScrollView { 
                VStack(spacing: 20, content: {
                    ForEach(viewModel.dataArray, id: \.self) { item in
                        Text(item)
                    }
                    Button(action: {
                        viewModel.dataArray.append("Airpods")
                    }, label: {
                        Text("Add Airpods to list")
                    })
                })
                .foregroundStyle(.white)
                .font(.largeTitle)
            }
            .navigationTitle("Final")
        })
    }
}

#Preview {
    EnvironmentObjectBootcamp()
}
