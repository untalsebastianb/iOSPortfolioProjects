//
//  EscapingBootcamp.swift
//  SwiftUI+Concepts
//
//  Created by Juan Sebastian Bueno on 3/26/24.
//

import SwiftUI

class EscapingBootcampVM: ObservableObject {
    @Published private(set) var text: String = "Hello"
    
    func getData() {
        text = downloadData()
    }
    
    func getDataFromCompletionWithDelayResult() {
        downloadDataFromDBWithDelayWithResultType { [weak self] results in
            self?.text = results.data
        }
    }
    
    func getDataFromCompletionWithDelay() {
        downloadDataFromDBWithDelay { [weak self] data in
            guard let self = self else { return }
            self.text = data
        }
    }
    
    func getDataFromCompletion() {
        downloadDataFromDB { data in
            text = data
        }
    }
    
    func downloadData() -> String {
        return "new data"
    }
    
    func downloadDataFromDB() async -> String {
        // Simulate an asynchronous download operation with a delay of 2 seconds
        await Task.sleep(2 * 1_000_000_000) // 2 seconds in nanoseconds
        
        // Return the downloaded data
        return "New Data!"
    }

    
    func downloadDataFromDB(completionHandler: (_ data: String) -> ()) {
        completionHandler("new data")
    }
    
    
    func downloadDataFromDB2(completionHandler: @escaping (_ data: String) -> String) {
            
            // Once the data is downloaded, call the completion handler
            let data = "New Data!"
            let result = completionHandler(data)
            
            // You can use the result if needed
            print("Completion handler returned: \(result)")
    }

// Example usage
//    downloadDataFromDB2 { data in
//        // Process the data
//        return "Processed: \(data)"
//    }
    
    func downloadDataFromDBWithDelayWithResultType(completionHandler: @escaping(DownloadResults) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let result = DownloadResults(data: "DownloadResults")
            completionHandler(result)            
        }
    }
    
    func downloadDataFromDBWithDelay(completionHandler: @escaping(_ data: String) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completionHandler("new data")            
        }
    }
    
    func downloadDataFromDBWithDelayWithAlias(completionHandler: @escaping DownloadCompletion) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let result = DownloadResults(data: "DownloadResults")
            completionHandler(result)             
        }
    }
}

typealias DownloadCompletion = (DownloadResults) -> ()

struct DownloadResults {
    let data: String
}

struct EscapingBootcamp: View {
    
    @StateObject private var vm = EscapingBootcampVM()
    var body: some View {
        Text(vm.text)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundStyle(.blue)
            .onTapGesture {
                vm.getDataFromCompletionWithDelayResult()
            }
    }
}

#Preview {
    EscapingBootcamp()
}
