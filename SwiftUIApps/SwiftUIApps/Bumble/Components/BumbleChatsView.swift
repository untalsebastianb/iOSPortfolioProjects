//
//  BumbleChatsView.swift
//  SwiftUIApps
//
//  Created by Juan Sebastian Bueno on 8/30/24.
//

import SwiftUI
import SwiftfulRouting

struct BumbleChatsView: View {
    @Environment(\.router) var router
    @State private var allUsers = [User]()
    var body: some View {
        ZStack { 
            Color.bumbleWhite.ignoresSafeArea()
            
            VStack(content: {
                header
                    .padding(16)
                matchQueueSection
                chatsSection
            })
           
        }
        .task {
            await getData()
        }
        .toolbar(.hidden)
    }
    
    private var matchQueueSection: some View {
        VStack(alignment: .leading,
               spacing: 8,
               content: {
            Group {
                Text("Match Queue")
                +
                Text(" (\(allUsers.count))")
                    .foregroundStyle(.bumbleGray)
            }
            .padding(.leading, 16)
            
            ScrollView(.horizontal) { 
                LazyHStack(spacing: 16,
                           content: {
                    ForEach(allUsers) { user in
                        BumbleProfileImageCell(
                            imageName: user.image,
                            percentageRemaining: Double.random(in: 0...1),
                            hasNewMessage: Bool.random()
                        )
                    }
                    .padding(.leading, 16)
                })
            }
            .scrollIndicators(.hidden)
            .frame(height: 100)
        })
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var chatsSection: some View {
        VStack(alignment: .leading,
               spacing: 8,
               content: {
            HStack(content: {
                Group {
                    Text("Chats")
                    +
                    Text(" (Recent)")
                        .foregroundStyle(.bumbleGray)
                }
                Spacer(minLength: 0)
                Image(systemName: "line.horizontal.3.decrease")
                    .font(.title2)
            })
            .padding(.horizontal, 16)
            
            ScrollView(.vertical) { 
                LazyVStack(spacing: 16,
                           content: {
                    ForEach(allUsers) { user in
                        BumbleChatPreviewCell(
                            imageName: user.images.randomElement()!,
                            percentageRemaining: Double.random(in: 0...1),
                            hasNewMessage: Bool.random(),
                            userName: user.username,
                            lastChatMessage: user.aboutMe,
                            isYourMove: Bool.random()
                        )
                    }
                })
                .padding(16)
            }
            .scrollIndicators(.hidden)
        })
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var header: some View {
        HStack(content: {
            Image(systemName: "line.horizontal.3")
                .onTapGesture {
                    router.dismissScreen()
                }
            Spacer(minLength: 0)
            Image(systemName: "magnifyingglass")
        })
        .font(.title)
        .fontWeight(.medium)
    }
    
    private func getData() async {
        guard allUsers.isEmpty else { return }
        do {
            allUsers = try await DataBaseHelper().getUsers()
        } catch  {
            print("error: \(error.localizedDescription)")
        }
    }
}

#Preview {
        BumbleChatsView()
}
