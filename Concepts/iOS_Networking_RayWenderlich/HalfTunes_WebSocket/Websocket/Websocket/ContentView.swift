/// Copyright (c) 2020 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import SwiftUI

struct ContentView: View {
    
    @State private var chatMessage = ""
    @State private var messages: [String] = []
    @State private var webSocketTask: URLSessionWebSocketTask!
    
    var body: some View {
        VStack {
            HStack {
                TextField("Enter a message", text: $chatMessage)
                    .padding([.leading, .top, .bottom])
                Button("Send", action: sendMessageTapped)
                    .padding(.trailing)
            }
            
            List(messages, id:\.self) { message in
                Text(message)
            }
        }
        .onAppear {
            setupSocket()
        }
        .onDisappear {
            closeSocket()
        }
    }
    
    func setupSocket() {
        let websocketURL = URL(string: "ws://localhost:8080/chat")!
        webSocketTask = URLSession.shared.webSocketTask(with: websocketURL)
        listenForMessages()
        webSocketTask.resume()
    }
    
    func listenForMessages() {
        self.webSocketTask.receive { result in
            switch result {
            case .failure(let error):
                print("Failed to receive message: \(error)")
            case .success(let message):
                switch message {
                case .string(let text):
                    self.messages.insert(text, at: 0)
                case .data(let data):
                    print("Received binary message: \(data)")
                @unknown default:
                    fatalError()
                }
                self.listenForMessages()
            }
        }
    }
    
    func closeSocket() {
        webSocketTask.cancel(with: .goingAway, reason: nil)
    }
    
    func sendMessageTapped() {
        let message = URLSessionWebSocketTask.Message.string(self.chatMessage)
        self.webSocketTask.send(message) { error in
            if let error = error {
                print("error \(error.localizedDescription)")
            }
        }
    }
    
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

