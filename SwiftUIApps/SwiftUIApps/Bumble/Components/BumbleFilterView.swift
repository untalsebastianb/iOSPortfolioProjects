//
//  BumbleFilterView.swift
//  SwiftUIApps
//
//  Created by Juan Sebastian Bueno on 8/19/24.
//

import SwiftUI

struct BumbleFilterView: View {
    var options: [String] = ["Everyone", "Trending"]
    @Binding var selection: String
    @Namespace private var namespace
    var body: some View {
        HStack(alignment: .top, spacing: 32, content: {
            ForEach(options, id: \.self) { option in
                VStack(spacing: 8, content: {
                    Text(option)
                        .frame(maxWidth: .infinity)
                        .font(.subheadline)
                        .fontWeight(.medium)
                    
                    if selection == option {
                        RoundedRectangle(cornerRadius: 2)
                            .frame(height: 1.5)           
                            .matchedGeometryEffect(id: "selection", in: namespace)
                    }
                })
                .padding(.top, 8)
                .background(.black.opacity(0.001))
                .onTapGesture {
                    selection = option
                }
                .foregroundStyle( selection == option ? .bumbleBlack : .bumbleGray)
            }
        })
        .animation(.smooth, value: selection)
    }
}

fileprivate struct BumbleFilterViewPreview: View {
    var options: [String] = ["Everyone", "Trending"]
    @State private var selection = "Everyone"
    var body: some View {
        BumbleFilterView(options: options, selection: $selection)
    }
}

#Preview {
    BumbleFilterViewPreview()
        .padding()
}
