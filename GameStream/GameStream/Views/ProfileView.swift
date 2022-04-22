//
//  ProfileView.swift
//  GameStream
//
//  Created by Sebastian on 20/04/22.
//

import SwiftUI

struct ProfileView: View {
    
    @State var userName = "Lorem"
    
    var body: some View {
        ZStack {
            Color("Marine-Color")
                .ignoresSafeArea()
            
            VStack {
                Text("Profile")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                VStack{
                    
                    Image("profilePic")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 118, height: 118)
                        .clipShape(Circle())
                    
                    Text("Lanie Janecky")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    
                }.padding(EdgeInsets(top: 60, leading: 0, bottom: 82, trailing: 0))
                
                VStack(alignment: .leading) {
                    Text("Settings")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.leading)
                        
                    
                    SettingsModule()
                    Spacer()
                    
                    
                    
                }
            }.onAppear {
                print("Checking the profile...")
            }
            .hideNavigationBar()
        }
    }
}


struct SettingsModule: View {
    
    @State var isToggleOn = true
    @State var isEditProfileViewActive = false
    
    var body: some View {
        VStack(spacing: 3) {

            Button(action: {}) {
                HStack {
                    Text("Account").foregroundColor(.white)
                    Spacer()
                    Text(">")
                        .foregroundColor(.white)
                }.padding()
            }.background(Color("Blue-Gray"))
                .clipShape(RoundedRectangle(cornerRadius: 3.0))
            
            Button(action: {
                isToggleOn.toggle()
            }) {
                HStack {
                    Text("Notifications").foregroundColor(.white)
                    Spacer()
                    Toggle("", isOn: $isToggleOn)
                }.padding()
            }.background(Color("Blue-Gray"))
                .clipShape(RoundedRectangle(cornerRadius: 3.0))
            
            Button(action: {
                isEditProfileViewActive = true
            }) {
                HStack {
                    Text("Edit profile").foregroundColor(.white)
                    Spacer()
                    Text(">")
                        .foregroundColor(.white)
                }.padding()
            }.background(Color("Blue-Gray"))
                .clipShape(RoundedRectangle(cornerRadius: 3.0))
            
            Button(action: {}) {
                HStack {
                    Text("Rate this app").foregroundColor(.white)
                    Spacer()
                    Text(">")
                        .foregroundColor(.white)
                }.padding()
            }.background(Color("Blue-Gray"))
                .clipShape(RoundedRectangle(cornerRadius: 3.0))
            
           
            
            NavigationLink(isActive: $isEditProfileViewActive) {
                Text("Hello")
            } label: {
                EmptyView()
            }

        }
        
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
