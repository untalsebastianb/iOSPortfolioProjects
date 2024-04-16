//
//  LoginView.swift
//  ThreadsSwiftUI
//
//  Created by Juan Sebastian Bueno on 3/6/24.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject private var viewModel = LoginViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Image("ThreadsLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .padding()
                
                VStack {
                    TextField("Enter your Email", text: $viewModel.email)
                        .textInputAutocapitalization(.never)
                        .textFieldModifier()
                    
                    SecureField("Enter your password", text: $viewModel.password)
                        .textFieldModifier()
                    
                } // Vstack
                
                NavigationLink {
                    Text("Forgot password")
                } label: {
                    Text("Forgot Password")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .padding(.vertical)
                        .padding(.trailing , 28)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }// Nv Link
                
                // login button
                Button(action: {
                    Task {
                        try await viewModel.loginUser()
                    }
                }, label: {
                    Text("Login")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(width: 352, height: 44)
                        .background(.black)
                        .cornerRadius(8)
                }) // login
                
                Spacer()
                Divider()
                NavigationLink { 
                    RegistrationView()
                        .navigationBarBackButtonHidden()
                } label: { 
                    HStack(spacing: 3) {
                        Text("Don't have an account?")
                        Text("Sign Up")
                            .fontWeight(.semibold)
                    }
                    .foregroundStyle(.black)
                    .font(.footnote)
                }
                .padding(.vertical, 16)

            } // Vstack
        }
    }
}

#Preview {
    LoginView()
}
