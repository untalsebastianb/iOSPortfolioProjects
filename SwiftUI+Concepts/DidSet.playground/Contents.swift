import UIKit

//
//  DidSetBootcamp.swift
//  SwiftUI+Concepts
//
//  Created by Juan Sebastian Bueno on 3/20/24.
//

import Foundation

class CheeseCoin {
    var price: Double = 0 {
        // new value to be set
        willSet {
            if price != newValue {
                print("CHC price changed to: \(newValue)")                
            }
        }
        // old value 
        didSet {
            if price != oldValue {
                print("CHC price changed to: \(oldValue)")                
            }
        }
    }
    
    init(_ price: Double) {
        self.price = price
    }
    
    func pump(_ price: Double) {
        self.price = price
    }
}

struct App {
    var contacts: [String] = [] {
        willSet {
            print("WILL SET")
            print("-------------------")
            print("Current value is: \(contacts)")
            print("New value is: \(newValue)")
            print("-------------------")
        }
        
        didSet {
            print("DID SET")
            print("-------------------")
            print("Current value is: \(contacts)")
            print("old value is: \(oldValue)")
            print("-------------------")
        }
    }
}

var chese = CheeseCoin(1.0)
chese.pump(200)

var app = App()
app.contacts.append("Sebastian")
app.contacts.append("Allen")


struct Employee {
    let name: String
    var vacationAllocated = 14
    var vacationTaken = 0
    
    var vacationRemaining: Int {
        get {
            vacationAllocated - vacationTaken            
        }
        
        set {
            vacationAllocated = vacationTaken + newValue
        }
    }
}

var archer = Employee(name: "Steerling", vacationAllocated: 14)
archer.vacationTaken += 4
print(archer.vacationRemaining)
archer.vacationTaken += 4
print(archer.vacationRemaining)
//// can't do this because is an only get property
//archer.vacationRemaining = 14
archer.vacationRemaining = 25
print(archer.vacationRemaining)
