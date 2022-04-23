//
//  SaveData.swift
//  GameStream
//
//  Created by Sebastian on 22/04/22.
//

import Foundation

class SaveData {
    let handler = UserDefaults.standard
    var email: String = ""
    var password: String = ""
    var name: String = ""
    
    
    func saveData(email: String, password: String, name: String) -> Bool {
        handler.set([email, password, name], forKey: "userData")
        return true
    }
    
    func getData() -> [String]{
        let userData: [String] = handler.stringArray(forKey: "userData") ?? [String]()
        return userData
    }
    
    func validateData(email: String, password: String) -> Bool {
        var savedEmail: String
        var savedPassword: String
        
        if handler.stringArray(forKey: "userData") != nil {
            savedEmail = handler.stringArray(forKey: "userData")![0]
            savedPassword = handler.stringArray(forKey: "userData")![1]
            
            if savedEmail == email && password == savedPassword {
                return true
            }
        }
        return false
    }
}
