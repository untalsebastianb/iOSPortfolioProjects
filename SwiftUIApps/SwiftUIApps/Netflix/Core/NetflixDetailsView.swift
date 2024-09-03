//
//  NetflixDetailsView.swift
//  SwiftUIApps
//
//  Created by Juan Sebastian Bueno on 9/2/24.
//

import SwiftUI
import SwiftfulRouting

struct NetflixDetailsView: View {
    @Environment(\.router) var router
    var product: Product = .mock
    @Environment(\.dismiss) var dismiss
    @State private var progress: Double = 0.2
    @State private var isMyList: Bool = false
    @State private var products: [Product] = []
    var body: some View {
        ZStack { 
            Color.netflixBlack.ignoresSafeArea()
            Color.netflixDarkGray.opacity(0.3).ignoresSafeArea()
            
            VStack(spacing: 0,
                   content: {
                NetflixDetailsHeaderView(
                    imageName: product.firstImage,
                    progress: progress,
                    onAirPlayPressed: {},
                    onXMarkPressed: {
                        dismiss()
                    }
                )
                
                ScrollView(.vertical) { 
                    VStack(alignment: .leading,
                           spacing: 16,
                           content: {
                        
                        detailsProductSection
                        
                        detailsButtonSection
                        
                        moreLikeThisGrid
                        
                    })
                    .padding(8)
                }
                .scrollIndicators(.hidden)
            })
        }
        .task { 
            await getData()
        }
    }
    
    private func onProductpressed(product: Product) {
        router.showScreen(.sheet) { _ in
            NetflixDetailsView(product: product)
        }
    }
    
    private var moreLikeThisGrid: some View {
        VStack(alignment: .leading,
               content: {
            Text("More Like This")
                .font(.headline)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: .zero), count: 3),
                      alignment: .center,
                      spacing: 16,
                      pinnedViews: [],
                      content: {
                ForEach(products) { product in
                    NetflixMovieCell(
                        imageName: product.firstImage,
                        title: product.title,
                        isRecentlyAdded: product.recentlyAdded,
                        topTenRanking: nil
                    )
                    .onTapGesture { 
                        onProductpressed(product: product)
                    }
                }
            })
        })
        .foregroundStyle(.netflixLightGray)
    }
    
    private var detailsButtonSection: some View {
        HStack(spacing: 32, content: {
            MyListButton(isMyList: isMyList, onButtonPressed: {
                isMyList.toggle()
            })
            RateButton(onOptionTapped: { option in })
            ShareButton()
        })
    }
    
    
    private var detailsProductSection: some View {
        NetflixDetailsProductView(
            title: product.title,
            isNew: true,
            yearRelease: "2024",
            seasonsCount: 4,
            hascloseCaptions: true,
            isTopTen: 1,
            descriptionText: product.description,
            castText: "Cast: Juancho",
            onPlayPressed: {},
            onDownloadPressed: {}
        )
    }
    
    private func getData() async {
        do {
            products = try await Array(DataBaseHelper().getProducts())
        } catch  {
            print("error: \(error.localizedDescription)")
        }
    }
}

#Preview {
    RouterView { _ in
        NetflixDetailsView()
    }
}
