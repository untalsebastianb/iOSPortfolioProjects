//
//  TaskGroupBootcamp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by Juan Sebastian Bueno on 2/1/24.
//

import SwiftUI

class TaskGroupBootcampDataManager {
    let url = URL(string: "https://fastly.picsum.photos/id/829/200/200.jpg?hmac=UR6WfoHy282eoIXjFzEm86pUeBNLQsX71BUthF-sOvM")!
    
    /// Async let - not very scalable
    func fetchImagesWithAsyncLet() async throws -> [UIImage] {
        async let fetch1 = fetchImage()
        async let fetch2 = fetchImage()
        async let fetch3 = fetchImage()
        async let fetch4 = fetchImage()
        
        let (image1, image2, image3, image4) = await (try fetch1, try fetch2, try fetch3, try fetch4)            
        
        return [image1, image2, image3, image4]
    }
    
    func fetchImagesWithTaskGroup() async throws -> [UIImage] {
        return try await withThrowingTaskGroup(of: UIImage?.self) { group in
            var images: [UIImage] = [] 
            images.reserveCapacity(8) // slight improvement for the code.
            
            // here I added the task manually
            group.addTask { 
                try await self.fetchImage()
            }
            group.addTask { 
                try await self.fetchImage()
            }
            group.addTask { 
                try await self.fetchImage()
            }
            group.addTask { 
                try await self.fetchImage()
            }
            
            /// add task in for, usually yo pass here an imageID
            for nu in 1...8 {
                group.addTask { 
                    try? await self.fetchImage()
                }
            }
            
            for try await imageTaskResult in group {
                if let image = imageTaskResult {
                    images.append(image)                    
                }
            }
            
            return images
        }
    }
    
    private func fetchImage() async throws -> UIImage {
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            if let image = UIImage(data: data) {
                return image
            } else {
                throw URLError(.badURL)
            }
        } catch {
            throw error
        }
    }
}

class TaskGroupBootcampViewModel: ObservableObject {
    @Published var images: [UIImage] = []
    let manager = TaskGroupBootcampDataManager()
    
    func getImages() async {
        if let returnedImages = try? await manager.fetchImagesWithTaskGroup() {
            self.images.append(contentsOf: returnedImages)
        }
    }
}

struct TaskGroupBootcamp: View {
    @StateObject private var viewModel = TaskGroupBootcampViewModel()
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        NavigationView {
            ScrollView { 
                LazyVGrid(columns: columns) {
                    ForEach(viewModel.images, id: \.self) { image in 
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                    }
                }
            }
            .navigationTitle("Task Group 🚨")
        }
        .task {
            await viewModel.getImages()
        }
    }
}

#Preview {
    TaskGroupBootcamp()
}
