import UIKit
import Combine

//Try map
enum parserError: Error {
    case errorStringToInt
}

func mapStringToInt(with stringValue: String) throws -> Int {
    guard let result = Int(stringValue) else {
        throw parserError.errorStringToInt
    }
    return result
}
let stringPublisher = PassthroughSubject<String, parserError>()

stringPublisher
    .tryMap({ value in
        try mapStringToInt(with: value)
    })
// the number the pipe line will retry to send data when received errors.
    .retry(2)
    .sink { finished in
    print("Completed: ", finished)
} receiveValue: { value in
    print("Value: ", value)
}

stringPublisher.send("32")
stringPublisher.send("35")
stringPublisher.send("Swift")
stringPublisher.send("SwiftUI")
stringPublisher.send("1000")
