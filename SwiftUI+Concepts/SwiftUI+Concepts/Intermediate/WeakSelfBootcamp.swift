//
//  WeakSelfBootcamp.swift
//  SwiftUI+Concepts
//
//  Created by Juan Sebastian Bueno on 3/22/24.
//

import SwiftUI

struct WeakSelfBootcamp: View {
    @AppStorage("count") var count: Int?
    
    init() {
        print("🔥")
        count = 0
    }
    var body: some View {
        NavigationView {
            NavigationLink("Navigate") { 
                WeakSelfSecondScreen()
                    .navigationTitle("Screen 1")
            }
            
        }
        .overlay(alignment: .topTrailing, content: {
            Text("\(count ?? 0)")
                .font(.largeTitle)
                .padding()
                .background(Color.green.cornerRadius(10))
        })
        .background(.green)
    }
}
class WeakSelfSecondScreenVM: ObservableObject {
    @Published var data: String? = nil
    
    init() {
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.setValue(currentCount + 1, forKey: "count")
        print("initialize now")
        getData()
    }
    
    deinit {
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.setValue(currentCount - 1, forKey: "count")
        print("denitialize now")
    }
    
    func getData() {
        /* if you were donwoloading a lot of data from inet the code in this async task
         might take seconds during that time the user could be doing something on the app
         probably pressing back button, by the time the call comes back you might not actually need 
         the self to be alived because the user's already gone on a different screen so they don't need the data anymore
        */
        DispatchQueue.main.asyncAfter(deadline: .now() + 500) { [weak self] in
            // here is the strong reference!! 🔥
            self?.data = "New data"
        }
    }
}

struct WeakSelfSecondScreen: View {
    @StateObject var vm = WeakSelfSecondScreenVM()
    var body: some View {
        VStack{
            Text("second view")
            
            if let data = vm.data {
                Text(data)
            }
        }
        
        
    }
}

#Preview {
    WeakSelfBootcamp()
}
