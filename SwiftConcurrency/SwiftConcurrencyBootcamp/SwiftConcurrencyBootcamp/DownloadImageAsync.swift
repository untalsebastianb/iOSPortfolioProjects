//
//  DownloadImageAsync.swift
//  SwiftConcurrencyBootcamp
//
//  Created by Juan Sebastian Bueno on 1/4/24.
//

import SwiftUI
import Combine

class DownloadImageAsyncLoader {
    
    let url = URL(string: "https://fastly.picsum.photos/id/829/200/200.jpg?hmac=UR6WfoHy282eoIXjFzEm86pUeBNLQsX71BUthF-sOvM")!
    
    func handleResponse(data: Data?, response: URLResponse?) -> UIImage? {
        guard let data = data, let image = UIImage(data: data), 
                let response = response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            return nil
        }
        return image
    }
    
    // completion handlers way 🔥
    func downloadWithEscaping(completionHandler: @escaping (_ image: UIImage?, _ error: Error?) -> ()) {
        // this runs on background thread
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in // this part is asynchronous
            let image = self?.handleResponse(data: data, response: response)
            completionHandler(image, nil)
        }
        .resume()
    }
    
    // Combine way 🔥
    func downloadWithCombine() -> AnyPublisher<UIImage?, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map(handleResponse)
            .mapError({ $0 })
            .eraseToAnyPublisher()
    }
    
    func downloadWithAsync() async throws -> UIImage? {
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            return handleResponse(data: data, response: response)
        } catch  {
            throw error
        }
    }
}

class DownloadImageAsyncViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    let loader = DownloadImageAsyncLoader()
    var cancellables = Set<AnyCancellable>()
    
    func fetchImageWithCombine() {
        // 🌟 using Combine 
        DispatchQueue.main.asyncAfter(deadline: .now() + 30, execute: {
            print("🔥Se libero el thread \(Thread.current)")
            self.loader.downloadWithCombine()
                .receive(on: DispatchQueue.main)
                .sink { _ in
                } receiveValue: { [weak self] image in
                    self?.image = image                                           
                }
                .store(in: &self.cancellables)
        })
    }
    
    func fetchImageWithCompletion() {
        //         🌟 using completion handlers
                loader.downloadWithEscaping {[weak self] image, error in
//                     updates on the main thread
                    DispatchQueue.main.async {
                        self?.image = image                                           
                    }
                }
    }
    
    
    func fetchImage() async {
        
//        let image = try? await loader.downloadWithAsync()
//        await MainActor.run {
//            self.image = image
//        }
        
        
//         🌟 using completion handlers
        /*
        loader.downloadWithEscaping {[weak self] image, error in
             updates on the main thread
            DispatchQueue.main.async {
                self?.image = image                                           
            }
        }
         */
        
        // 🌟 using Combine 
        /*
        loader.downloadWithCombine()
            .receive(on: DispatchQueue.main)
            .sink { _ in
            } receiveValue: { [weak self] image in
                    self?.image = image                                           
            }
            .store(in: &cancellables)
        */
    }
}

struct DownloadImageAsync: View {
    
    @StateObject private var viewModel = DownloadImageAsyncViewModel()
    
    var body: some View {
        ScrollView(content: {
            Text("Hellooo")
        })
        ZStack {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
            }
        }
        .onAppear(perform: {
            viewModel.fetchImageWithCombine()
        })
//        .onAppear(perform: {
//            Task {
//                await viewModel.fetchImage()                
//            }
//        })
    }
}

#Preview {
    DownloadImageAsync()
}
