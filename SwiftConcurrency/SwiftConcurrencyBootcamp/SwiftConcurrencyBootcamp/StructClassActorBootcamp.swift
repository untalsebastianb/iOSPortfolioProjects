//
//  StructClassActorBootcamp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by Juan Sebastian Bueno on 2/28/24.
//



/*
 
 🔗 Links:
 - https://blog.onewayfirst.com/ios/post...
 - https://stackoverflow.com/questions/2...
 - https://stackoverflow.com/questions/2...
 - https://medium.com/@vinayakkini/swift-basics-struct-vs-class-31b44ade28ae
 - https://stackoverflow.com/questions/2...
 - https://stackoverflow.com/questions/2...
 - https://www.backblaze.com/blog/whats-...
 - https://medium.com/doyeona/automatic-reference-counting-in-swift-arc-weak-strong-unowned-925f802c1b99
 
 💰 VALUE TYPES:
 - Struct, Enum, String, Int, Array, Set
 - Store in the Stack
 - Faster
 - Thread Safe!
 - when you assing or pass value type a new copy of data is created
 
 🪬 REFERENCE TYPES:
 - Class, Function, Actor
 - Store in the heap
 - Slower, but synchronized
 - Not thread safe
 - When you assign or pass reference type a new reference to original instance will be created (pointer)
 
 ------------------------------
 
 📚 STACK:
 - Store Value Types
 - Variables allocated on the stack are stored directly in the memory
 - Each thread has it's own stack
 
 🚀 HEAP:
 - Store Reference Types
 - Shared accross threads
 
 ------------------------------
 
 ⛩️ STRUCT:
 - Based on VALUES
 - Can be mututated
 - Store in the Stack
 
 🏛️ CLASS:
 - Based on REFERENCES (INSTANCES)
 - Store in the Heap
 - Inherit from other Classes
 
 🕴️ ACTORS:
 - Same as class but Thread Safe! ( needs to be in Async (TASK {}) environment and AWAIT access
 
 ------------------------------
 
 ⛩️ STRUCTS: Data Models, Views
 🏛️ CLASSES: ViewModels.
 🕴️ ACTORS: Shared 'Managers', 'Data Store'
 
 
 
 */

import SwiftUI

class StructClassActorBootcampHomeViewModel: ObservableObject {
    @Published private (set)var title: String = "Sebas"
    init() {
        print("🔥 ViewModel Init")
    }
    
    func changeTitle() {
        title = "Pepe"
    }
}

struct StructClassActorBootcamp: View {
    @ObservedObject var viewModel: StructClassActorBootcampHomeViewModel
    let isActive: Bool
    
    init(isActive: Bool, viewModel: StructClassActorBootcampHomeViewModel) {
        print("🔥 view INIT")
        self.isActive = isActive
        self.viewModel = viewModel
    }
    
    var body: some View {
        Text(isActive ? "Pepe" : "Sebas")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
            .background( isActive ? Color.red : Color.blue)
    }

}

struct StructClassActorBootcampHomeView: View {
    @StateObject var viewModel = StructClassActorBootcampHomeViewModel()
    
    
    @State private(set) var isActive: Bool = false
    var body: some View {
        StructClassActorBootcamp(isActive: isActive, viewModel: viewModel)
            .onTapGesture {
                isActive.toggle()
                viewModel.changeTitle()
            }
    }
    
}



extension StructClassActorBootcamp {
    private func runTest() {
        print("test started")
        structTest1()
        printDivider()
        classTest1()
        printDivider()
        actorTest1()
    }
    
    private func printDivider() {
        print("""
            ------------------------
            """)
    }
    
    private func structTest1() {
        print("StructTest1")
        let objectA = myStruct(title: "StartingTitle")
        print("ObjectA: \(objectA.title)")
        
        print("Pass the VALUES of objectA to objectB")
        // is var because we are changing the object itself objectB in line 35
        var objectB = objectA
        print("ObjectB: \(objectB.title)")
        
        // ⬇️ changing the object property (var) and is also changing the object
        objectB.title = "Second Title"
        
        print("ObjectA: \(objectA.title)")
        print("ObjectB: \(objectB.title)")
    }
    
    private func classTest1() {
        print("classTest1")
        let objectA = myClass(title: "Starting title")
        print("ObjectA: \(objectA.title)")
        print("Pass the REFERENCE of objectA to objectB")
        let objectB = objectA
        print("ObjectB: \(objectB.title)")
        
        objectB.title = "Second Title"
        
        print("ObjectA: \(objectA.title)")
        print("ObjectB: \(objectB.title)")
        
    }
    
    
    private func actorTest1() {
        Task {
            print("actorTest1")
            let objectA = myActor(title: "Starting title")
            print("ObjectA: \(await objectA.title)")
            print("Pass the REFERENCE of objectA to objectB")
            let objectB = objectA
            print("ObjectB: \(await objectB.title)")
            
            await objectB.updateTitle(newTitle: "second title")
            
            print("ObjectA: \(await objectA.title)")
            print("ObjectB: \(await objectB.title)")
        }
    }
}





#Preview {
    StructClassActorBootcamp(isActive: true, viewModel: StructClassActorBootcampHomeViewModel())
}

// Inmutable struct
// everything is going to be a let inside the struct


struct myStruct {
    var title: String
}

class myClass {
    var title: String
    
    init(title: String) {
        self.title = title
    }
    
    func updateTitle(newTitle: String) {
        title = newTitle
    }
}

actor myActor {
    var title: String
    
    init(title: String) {
        self.title = title
    }
    
    func updateTitle(newTitle: String) {
        title = newTitle
    }
}

struct customStruct {
    let title: String
    
    func updateTitle(newTitle: String) -> customStruct
    {
        .init(title: newTitle)
    }
}

struct MutatingStruct {
    private(set) var title: String
    
    init(title: String) {
        self.title = title
    }
    
    // this is to filter the way the struct is mutating.
    mutating func updateTitle(newTitle: String) {
        title = newTitle
    }
}


extension StructClassActorBootcamp {
    private func structTest2() {
        print("structTest2")
        var struct1 = myStruct(title: "Title1")
        print("struct1", struct1.title)
        struct1.title = "title2"
        print("struct1", struct1.title)
        
        printDivider()
        var struct2 = customStruct(title: "title1")
        print("struct2", struct2.title)
        struct2 = customStruct(title: "title2")
        print("struct2", struct1.title)
        
        printDivider()
        var struct3 = customStruct(title: "title1")
        print("struct3", struct3.title)
        struct3 = struct3.updateTitle(newTitle: "title2")
        print("struct3", struct3.title)
        
        
        var struct4 = MutatingStruct(title: "title1")
        print("struct4", struct4.title)
        struct4.updateTitle(newTitle: "title2")
        print("struct4", struct4.title)
        
    }
}

extension StructClassActorBootcamp {
    private func classTest2() {
        print("classTest2")
        
        let class1 = myClass(title: "Title1")
        print("class1: \(class1.title)")
        class1.title = "title2"
        print("class1: \(class1.title)")
        
        let class2 = myClass(title: "Title1")
        print("class2: \(class2.title)")
        class2.updateTitle(newTitle: "title2")
        print("class2: \(class2.title)")
        
    }
}
