//
//  ForEachBootCamp.swift
//  SwiftUI+Concepts
//
//  Created by Juan Sebastian Bueno on 5/30/24.
//

import SwiftUI

struct Patient: Hashable {
    var name: String
    var Age: Int
    var ocupation: String
    var service: String
}

struct PatientIdentifiable: Identifiable {
    var id = UUID().uuidString
    var name: String
    var Age: Int
    var ocupation: String
    var service: String
}

struct ForEachBootCamp: View {
    var patients: [Patient] = [
        Patient(name: "Camilo", Age: 24, ocupation: "Doctor", service: "Pediatry"),
        Patient(name: "sebastian", Age: 24, ocupation: "Doctor", service: "Pediatry"),
        Patient(name: "Pedro", Age: 24, ocupation: "Doctor", service: "Pediatry"),
        Patient(name: "Eros", Age: 24, ocupation: "Doctor", service: "Pediatry")
        ]
    
    var patientsID: [PatientIdentifiable] = [
        PatientIdentifiable(name: "Camilo", Age: 24, ocupation: "Doctor", service: "Pediatry"),
        PatientIdentifiable(name: "sebastian", Age: 24, ocupation: "Doctor", service: "Pediatry"),
        PatientIdentifiable(name: "Pedro", Age: 24, ocupation: "Doctor", service: "Pediatry"),
        PatientIdentifiable(name: "Eros", Age: 24, ocupation: "Doctor", service: "Pediatry")
        ]
    
    var body: some View {
        // Hashable for each 
        ForEach(patients, id: \.hashValue, content: { patient in
            Text("\(patient.name) + \(patient.hashValue)")
        })
        .padding()
        
        // Identifiable For Each
        ForEach(patientsID) { patientID in
            Text("\(patientID.Age) + \(patientID.id.description)")
        }
    }
}

#Preview {
    ForEachBootCamp()
}
