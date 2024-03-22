//
//  SortFilterMapBootcamp.swift
//  SwiftUI+Concepts
//
//  Created by Juan Sebastian Bueno on 3/21/24.
//

import SwiftUI
import Combine

struct UserModel: Identifiable {
    let id = UUID().uuidString
    let name: String?
    let points: Int
    let isVerified: Bool
}


class arrayVM: ObservableObject {
    
    @Published var dataArray: [UserModel] = []
    @Published var filteredArray: [UserModel] = []
    @Published var sort: Bool = false
    @Published var mappedArray: [String] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    func addSubscribers() {
        $dataArray
            .combineLatest($sort)
            .receive(on: DispatchQueue.main)
            .map { (array, sort) in
                if sort {
                    return array.sorted { $0.points > $1.points }                    
                } else {
                    return array.sorted { $0.points < $1.points }             
                }
            }
            .sink { [weak self] sorted in
                self?.dataArray = sorted
            }
            .store(in: &cancellables)
    }
    
    init() {
//        addSubscribers()
        getUsers()
        updateFilter()
    }
    
//    func sort() {
//        $dataArray
//            .map{ user in
//                user.points > 5
//            }
////            .sink { [weak self] sorted in
////                self?.dataArray = sorted
////            }
////            .store(in: &cancellables)
//    }
    
//    func filter() {
//        $dataArray
//            .receive(on: DispatchQueue.main) // Ensure updates happen on the main thread
//            .map { dataArray in
//                dataArray.filter { user in
//                    user.isVerified
//                }
//            }
//            .sink { [weak self] filteredArray in
//                guard let self = self else { return }
//                self.dataArray = filteredArray
//            }
//            .store(in: &cancellables)
//    }
    
//    @MainActor
    func filterByVerified() {
        dataArray = dataArray.filter({ $0.isVerified })     
    }
    
//    @MainActor
    func sortByGreater() {
        // here I'm in another thread
        Task {
            dataArray = dataArray.sorted {$0.points > $1.points}            
        }
    }
    
//    @MainActor
    func sortByLower() {
        dataArray = dataArray.sorted {$0.points < $1.points}    
    }
    
//    @MainActor
    func updateFilter() {
        // Sort
        // Filter
        // Map
        
        /* Sort 
         filteredArray = dataArray.sorted { $0.points > $1.points }
         
         filteredArray = dataArray.sorted { user1, user2 in
         user1.points > user2.points
         }
         */
        
        /** Filter
         filteredArray = dataArray.filter({ user in
         user.name.contains("a")
         })
         
         filteredArray = dataArray.filter({ $0.isVerified })         
         */
        
        //        mappedArray = dataArray.map({ user in
        //            return user.name ?? "error"
        //        })  
        
        //mappedArray = dataArray.compactMap({ $0.name })
        
        let sort = dataArray.sorted(by: {$0.points > $1.points})
        let filter = dataArray.filter({ $0.isVerified})
        let map = dataArray.compactMap({ $0.name })
        
        mappedArray = dataArray
            .sorted(by: {$0.points > $1.points})
            .filter({ $0.isVerified})
            .compactMap({ $0.name })
    }
    
    func reset(){
        dataArray.removeAll()
        getUsers()
    }
    
    func getUsers() {
        let user1 = UserModel(name: "Nick", points: 5, isVerified: true)
        let user2 = UserModel(name: "Will", points: 15, isVerified: false)
        let user3 = UserModel(name: nil, points: 55, isVerified: true)
        let user4 = UserModel(name: "Pedro", points: 75, isVerified: true)
        let user5 = UserModel(name: nil, points: 65, isVerified: false)
        let user6 = UserModel(name: "Gonza", points: 415, isVerified: true)
        let user7 = UserModel(name: "Kels", points: 675, isVerified: false)
        let user8 = UserModel(name: "Mand", points: 95, isVerified: false)
        let user9 = UserModel(name: "Matt", points: 589, isVerified: false)
        let user10 = UserModel(name: "Juanch", points: 125, isVerified: true)
        self.dataArray.append(contentsOf: [
            user1,
            user2,
            user3,
            user4,
            user5,
            user6,
            user7,
            user8,
            user9,
            user10,
        ])
    }
}

struct SortFilterMapBootcamp: View {
    @StateObject private var vm = arrayVM()
    var body: some View {
        HStack {
            Button("Sort >") { 
                vm.sortByGreater()
            }
            Spacer()
            Button("Sort with Combine") { 
                vm.sort.toggle()
            }
            Spacer()
            Button("Filter by verified") { 
                vm.filterByVerified()
            }
            Spacer()
            Button("reset") { 
                vm.reset()
            }
            Spacer()
            Button("Sort <") { 
                vm.sortByLower()
            }
        }
        .padding(.horizontal)
        ScrollView {
            VStack(spacing: 20) {
                
                ForEach(vm.mappedArray, id: \.self) { name in
                    Text(name)
                        .font(.title)
                }
                
                
//                ForEach(vm.dataArray) { user in
//                    VStack(alignment: .leading) {
//                        Text(user.name)
//                            .font(.headline)
//                        HStack {
//                            Text("Points: \(user.points)")
//                            Spacer()
//                            if user.isVerified {
//                                Image(systemName: "flame.fill")
//                            }
//                        }
//                    }
//                    .foregroundColor(.white)
//                    .padding()
//                    .background(Color.blue.cornerRadius(10))
//                    .padding(.horizontal)
//                }
            }
        }
    }
}

#Preview {
    SortFilterMapBootcamp()
}
