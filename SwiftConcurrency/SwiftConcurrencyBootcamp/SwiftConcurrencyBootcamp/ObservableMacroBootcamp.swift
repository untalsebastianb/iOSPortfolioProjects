//
//  ObservableMacroBootcamp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by Juan Sebastian Bueno on 3/20/24.
//

import SwiftUI

// do background processes
/*
 this code will cause thread purple warning issue
 actor TitleDataBase {
     func getNewTitle() -> String {
         "ANother new title"
     }
 }

 final class ObservableMacroBootcampViewModel: ObservableObject {
     let database = TitleDataBase()
     @Published var title: String = "Starting title" 
     
     func updateTitle() async {
         title = await database.getNewTitle()
     }
 }

 struct ObservableMacroBootcamp: View {
     @StateObject private var vm = ObservableMacroBootcampViewModel()
     var body: some View {
         Text(vm.title)
             .task { 
                 await vm.updateTitle()
             }
     }
 }
 */

/*
 ways to solve main actor thread problems
 whem marked @MainActor var title: String = "Starting title" you are force to always update the property from context scope (async)
 
 you can do it in these ways:
 func updateTitle() async {
     Task { @MainActor in
         title = await database.getNewTitle()            
     }
 }
 @MainActor
 func updateTitle() async {
         title = await database.getNewTitle()            
 }
 
 func updateTitle() async {
     let title = await database.getNewTitle()
     await MainActor.run { 
         self.title = title       
     }
 }
 
 func updateTitle() async {
     let title = await database.getNewTitle()
     DispatchQueue.main.async {
         self.title = title                   
     }
 }
 
 
 */

actor TitleDataBase {
    func getNewTitle() -> String {
        "ANother new title"
    }
}

@Observable class ObservableMacroBootcampViewModel {
    @ObservationIgnored let database = TitleDataBase()
    @MainActor var title: String = "Starting title" 
    
    func updateTitle() async {
        let title = await database.getNewTitle()
        DispatchQueue.main.async {
            self.title = title                   
        }
    }
}

struct ObservableMacroBootcamp: View {
    @State private var vm = ObservableMacroBootcampViewModel()
    var body: some View {
        Text(vm.title)
            .task { 
                await vm.updateTitle()
            }
    }
}

#Preview {
    ObservableMacroBootcamp()
}
