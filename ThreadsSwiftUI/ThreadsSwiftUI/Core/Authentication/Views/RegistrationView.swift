//
//  RegistrationView.swift
//  ThreadsSwiftUI
//
//  Created by Juan Sebastian Bueno on 4/1/24.
//

import SwiftUI

struct RegistrationView: View {
    
    @State private(set) var email = ""
    @State private(set) var password = ""
    @State private(set) var fullName = ""
    @State private(set) var userName = ""
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
                    TextField("Enter your Email", text: $email)
                        .textInputAutocapitalization(.none)
                        .textFieldModifier()
                    
                    // password
                    SecureField("Enter your password", text: $password)
                        .textFieldModifier()
                    
                    // full name
                    SecureField("Enter your full name", text: $fullName)
                        .textFieldModifier()
                    
                    SecureField("Enter your user name", text: $userName)
                        .textFieldModifier()
                    
                    
                    // singup button
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
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
