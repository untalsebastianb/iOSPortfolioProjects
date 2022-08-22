import UIKit

let json = """
{
    "name": "Networking with URLSession",
    "language": "Swift",
    "version": 5.2
}
"""

guard let uploadURL = URL(string: "http://localhost:8080/upload") else { fatalError() }

var request = URLRequest(url: uploadURL)
let jsonData = json.data(using: .utf8)

request.httpMethod = "post"
request.setValue("application/json", forHTTPHeaderField: "Content-Type")

let urlSession = URLSession(configuration: .default, delegate: nil, delegateQueue: nil)
let task = urlSession.uploadTask(with: request, from: jsonData) { data, response, error in
    print(response ?? "no response")
}
task.resume()
