//
//  BumbleHomeView.swift
//  SwiftUIApps
//
//  Created by Juan Sebastian Bueno on 8/19/24.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

/***
 one way to center things in with Zstack giving different frame alignment
 this time we are using .frame(maxWidth, and aligned every item to each side with no Zstack
 ***/

struct BumbleHomeView: View {
    @Environment(\.router) var router
    @State private var options: [String] = ["Everyone", "Trending"]
    @AppStorage("bumble_home_filter") private var selectedFilter = "Everyone"
    @State private var allUsers = [User]()
    @State private var selectedIndex: Int = 1
    @State private var cardOffsets: [Int: Bool] = [:]
    @State private var currentSwipeOffset: CGFloat = 0

    var body: some View {
        ZStack { 
            VStack(spacing: 12,
                   content: {
                header
                BumbleFilterView(options: options, selection: $selectedFilter)
                    .background(
                        Divider(), alignment: .bottom
                    )
                
                
                ZStack(content: {
                    if !allUsers.isEmpty {
                        ForEach(Array(allUsers.enumerated()), id: \.offset) { (index, user) in 
                            let isPrevious = (selectedIndex - 1) == index
                            let iscurrent = selectedIndex == index
                            let isNext = (selectedIndex + 1) == index
                            if isPrevious||iscurrent || isNext {
                                let offsetValue = cardOffsets[user.id]
                                
                                userProfileCell(index: index, user: user)
                                    .zIndex(Double(allUsers.count - index))
                                    .offset(x: offsetValue == nil ? 0 : true ? 900 : -900)
                            }
                        }
                    } else {
                        ProgressView()
                    }
                    
                    overlaySwippingIndicators
                    .zIndex(999)
                })
                .frame(maxHeight: .infinity)
                .padding(4)
                .animation(.smooth, value: cardOffsets)
                
                
            })
            .padding(8)
        }
        .task {
            await getData()
        }
        .toolbar(.hidden)
    }
    
    private var overlaySwippingIndicators: some View {
        ZStack {
            Circle()
                .fill(.bumbleGray.opacity(0.4))
                .overlay { 
                    Image(systemName: "xmark")
                        .font(.title)
                        .fontWeight(.semibold)
                }
                .frame(width: 60, height: 60)
                .scaleEffect(abs(currentSwipeOffset) > 100 ? 1.5 : 1.0)
                .offset(x: min(-currentSwipeOffset, 150))
                .offset(x: -100)
                .animation(.smooth, value: currentSwipeOffset)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            
            Circle()
                .fill(.bumbleGray.opacity(0.4))
                .overlay { 
                    Image(systemName: "checkmark")
                        .font(.title)
                        .fontWeight(.semibold)
                }
                .frame(width: 60, height: 60)
                .scaleEffect(abs(currentSwipeOffset) > 100 ? 1.5 : 1.0)
                .offset(x: max(-currentSwipeOffset, -150))
                .offset(x: 100)
                .animation(.smooth, value: currentSwipeOffset)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
    
    private func userProfileCell(index: Int, user: User) -> some View {
        
        BumbleCardView(
            user: user,
            onSuperLikePressed: nil,
            onXMarkPressed: {
                userDidSelect(index: index, isLike: false)
            },
            onCheckMarkPressed: {
                userDidSelect(index: index, isLike: true)
            },
            onSendAComplimentPressed: nil,
            onHideAndReportPressed: nil
        )
            .withDragGesture(
                .horizontal,
                minimumDistance: 10,
                resets: true,
                rotationMultiplier: 1.05,
                onChanged: { drag in
                    currentSwipeOffset = drag.width
                },
                onEnded: { drag in
                    if drag.width < -50 {
                        userDidSelect(index: index, isLike: false)
                    } else if drag.width > 50 {
                        userDidSelect(index: index, isLike: true)
                    }
                }
            )
    }
    
    private func userDidSelect(index: Int, isLike: Bool) {
        let user = allUsers[index]
        cardOffsets[user.id] = isLike
        
        selectedIndex += 1
    }
    
    private func getData() async {
        guard allUsers.isEmpty else { return }
        do {
            allUsers = try await DataBaseHelper().getUsers()
        } catch  {
            print("error: \(error.localizedDescription)")
        }
    }
    
    private var header: some View {
        HStack(spacing: 0, content: {
            HStack(spacing: 0, content: {
                Image(systemName: "line.horizontal.3")
                    .padding(8)
                    .background(.black.opacity(0.001))
                    .onTapGesture {
                        
                    }
                Image(systemName: "arrow.uturn.left")
                    .padding(8)
                    .background(.black.opacity(0.001))
                    .onTapGesture {
                        router.dismissScreen()
                    }
                
            })
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("bumble")
                .font(.title)
                .foregroundStyle(.bumbleYellow)
                .frame(maxWidth: .infinity, alignment: .center)
            
            Image(systemName: "slider.horizontal.3")
                .padding(8)
                .background(.black.opacity(0.001))
                .onTapGesture {
                    router.showScreen(.push) { _ in
                        BumbleChatsView()
                    }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
        })
        .font(.title2)
        .fontWeight(.medium)
        .foregroundStyle(.bumbleBlack)
    }
}

#Preview {
    RouterView { _ in
        BumbleHomeView()
    }
}
