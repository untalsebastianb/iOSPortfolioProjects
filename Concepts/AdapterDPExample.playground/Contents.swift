import UIKit

// Protocol
protocol ListClient {
    func getList() -> [Int]
}

// Team 1
class ListManager {
    private let client: ListClient
    
    init(client: ListClient) {
        self.client = client
    }
    
    func manageList() {
        _ = client.getList()
        print(client.getList())
        // do something with the list
    }
}

// Team 2
class ListService {
    func getDictionary() -> [String: Int] {
        return ["001" : 1, "002" : 2, "003" : 3]
    }
    
}

// Adapter
class adapterListService: ListClient  {
    
    let service: ListService
    
    init(service: ListService) {
        self.service = service
    }
    
    func getList() -> [Int] {
        // the adapter applies the necesary work to translate one type to another, this time from dictionary to array of [Int]
        service.getDictionary().values.map { $0 }
    }
}

let adapter = adapterListService(service: ListService())
let listManager = ListManager(client: adapter)
listManager.manageList() // [1, 2, 3]




