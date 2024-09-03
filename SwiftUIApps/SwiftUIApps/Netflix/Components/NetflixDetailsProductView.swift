//
//  NetflixDetailsProductView.swift
//  SwiftUIApps
//
//  Created by Juan Sebastian Bueno on 9/3/24.
//

import SwiftUI

struct NetflixDetailsProductView: View {
    var title: String = "movie title"
    var isNew: Bool = true
    var yearRelease: String? = "2004"
    var seasonsCount: Int? = 2
    var hascloseCaptions: Bool = true
    var isTopTen: Int? = 6
    var descriptionText: String? = "This is the description for the title that is selected and it should go multiple line"
    var castText: String? = "Cast: Juancho, Your Name, Someone else"
    var onPlayPressed: (() -> Void)? = nil 
    var onDownloadPressed: (() -> Void)? = nil 
    
    var body: some View {
        VStack(alignment: .leading, content: {
            Text(title)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(spacing: 8, content: {
                if isNew {
                    Text("New")
                        .foregroundStyle(.green)                    
                }

                if let yearRelease {
                    Text(yearRelease)                    
                }
                
                if let seasonsCount {
                    Text("\(seasonsCount) Seasons")
                }
                
                if hascloseCaptions {
                    Image(systemName: "captions.bubble")
                }
            })
            .foregroundStyle(.netflixLightGray)
            
            if let isTopTen {
                HStack(spacing: 8, content: {
                    topTen
                    Text("#\(isTopTen) in TV Shows Today")
                        .font(.headline)
                })
            }
            
            VStack(spacing: 8, content: {
                HStack(content: {
                    Image(systemName: "play.fill")
                    Text("Play")
                })
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
                .foregroundStyle(.netflixDarkGray)
                .background(.netflixWhite)
                .cornerRadius(4)
                .asButton(.press) { 
                    onPlayPressed?()
                }
                
                HStack(content: {
                    Image(systemName: "arrow.down.to.line.alt")
                    Text("Download")
                })
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
                .foregroundStyle(.netflixWhite)
                .background(.netflixDarkGray)
                .cornerRadius(4)
                .asButton(.press) { 
                    onDownloadPressed?()
                }
            })
            .font(.callout)
            .fontWeight(.medium)
            
            Group {
                if let descriptionText {
                    Text(descriptionText)
                }
                
                if let castText {
                    Text(castText)
                        .foregroundStyle(.netflixLightGray)
                }
            }
            .font(.callout)
            .frame(maxWidth: .infinity, alignment: .leading)
            .multilineTextAlignment(.leading)
            
            
        })
        .frame(maxWidth: .infinity)
//        .border(.blue)
        .foregroundStyle(.netflixWhite)
    }
    
    private var topTen: some View {
            Rectangle()
                .fill(.netflixRed)
                .frame(width: 28, height: 28)
                .overlay { 
                    VStack(spacing: -4, content: {
                        Text("TOP")
                            .fontWeight(.bold)
                            .font(.system(size: 8))
                        Text("10")
                            .fontWeight(.bold)
                            .font(.system(size: 16))
                    })
                    .offset(y: 1)
                }
 
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        VStack(spacing: 40, content: {
            NetflixDetailsProductView(isNew: true, yearRelease: nil)
            NetflixDetailsProductView(isTopTen: nil)
            NetflixDetailsProductView(isNew: false)
        })
    }
}
