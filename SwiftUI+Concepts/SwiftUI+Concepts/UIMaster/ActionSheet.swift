//
//  ActionSheet.swift
//  SwiftUI+Concepts
//
//  Created by Juan Sebastian Bueno on 4/24/24.
//

import SwiftUI

enum ActionSheetOptions {
    case isMyPost
    case isOtherPost
}

struct ActionSheet: View {
    @State var showActionSheet: Bool = false
    @State var actionSheetOption: ActionSheetOptions = .isOtherPost
    var body: some View {
        VStack {
            HStack {
                Circle()
                    .frame(width: 30, height: 30)
                Text("@username")
                Spacer()
                Button(action: {
                    actionSheetOption = .isMyPost
                    showActionSheet.toggle()
                }, label: {
                    Image(systemName: "ellipsis")
                })
                .tint(.black)
            }
            .padding(.horizontal)
            
            Rectangle()
                .aspectRatio(1.0, contentMode: .fit)
        }
        .confirmationDialog(getActionDialog().title, 
                            isPresented: $showActionSheet, 
                            titleVisibility: .visible) { 
            getActionDialog().content
        } message: { 
            Text(getActionDialog().message)
        }

    }
    
    func getActionDialog() -> ActionDialogDetails {
        switch actionSheetOption {
        case .isMyPost:
            return ActionDialogDetails(title: "Actions on your post", 
                                message: "Changes made in your post are important", 
                                content: AnyView(
                                    Group {
                                        Button("Delete", role: .destructive) {}
                                        Button("Cancel", role: nil) {}
                                    }
                                ))
        case .isOtherPost:
            return ActionDialogDetails(title: "Actions for other's post", 
                                message: "See what they're doing", 
                                content: AnyView(
                                    Group {
                                        Button("Share", role: nil) {}
                                        Button("Report", role: .destructive) {}
                                        Button("OK") {}
                                    }
                                ))
        }
    }
}

internal struct ActionDialogDetails {
    internal let title: String
    internal let message: String
    internal let content: AnyView
    internal let id = UUID()
}

#Preview {
    ActionSheet()
}
