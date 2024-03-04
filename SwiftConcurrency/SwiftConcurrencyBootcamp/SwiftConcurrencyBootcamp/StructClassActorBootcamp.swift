//
//  StructClassActorBootcamp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by Juan Sebastian Bueno on 2/28/24.
//

import SwiftUI

struct StructClassActorBootcamp: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear{
                structTest2()
            }
    }
}

extension StructClassActorBootcamp {
    private func runTest() {
        print("test started")
        structTest1()
        printDivider()
        classTest1()
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
}

struct myStruct {
    var title: String
}

class myClass {
    var title: String
    
    init(title: String) {
        self.title = title
    }
}

#Preview {
    StructClassActorBootcamp()
}

// Inmutable struct
// everything is going to be a let inside the struct
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
