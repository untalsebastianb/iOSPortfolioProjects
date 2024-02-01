//
//  AsyncLetBootcamp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by Juan Sebastian Bueno on 1/29/24.
//

import SwiftUI

struct AsyncLetBootcamp: View {
    
    @State private var images: [UIImage] = []
    let url = URL(string: "https://fastly.picsum.photos/id/829/200/200.jpg?hmac=UR6WfoHy282eoIXjFzEm86pUeBNLQsX71BUthF-sOvM")!
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        NavigationView { 
            ScrollView {
                LazyVGrid(columns: columns, content: {
                    ForEach(images, id: \.self) { image in 
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                    }
                })
            }
            .navigationTitle("Async Let bootcamp 🔥")
            .onAppear(perform: {
                Task { // if all the await are in the same Task they are gonna load serially, todo apply concurrency 
                    // you need to run in different task better way to do this is with ASYNC LET!!! 🚨
                    do {
                        // 🌟
                        async let fetchImage1 = fetchImage()
                        async let fetchTitle = fetchTitle()
                        
//                        let (image, title) = await (try fetchImage1, fetchTitle) // you can also fetch different types!
                        async let fetchImage2 = fetchImage()
                        async let fetchImage3 = fetchImage()
                        async let fetchImage4 = fetchImage()
                        async let fetchImage5 = fetchImage()
                        
                        // if one of them fails, all of them are gona fail. or marked them as try?
                        let (image1, image2, image3, image4) = await (try fetchImage1, try fetchImage2, try fetchImage3, try fetchImage4)
                        self.images.append(contentsOf: [image1, image2, image3, image4])
                        
//                        let image1 = try await fetchImage()
//                        self.images.append(image1)
//                        
//                        let image2 = try await fetchImage()
//                        self.images.append(image2)
//                        
//                        let image3 = try await fetchImage()
//                        self.images.append(image3)
//                        
//                        let image4 = try await fetchImage()
//                        self.images.append(image4)
                    } catch {
                        
                    }
                }
            })
        }
    }
    
    private func fetchTitle() async -> String {
        return "New Title"
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

#Preview {
    AsyncLetBootcamp()
}
