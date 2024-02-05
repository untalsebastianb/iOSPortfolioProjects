//
//  CheckContinuationBootcamp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by Juan Sebastian Bueno on 2/2/24.
//

import SwiftUI

class CheckContinuationBootcampNetManager {
    func getData(URL: URL) async throws -> Data {
        do {
            let (data,_) = try await URLSession.shared.data(from: URL)
            return data
        } catch  {
            throw error
        }
    }
    
    func getDataNoASync(URL: URL) async throws -> Data {
        return try await withCheckedThrowingContinuation { continuation in
            URLSession.shared.dataTask(with: URL) { data, response, error in
                if let data = data {
                    continuation.resume(returning: data)
                } else if let error = error {                  
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(throwing: URLError(.badURL))  
                }
            }
            .resume()
        }
    }
    
    // create own completionHandler closure
    func getHeartImageFromDB(completionHandler: @escaping (_ image: UIImage) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            completionHandler(UIImage(systemName: "heart.fill")!)
        }
    }
    
    func getHeartImageFromDB2() async -> UIImage {
        return await withCheckedContinuation { continuation in
            getHeartImageFromDB { image in
                continuation.resume(with: Result.success(image))
            }
        }
    }
}


class CheckContinuationBootcampViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    let networkManager = CheckContinuationBootcampNetManager()
    
    func getImage() async {
        guard let url = URL(string: "https://fastly.picsum.photos/id/829/200/200.jpg?hmac=UR6WfoHy282eoIXjFzEm86pUeBNLQsX71BUthF-sOvM")
        else { return }
        
        do {
            // el main thread se llama para actualizar la UI
            let data = try await networkManager.getDataNoASync(URL: url)
            if let image = UIImage(data: data) {
                await MainActor.run { 
                    self.image = image               
                }
//                DispatchQueue.main.async {
//                    self.image = image                    
//                }
            }
        } catch  {
            print(error)
        }
    }
    
    func getImageAsyncWay() async {
        guard let url = URL(string: "https://fastly.picsum.photos/id/829/200/200.jpg?hmac=UR6WfoHy282eoIXjFzEm86pUeBNLQsX71BUthF-sOvM")
        else { return }
        let imageData = try? await networkManager.getData(URL: url)
        await MainActor.run { // take this out and get purple warning about updating UI from background thread
            self.image = UIImage(data: imageData!)
        }
    }
    
    func getHeartImage() {
        networkManager.getHeartImageFromDB {[weak self] image in
            self?.image = image
        }
    }
    
    func getHeartImageFromContinuation() async {
        let image = await networkManager.getHeartImageFromDB2()
        self.image = image
    }
}

struct CheckContinuationBootcamp: View {
    
    @StateObject private var viewModel = CheckContinuationBootcampViewModel()
    
    var body: some View {
        ZStack {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
        }
        .task {
            await viewModel.getImage()
        }
    }
}

#Preview {
    CheckContinuationBootcamp()
}
