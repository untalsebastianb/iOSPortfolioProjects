//
//  BumbleCardView.swift
//  SwiftUIApps
//
//  Created by Juan Sebastian Bueno on 8/28/24.
//

import SwiftUI

struct BumbleCardView: View {
    var user: User = .mock
    var onSuperLikePressed: (() -> Void)? = nil
    var onXMarkPressed: (() -> Void)? = nil
    var onCheckMarkPressed: (() -> Void)? = nil
    var onSendAComplimentPressed: (() -> Void)? = nil
    var onHideAndReportPressed: (() -> Void)? = nil
    
    @State private (set)var cardFrame: CGRect = .zero
    var body: some View {
        ScrollView(.vertical ,
                   content: {
            LazyVStack(spacing: 0,
                       content: {
                headerCell
                    .frame(height: cardFrame.height)
                
                aboutMeSection
                    .padding(24)
                
                myInterestSection
                    .padding(24)
                
                ForEach(user.images, id: \.self) { image in
                    ImageLoaderView(urlString: image)
                        .frame(height: cardFrame.height)
                }
                
                locationSection
                    .padding(24)
                
                footer
                    .padding(.top, 60)
                    .padding(.bottom, 60)
                    .padding(24)
            })
        })
        .scrollIndicators(.hidden)
        .background(.bumbleBackgroundYellow)
        .overlay(alignment: .bottomTrailing, content: { 
            superLikeButton
        })
        .cornerRadius(32)
        .readingFrame { frame in
            cardFrame = frame
        }
    }
    
    private var superLikeButton: some View {
        Image(systemName: "hexagon.fill")
            .foregroundStyle(.bumbleYellow)
            .font(.system(size: 60))
            .overlay { 
                Image(systemName: "star.fill")
                    .foregroundStyle(.bumbleBlack)
                    .font(.system(size: 30))
                    .fontWeight(.medium)
            }
            .padding(24)
            .onTapGesture {
                onSuperLikePressed?()
            }
    }
    
    private var footer: some View {
        VStack(spacing: 24, content: {
            HStack(alignment: .center, spacing: 0, content: {
                Circle()
                    .fill(.bumbleYellow)
                    .overlay { 
                        Image(systemName: "xmark")
                            .font(.title)
                            .fontWeight(.semibold)
                    }
                    .frame(width: 60, height: 60)
                    .onTapGesture {
                        onXMarkPressed?()   
                    }
                
                Spacer(minLength: 0)
                
                Circle()
                    .fill(.bumbleYellow)
                    .overlay { 
                        Image(systemName: "checkmark")
                            .font(.title)
                            .fontWeight(.semibold)
                    }
                    .frame(width: 60, height: 60)
                    .onTapGesture {
                        onCheckMarkPressed?()
                    }
            })
            
            Text("Hide and Report")
                .font(.headline)
                .foregroundStyle(.bumbleGray)
                .padding(8)
                .background(Color.black.opacity(0.001))
                .onTapGesture {
                   onHideAndReportPressed?()     
                }
        })
    }
    
    private var locationSection: some View {
        VStack(alignment: .leading, spacing: 12, content: {
            HStack(alignment: .center, spacing: 8, content: {
                Image(systemName: "mappin.and.ellipse.circle.fill")
                Text(user.firstName + "'s Location")
                    .foregroundStyle(.bumbleGray)
                    .font(.body)
                    .fontWeight(.medium)
                
            })
            Text("10 miles away")
                .font(.headline)
                .foregroundStyle(.bumbleBlack)
            
            InterestPillView(iconName: nil, emoji: "🇨🇦", text: "Ontario, CA")
        })
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var myInterestSection: some View {
        VStack(alignment: .leading, spacing: 20, content: {
            VStack(alignment: .leading, spacing: 8, content: {
                sectionTitle(title: "My basics")
                InterestPillGridView(interest: user.basics)
            })
            
            VStack(alignment: .leading, spacing: 8, content: {
                sectionTitle(title: "My interests")
                InterestPillGridView(interest: user.interest)
            })
        })
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private func sectionTitle(title: String) -> some View {
        Text(title)
            .font(.body)
            .foregroundStyle(.bumbleGray)
    }
    
    private var aboutMeSection: some View {
        VStack(alignment: .leading, spacing: 20, content: {
            sectionTitle(title: "About Me")
            
            Text(user.aboutMe)
                .font(.body)
                .fontWeight(.semibold)
                .foregroundStyle(.bumbleBlack)
            
            HStack(spacing: 0, content: {
                BumbleHeartView()
                Text("Send a Compliment")
                    .font(.caption)
                    .fontWeight(.semibold)
            })
            .padding([.horizontal, .trailing], 8)
            .background(.bumbleYellow)
            .cornerRadius(32)
            .onTapGesture {
                onSendAComplimentPressed?()
            }
        })
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var headerCell: some View {
        ZStack(alignment: .bottomLeading,
               content: {
            
            ImageLoaderView(urlString: user.image)
            VStack(alignment: .leading, spacing: 8, content: {
                Text("\(user.firstName), \(user.age)")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                
                HStack(spacing: 4, content: {
                    Image(systemName: "suitcase")
                    Text(user.work)
                })
                
                HStack(spacing: 4, content: {
                    Image(systemName: "graduationcap")
                    Text(user.education)
                })
                
                BumbleHeartView()
                    .onTapGesture(perform: {})
            })
            .padding()
            .font(.callout)
            .fontWeight(.medium)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                LinearGradient(
                    colors: [
                        .bumbleBlack.opacity(0),
                        .bumbleBlack.opacity(0.6),
                        .bumbleBlack.opacity(0.6)

                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            
        })

    }
}

#Preview {
    BumbleCardView()
        .padding(.vertical, 40)
        .padding(.horizontal, 16)
}
