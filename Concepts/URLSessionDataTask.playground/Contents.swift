import UIKit
import Foundation

let configuration = URLSessionConfiguration.default
let sesion = URLSession(configuration: configuration)

guard let url = URL(string: "https://itunes.apple.com/search?media=music&entity=song&term=cohen") else {
    fatalError()
}


let task = sesion.dataTask(with: url) { data, response, error in
    // check if we have a valid response
    guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
        return
    }
    // check if valid data was received
    guard let data = data else { return }
    if let result = String(data: data, encoding: .utf8) {
        print(result)
    }
    
}
task.resume()
