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
                runTest()
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
