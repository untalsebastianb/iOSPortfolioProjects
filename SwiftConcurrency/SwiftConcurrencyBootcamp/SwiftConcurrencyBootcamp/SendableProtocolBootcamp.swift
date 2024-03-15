//
//  SendableProtocolBootcamp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by Juan Sebastian Bueno on 3/15/24.
//

import SwiftUI

// @Sendable protocol is declaring and object wheter or not is safe to send into asinchronous context
// sending an object to an actor needs to conform @sensable protocol

actor CurrentUserManager {
    
    func updateDatabase(userInfo: MyUserClassInfo) {
        
    }
    
    
}

struct MyUSerInfo {
    let name: String
}

// Sendable can only be final class ( can't inherit ) as variables are let they are not mutable and are thread safe
final class MyUserClassInfo: Sendable {
    let name: String
    
    init(name: String) {
        self.name = name
    }
}

class SendableProtocolBootcampViewModel: ObservableObject {
    let manager = CurrentUserManager()
    
    func updateCurrentUserInfo() async {
        // string-Struct are thread safe / sendable by default
        let info = "user info"
        let userInfo = MyUSerInfo(name: "Jhon Doe")
        let userClassInfo = MyUserClassInfo(name: "Pepe")
        await manager.updateDatabase(userInfo: userClassInfo)
    }
}

struct SendableProtocolBootcamp: View {
    
    @StateObject private var viewModel = SendableProtocolBootcampViewModel()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .task {
                
            }
    }
}

#Preview {
    SendableProtocolBootcamp()
}
