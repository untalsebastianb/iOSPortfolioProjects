//
//  UnitTestingBootcamp.swift
//  SwiftUI+Concepts
//
//  Created by Juan Sebastian Bueno on 3/30/24.
//

/*
 1. Unit test -> Business logic of your app
 2. edge cases of the logic!
 */




import SwiftUI



struct UnitTestingBootcamp: View {
    @StateObject private var vm: UnitTestingBootcampVM
    
    init(isPremium: Bool) {
        // _ because of the property wrapper
        _vm = StateObject(wrappedValue: UnitTestingBootcampVM(isPremium: isPremium))
    }
    var body: some View {
        Text(vm.isPremium.description)
    }
}

#Preview {
    UnitTestingBootcamp(isPremium: true)
}
