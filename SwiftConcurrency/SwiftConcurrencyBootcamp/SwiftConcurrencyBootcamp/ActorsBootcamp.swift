//
//  ActorsBootcamp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by Juan Sebastian Bueno on 3/15/24.
//

import SwiftUI

//1. What is the problem that actors are solving? Data race problem
//2. How was this problem solved prior to actors?
//3. Actors can solve the problem


class MyDataManager {
    static let instance = MyDataManager()
    private init() {}
    
    
    var data: [String] = []
    // this is the way data races problems were solved before Actors
    private let lock = DispatchQueue(label: "com.myApp.MyDataManager")
    
    func getRandomData(completion: @escaping (_ title: String?) -> ()) {
        // this is the way data races problems were solved before Actors
        lock.async {
            self.data.append(UUID().uuidString)
            print(Thread.current)
            completion(self.data.randomElement())
        }
    }
}

// Solution with Actor
actor MyActorManager {
    static let instance = MyActorManager()
    private init() {}
    
    nonisolated let myRandonText = "Tasdasd"
    
    
    var data: [String] = []
    
    func getRandomData() -> String? {
        self.data.append(UUID().uuidString)
        print(Thread.current)
        return self.data.randomElement()
    }
    
    // this could be non-isolated function
    nonisolated
    func getSavedData() -> String {
        return "New Data"
    }
}

struct HomeView: View {
    let manager = MyActorManager.instance
    @State private var text: String = ""
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.8).ignoresSafeArea()
            
            Text(text)
                .font(.headline)
        }
        .onAppear {
            let string = manager.getSavedData()                
        }
        .onReceive(timer, perform: { _ in
            
            
            Task {
                if let data = await manager.getRandomData() {
                    await MainActor.run { 
                        self.text = data
                    }
                }
                
            }
            
            
            
//            DispatchQueue.global(qos: .background).async {
//                manager.getRandomData { title in
//                    if let data = title {
//                        DispatchQueue.main.async {
//                            self.text = data
//                        }
//                    }
//                }
//            }
        })
    }
}

struct BrowseView: View {
    let manager = MyActorManager.instance
    @State private var text: String = ""
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    var body: some View {
        ZStack {
            Color.yellow.opacity(0.8).ignoresSafeArea()
            
            Text(text)
                .onReceive(timer, perform: { _ in
                    
                    Task {
                        if let data = await manager.getRandomData() {
                            await MainActor.run { 
                                self.text = data
                            }
                        }
                        
                    }
                    
                    
//                    DispatchQueue.global(qos: .background).async {
//                        manager.getRandomData { title in
//                            if let data = title {
//                                DispatchQueue.main.async {
//                                    self.text = data
//                                }
//                            }
//                        }
//                    }
                })
        }
        
        
    }
}

struct ActorsBootcamp: View {
    var body: some View {
       
        TabView {
            HomeView()
                .tabItem { 
                    Label("Home", systemImage: "house.fill")
                }
            
            BrowseView()
                .tabItem { 
                    Label("Browse", systemImage: "magnifyingglass")
                }
        }
    }
}

#Preview {
    ActorsBootcamp()
}
