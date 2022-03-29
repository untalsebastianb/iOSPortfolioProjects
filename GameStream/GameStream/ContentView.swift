//
//  ContentView.swift
//  GameStream
//
//  Created by Juan Sebastian Bueno on 3/2/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            
            Spacer()
            Color(red: 19/255, green: 30/255, blue: 53/255, opacity: 1.0)
                .ignoresSafeArea()
            VStack{
                Image("appLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 250)
                    .padding(.bottom, 42)
                SigninRegisterView()
            }
            
        }
    }
}


struct SigninRegisterView : View {
    
    @State var flowView = false
    var body: some View {
        
        VStack {
            HStack{
                
                Spacer()
                Button("SIGN IN") {
                    flowView = true
                }
                .foregroundColor(flowView ? .white : .gray)
                Spacer()
                Button("SIGN UP") {
                    flowView = false
                }
                .foregroundColor(flowView ? .gray : .white)
                Spacer()
            }
            
            Spacer(minLength: 42)
            if flowView == true {
                SigninView()
                
            } else {
                SignupView()
                
            }
        }
    }
}

struct SigninView: View {
    
    @State var email = ""
    @State var password = ""
    
    
    var body: some View {
        
        
        ScrollView {
            
            
            VStack(alignment: .leading) {
                Text("Email")
                    .foregroundColor(Color("Dark-Cian"))
                
                
                ZStack(alignment: .leading) {
                    
                    if email.isEmpty {
                        Text("Write yor email")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    TextField("", text: $email)
                    
                }
                
                Divider().frame( height: 1).background(Color("Dark-Cian")).padding(.bottom)
                
                Text("Password")
                    .foregroundColor(.white)
                
                ZStack(alignment: .leading) {
                    
                    if email.isEmpty {
                        Text("Write your password")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    SecureField("", text: $email)
                    
                }
                
                Divider().frame( height: 1).background(Color("Dark-Cian")).padding(.bottom)
                
                Text("Forget your password?")
                    .font(.footnote)
                    .frame(width: 300, alignment: .trailing)
                    .foregroundColor(Color("Dark-Cian"))
                    .padding(.bottom)
                
                Button(action: SignIn) {
                    Text("SIGN IN")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(EdgeInsets(top: 11, leading: 18, bottom: 11, trailing: 18))
                        .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color("Dark-Cian"), lineWidth: 1.0).shadow(color: .white, radius: 6))
                    
                }.padding(.bottom, 40)
                
                Text("Sign in with Social Media ").foregroundColor(.white).frame(maxWidth: .infinity, alignment: .center)
                    .padding(.bottom, 40)
                HStack {
                    Button(action: SignIn) {
                        Text("Facebook")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(EdgeInsets(top: 11, leading: 18, bottom: 11, trailing: 18))
                            .background(RoundedRectangle(cornerRadius: 6).fill(Color("Blue-Gray")))
                    }
                    Button(action: SignIn) {
                        Text("Twitter")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(EdgeInsets(top: 11, leading: 18, bottom: 11, trailing: 18))
                            .background(RoundedRectangle(cornerRadius: 6).fill(Color("Blue-Gray")))
                    }
                    
                }
                
            }.padding(.horizontal, 77)
        }
        
        
        
    }
}

func SignIn() {
    print("Signin in...")
}

struct SignupView: View {
    @State var email = ""
    
    var body: some View {
        ScrollView {
            
            VStack(alignment: .center) {
                
                Text("Choose your profile Pic")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Text("You can edit it later")
                    .font(.footnote)
                    .fontWeight(.light)
                    .foregroundColor(.gray)
                    .padding(.bottom)
                
                Button(action: takePicture) {
                    ZStack {
                        Image("profilePic")
                            .resizable()
                            .aspectRatio( contentMode: .fit)
                            .frame(width: 80, height: 80)
                        
                        Image(systemName: "camera")
                            .foregroundColor(.white)
                    }
                }.padding(.bottom, 30)
            }
            
            
            VStack() {
                
                VStack(alignment: .leading) {
                    
                    Text("Email*")
                        .foregroundColor(Color("Dark-Cian"))
                    
                    
                    ZStack(alignment: .leading) {
                        
                        if email.isEmpty {
                            Text("Write your email")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        TextField("", text: $email)
                        
                    }
                    
                    Divider().frame( height: 1).background(Color("Dark-Cian")).padding(.bottom)
                    
                    Text("Password*")
                        .foregroundColor(.white)
                    
                    ZStack(alignment: .leading) {
                        
                        if email.isEmpty {
                            Text("Write your password")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        SecureField("", text: $email)
                        
                    }
                    
                    
                    Divider().frame( height: 1).background(Color("Dark-Cian")).padding(.bottom)
                    
                    
                    Text("Confirm your password*")
                        .foregroundColor(.white)
                    
                    ZStack(alignment: .leading) {
                        
                        SecureField("", text: $email)
                        
                    }
                    
                    Divider().frame( height: 1).background(Color("Dark-Cian")).padding(.bottom, 30)
                    
                }
                
                Button(action: signUp) {
                    Text("SIGN UP")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(EdgeInsets(top: 11, leading: 18, bottom: 11, trailing: 18))
                        .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color("Dark-Cian"), lineWidth: 1.0).shadow(color: .white, radius: 6))
                    
                }.padding(.bottom, 40)
                
                Text("Sign up with Social Media").foregroundColor(.white).frame(maxWidth: .infinity, alignment: .center)
                    .padding(.bottom, 40)
                HStack {
                    Button(action: signUp) {
                        Text("Facebook")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(EdgeInsets(top: 11, leading: 18, bottom: 11, trailing: 18))
                            .background(RoundedRectangle(cornerRadius: 6).fill(Color("Blue-Gray")))
                    }
                    Button(action: SignIn) {
                        Text("Twitter")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(EdgeInsets(top: 11, leading: 18, bottom: 11, trailing: 18))
                            .background(RoundedRectangle(cornerRadius: 6).fill(Color("Blue-Gray")))
                    }
                    
                }
                
            }.padding(.horizontal, 77)
        }
    }
}

func takePicture() {
    print("Taking picture..")
}

func signUp() {
    print("Registering user..")
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
