//
//  ProtocolsBootcamp.swift
//  SwiftUI+Concepts
//
//  Created by Juan Sebastian Bueno on 3/30/24.
//

import SwiftUI

// optionals in protocols
/*
 protocol OptionalProperty {
     var optionalValue: Int? { get }
 }

 extension OptionalProperty {
     var optionalValue: Int? {
         return nil
     }
 }

 struct ExampleStruct: OptionalProperty {
     // OptionalProperty protocol doesn't require implementing optionalValue
 }

 let example = ExampleStruct()
 print(example.optionalValue) // Output: nil

 
 */

struct DefaultColorTheme: ColorThemeProtocol {
    let primary: Color = .blue
    let secondary: Color = .white
    let tertiary: Color = .gray
}

struct AlternativeColorTheme: ColorThemeProtocol {
    let primary: Color = .black
    let secondary: Color = .white
    let tertiary: Color = .gray
}

struct AnotherColorTheme: ColorThemeProtocol {
    let primary: Color = .yellow
    let secondary: Color = .white
    let tertiary: Color = .black
}


protocol ColorThemeProtocol {
    var primary: Color { get }
    var secondary: Color { get }
    var tertiary: Color { get }
    
    
}

class DataSource: ButtonDataSourceProtocol {
    func buttonPressed() {
        print("Button pressed")
    }
    
    var buttonText = "Protocols are awesome"
}

class AlternateDataSource: ButtonTextProtocol {    
    var buttonText = "Protocols are lame"
}

protocol ButtonTextProtocol {
    var buttonText: String { get }
}

protocol ButtonPressedProtocol {
    func buttonPressed() -> ()
}

protocol ButtonDataSourceProtocol: ButtonTextProtocol, ButtonPressedProtocol {
    
}

struct ProtocolsBootcamp: View {
    let colorTheme: ColorThemeProtocol
    let dataSource: ButtonDataSourceProtocol
    var body: some View {
        ZStack {
            colorTheme.tertiary
                .ignoresSafeArea()
            
            Text(dataSource.buttonText)
                .font(.headline)
                .foregroundStyle(colorTheme.secondary)
                .padding()
                .background(colorTheme.primary)
                .cornerRadius(10)
                .onTapGesture {
                    dataSource.buttonPressed()
                }
        }
    }
}

#Preview {
    ProtocolsBootcamp(colorTheme: AnotherColorTheme(), dataSource: DataSource())
}
