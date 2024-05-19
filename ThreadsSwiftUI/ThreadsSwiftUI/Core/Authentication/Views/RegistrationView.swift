//
//  RegistrationView.swift
//  ThreadsSwiftUI
//
//  Created by Juan Sebastian Bueno on 4/1/24.
//

import SwiftUI

struct RegistrationView: View {
    @StateObject private var viewModel = RegistrationViewModel()
    @Environment(\.dismiss) var dismiss

    var body: some View {
            VStack {
                Spacer()
                Image("ThreadsLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .padding()
                
                VStack {
                    // email
                    TextField("Enter your Email", text: $viewModel.email)
                        .textInputAutocapitalization(.never)
                        .textFieldModifier()
                    
                    
                    // password
                    SecureField("Enter your password", text: $viewModel.password)
                        .textFieldModifier()
                    
                    // full name
                    TextField("Enter your full name", text: $viewModel.fullName)
                        .textFieldModifier()
                    
                    TextField("Enter your user name", text: $viewModel.userName)
                        .textInputAutocapitalization(.never)
                        .textFieldModifier()
                    
                    
                    // singup button
                    Button(action: {
                        Task {
                            try await viewModel.createUser()
                        }
                    }, label: {
                        Text("Sign Up")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .frame(width: 352, height: 44)
                            .background(.black)
                            .cornerRadius(8)
                    })
                    .padding(.vertical)
                } // Vstack
                Spacer()
                Divider()
                
                Button(action: {
                    dismiss()
                }, label: {
                    HStack(spacing: 3) {
                        Text("Already have an account?")
                        Text("Sign in")
                            .fontWeight(.semibold)
                    }
                    .foregroundStyle(.black)
                    .font(.footnote)
                })
                .padding(.vertical, 16)

            } // Vstack
    }
}

#Preview {
    RegistrationView()
}
