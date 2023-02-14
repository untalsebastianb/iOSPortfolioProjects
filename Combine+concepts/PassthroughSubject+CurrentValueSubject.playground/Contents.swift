import UIKit
import Combine

// currentValueSubject le puede dar valor por defecto. - send
struct BotApp {
    var onboardingPublisher = CurrentValueSubject<String, Error>("Bienvenido al chatBot")
    
    func startOnboarding() {
        onboardingPublisher.send("Crea una conversacion")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            onboardingPublisher.send("Envia un Sticker")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            onboardingPublisher.send("Activa las notificaciones")
        }
        
//        Handle Events para debugear los publishers
    }
}

let bot = BotApp()
let cancellable = bot.onboardingPublisher.handleEvents { subscription in
    print("1 Subscription received: \(subscription)")
} receiveOutput: { value in
    print("2 value received: \(value)")
} receiveCompletion: { completion in
    print("3 value received: \(completion)")
} receiveCancel: {
    print("4 Cancel Received")
} receiveRequest: { request in
    print("5 request Received \(request)")
}.sink { completion in
    switch completion {
    case .finished:
       break
    case .failure(_):
        print("Error")
    }
} receiveValue: { value in
    print("Message: ", value)
}
bot.startOnboarding()






print("-----------------------------\n")

// PassthrougSubject se inicializa sin ningun valor. - send

struct Weather {
    let weatherPublisher = PassthroughSubject<Int, Error>()
    
    func getWeatherInfo() {
        weatherPublisher.send(35)
        weatherPublisher.send(completion: .failure(URLError(.badURL)))
        weatherPublisher.send(32)
    }
}

let weather = Weather()
weather.weatherPublisher.sink { completion in
    switch completion {
    case .finished:
        print("Finished")
    case .failure(_):
        print("Error")
    }
    print("Completion", completion)
} receiveValue: { value in
    print("Values: ", value)
}

weather.getWeatherInfo()

