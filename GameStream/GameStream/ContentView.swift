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
                InicioYRegistroView()
            }
            
        }
    }
}


struct InicioYRegistroView : View {
    
    @State var tipoInicioSesion = true
    var body: some View {
        
        VStack {
            HStack{
                
                Spacer()
                Button("INICIA SESION") {
                    print("Pantalla inicio sesion")
                    tipoInicioSesion = true
                }
                .foregroundColor(tipoInicioSesion ? .white : .gray)
                Spacer()
                Button("REGISTRATE") {
                    tipoInicioSesion = false
                    print("Pantalla de registro")
                }
                .foregroundColor(tipoInicioSesion ? .gray : .white)
                Spacer()
            }
            
            Spacer(minLength: 42)
            if tipoInicioSesion == true {
//                Aqui muestra la pantalla de inicio Sesion
                InicioSesionView()
                
            } else {
//                Aqui muestra la pantalla de registro
                RegistroView()
                
            }
        }
    }
}

struct InicioSesionView: View {
    
    @State var correo = ""
    @State var contrasena = ""
    
    var body: some View {
        

        ScrollView {
            
            
            VStack(alignment: .leading) {
                Text("Correo Electronico")
                    .foregroundColor(Color("Dark-Cian"))
                
                
                ZStack(alignment: .leading) {
                    
                    if correo.isEmpty {
                        Text("Escribe tu correo")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    TextField("", text: $correo)
                    
                }
                
                Divider().frame( height: 1).background(Color("Dark-Cian")).padding(.bottom)
                
                ZStack(alignment: .leading) {
                    
                    if correo.isEmpty {
                        Text("Escribe tu password")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    SecureField("", text: $correo)
                    
                }
                
                Divider().frame( height: 1).background(Color("Dark-Cian")).padding(.bottom)
                
            }.padding(.horizontal, 77)
        }
    
    
    
    }
}

struct RegistroView: View {
    var body: some View {
        Text("Soy la vista de registro")
            .foregroundColor(.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
