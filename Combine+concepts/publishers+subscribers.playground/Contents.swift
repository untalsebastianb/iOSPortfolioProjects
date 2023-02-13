import UIKit
import Combine

let myArray = [1,2,3,4]
// the publisher can publish errors
//Publishers
let myPublisher = myArray.publisher
let just = Just([1,2,3,4])


//Subscribers
myPublisher.sink { isFinished in
//    is called when all the values are received.
    print("is done")
} receiveValue: { int in
//    is called as many as values exists
    print("each value \(int)")
}

myPublisher.sink { int in
    print(int)
}

// to assing to visual elements or classes
class YoutubeChannel {
    var numbersOfSubscribers: Int = 0
}

let justInteger = Just(2222)
let channel = YoutubeChannel()
justInteger.assign(to: \YoutubeChannel.numbersOfSubscribers, on: channel)
print(justInteger)
channel.numbersOfSubscribers
