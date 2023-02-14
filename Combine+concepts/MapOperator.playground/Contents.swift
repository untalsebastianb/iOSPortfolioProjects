import UIKit
import Combine


// Map Operator
let publisher =  PassthroughSubject<Int, Never>()

publisher
    .map({
        String($0)
    })
    .sink { value in
    print("value \(value)")
}

publisher.send(35)
publisher.send(32)


print("Try map ---------------------------- \n\n")


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
    .sink { finished in
    print("Completed: ", finished)
} receiveValue: { value in
    print("Value: ", value)
}

stringPublisher.send("32")
stringPublisher.send("35")
stringPublisher.send("Swift")

