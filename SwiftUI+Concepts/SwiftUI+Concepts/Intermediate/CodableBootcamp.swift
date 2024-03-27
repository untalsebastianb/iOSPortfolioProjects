//
//  CodableBootcamp.swift
//  SwiftUI+Concepts
//
//  Created by Juan Sebastian Bueno on 3/26/24.
//

import SwiftUI

// codable = Encodable + Decodable
// if you have to set your coding keys you need to create the methods

struct CustomerModel: Identifiable, Codable {
    var id: String
    let name: String
    let points: Int
    let isPremium: Bool
    
//    enum CodingKeys: String, CodingKey {
//        case id
//        case name
//        case points
//        case isPremium = "is_Premium"
//    }
//    
//    // codable does all the work for us
//    
//    init(id: String, name: String, points: Int, isPremium: Bool) {
//        self.id = id
//        self.name = name
//        self.points = points
//        self.isPremium = isPremium
//    }
//    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.id = try container.decode(String.self, forKey: .id)
//        self.name = try container.decode(String.self, forKey: .name)
//        self.points = try container.decode(Int.self, forKey: .points)
//        self.isPremium = try container.decode(Bool.self, forKey: .isPremium)
//    }
//    
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(id, forKey: .id)
//        try container.encode(name, forKey: .name)
//        try container.encode(points, forKey: .points)
//        try container.encode(isPremium, forKey: .isPremium)
//    }
}

class CodableBootcampVM: ObservableObject {
    @Published var customer: CustomerModel? = nil
    
    init() {
        getData()
    }
    
    func getData() {
        guard let data = getJSONDataFromEncoder() else { return }
        print("JSON DATA:")
        print(data)
        // 🔥
        let jsonString = String(data: data, encoding: .utf8)
        print("JSONSTRING: \(String(describing: jsonString))")
        do {
            self.customer = try JSONDecoder().decode(CustomerModel.self, from: data)
        } catch {
            print("Error Decoding", error.localizedDescription)
        }
//        if  
//            // take data and convert it to JSON
//            let localData = try? JSONSerialization.jsonObject(with: data),
//            let dict = localData as? [String: Any],
//            let id = dict["id"] as? String,
//            let name = dict["name"] as? String,
//            let points = dict["points"] as? Int,
//            let isPremium = dict["isPremium"] as? Bool
//        {
//            let newCustomer = CustomerModel(id: id, name: name, points: points, isPremium: isPremium)
//            customer = newCustomer
//        }
        
        //        let localData = try? JSONDecoder().decode(CustomerModel.self, from: data)
    }
    
    func getJSONData() -> Data? {
        
        let dict: [String:Any] = [
            "id": "12345",
            "name": "SB",
            "points": 5,
            "is_Premium": true
        ]
        // create dict to JSON data
        let jsonData = try? JSONSerialization.data(withJSONObject: dict)
        return jsonData
    }
    
    func getJSONDataFromEncoder() -> Data? {
        let customer = CustomerModel(id: "111", name: "EMily", points: 122, isPremium: false)
        // create dict to JSON data
        let jsonData = try? JSONEncoder().encode(customer)
        return jsonData
    }
}

struct CodableBootcamp: View {
    
    @StateObject var vm = CodableBootcampVM()
    var body: some View {
        VStack {
            if let customer = vm.customer {
                Text(customer.id)
                Text(customer.name)
                Text("\(customer.id)")
                Text(customer.isPremium.description)
            }
        }
    }
}

#Preview {
    CodableBootcamp()
}
