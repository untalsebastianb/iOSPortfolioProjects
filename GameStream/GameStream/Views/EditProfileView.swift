//
//  EditProfileView.swift
//  GameStream
//
//  Created by Sebastian on 22/04/22.
//

import SwiftUI


struct EditModuleView: View {
    
    @State var email: String = ""
    @State var password: String = ""
    @State var name: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text("Email")
                .foregroundColor(Color("Dark-Cian"))
            
            ZStack(alignment: .leading){
                
                if email.isEmpty {
                    Text(verbatim: "example@gmail.com")
                        .foregroundColor(.gray)
                }
                
                TextField("", text: $email)
                    .foregroundColor(.white)
                
            }
            
            Divider().frame(height: 1)
                .background(Color("Dark-Cian"))
            
            Text("Password")
                .foregroundColor(.white)
            ZStack(alignment: .leading){
                
                if password.isEmpty {
                    Text(verbatim: "Your password here")
                        .foregroundColor(.gray)
                }
                
                SecureField("", text: $password)
                    .foregroundColor(.white)
                
            }
            
            Divider().frame(height: 1)
                .background(Color("Dark-Cian"))
            
            Text("Name")
                .foregroundColor(.white)
            ZStack(alignment: .leading){
                
                if password.isEmpty {
                    Text(verbatim: "Your username here")
                        .foregroundColor(.gray)
                }
                
                TextField("", text: $name)
                    .foregroundColor(.white)
                
            }
            
            Divider().frame(height: 1)
                .background(Color("Dark-Cian"))
            
            
            Button(action: {
                update()
            }) {
                Text("Update")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(EdgeInsets(top: 11, leading: 18, bottom: 11, trailing: 18))
                    .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color("Dark-Cian"), lineWidth: 1.0).shadow(color: .white, radius: 6))
            }.padding(.top)
            
            
            

            
             
        }.padding(.horizontal, 42.0)
    }
    
    func update(){
        print("saving data user")
    }
}

struct EditProfileView: View {
    var body: some View {
        ZStack {
            Color("Marine-Color")
                .ignoresSafeArea()
            ScrollView {
                
                VStack{
                    
                    Button(action: {}) {
                        ZStack {
                            Image("profilePic")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 118, height: 118)
                            .clipShape(Circle())
                            
                            Image(systemName: "camera")
                                .foregroundColor(.white)
                        }
                    }
                    
                    EditModuleView()
                    
                }.padding(.bottom, 18)
                
                
            }
        }
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
