//
//  ContentView.swift
//  test
//
//  Created by Juan Sebastian Bueno on 8/2/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            OnboardingView()
        }
    }
}

#Preview {
    ContentView()
}

//// OnboardingPath.swift
//class OnboardingPath: ObservableObject {
//    @Published var steps: [OnboardingStep] = []
//}
//
//// OnboardingStep.swift
//enum OnboardingStep: Hashable, CaseIterable {
//    case welcome
//    case personalInfo
//    case preferences
//    case summary
//}
//
//// OnboardingView.swift
//struct OnboardingView: View {
//    @StateObject private var path = OnboardingPath()
//
//    var body: some View {
//        NavigationStack(path: $path.steps) {
//            WelcomeView()
//                .navigationDestination(for: OnboardingStep.self) { step in
//                    switch step {
//                    case .welcome:
//                        WelcomeView()
//                    case .personalInfo:
//                        PersonalInfoView()
//                    case .preferences:
//                        PreferencesView()
//                    case .summary:
//                        SummaryView()
//                    }
//                }
//        }
//        .environmentObject(path)
//    }
//}
//
//// WelcomeView.swift
//struct WelcomeView: View {
//    @EnvironmentObject var path: OnboardingPath
//    
//    var body: some View {
//        VStack {
//            Text("Welcome to Our App!")
//                .font(.largeTitle)
//                .fontWeight(.bold)
//                .padding()
//            Text("This is the starting point of your onboarding journey. We'll guide you through the setup process.")
//                .multilineTextAlignment(.center)
//                .padding()
//            
//            Button("Get Started") {
//                path.steps.append(.personalInfo)
//            }
//            .padding()
//            .background(Color.blue)
//            .foregroundColor(.white)
//            .cornerRadius(8)
//        }
//    }
//}
//
//// PersonalInfoView.swift
//struct PersonalInfoView: View {
//    @EnvironmentObject var path: OnboardingPath
//    
//    var body: some View {
//        VStack {
//            Text("Personal Information")
//                .font(.title2)
//                .fontWeight(.semibold)
//                .padding()
//            Text("Please provide your personal information so we can tailor the experience just for you.")
//                .multilineTextAlignment(.center)
//                .padding()
//            
//            Button("Next: Preferences") {
//                path.steps.append(.preferences)
//            }
//            .padding()
//            .background(Color.blue)
//            .foregroundColor(.white)
//            .cornerRadius(8)
//        }
//    }
//}
//
//// PreferencesView.swift
//struct PreferencesView: View {
//    @EnvironmentObject var path: OnboardingPath
//    
//    var body: some View {
//        VStack {
//            Text("Set Your Preferences")
//                .font(.title2)
//                .fontWeight(.semibold)
//                .padding()
//            Text("Select your preferences to help us provide a more personalized experience.")
//                .multilineTextAlignment(.center)
//                .padding()
//            
//            Button("Next: Summary") {
//                path.steps.append(.summary)
//            }
//            .padding()
//            .background(Color.blue)
//            .foregroundColor(.white)
//            .cornerRadius(8)
//        }
//    }
//}
//
//// SummaryView.swift
//struct SummaryView: View {
//    @EnvironmentObject var path: OnboardingPath
//    
//    var body: some View {
//        VStack {
//            Text("Summary")
//                .font(.title2)
//                .fontWeight(.semibold)
//                .padding()
//            Text("You have completed the onboarding process. Here is a summary of your choices.")
//                .multilineTextAlignment(.center)
//                .padding()
//            
//            NavigationLink(destination: MainAppView().navigationBarBackButtonHidden(true)) {
//                Text("Go to Main App")
//                    .padding()
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(8)
//            }
//        }
//    }
//}
//
//
//// MainAppView.swift
//struct MainAppView: View {
//    var body: some View {
//        Text("Welcome to the Main App!")
//            .font(.largeTitle)
//            .padding()
//    }
//}




// example with NavigationLink 

enum OnboardingStep: Hashable {
    case welcome
    case personalInfo
    case preferences
    case summary
}

struct OnboardingView: View {
    @State private var path: [OnboardingStep] = []

    var body: some View {
        NavigationStack(path: $path) {
            WelcomeView()
                .navigationDestination(for: OnboardingStep.self) { step in
                    switch step {
                    case .welcome:
                        WelcomeView()
                    case .personalInfo:
                        PersonalInfoView()
                    case .preferences:
                        PreferencesView()
                    case .summary:
                        SummaryView()
                    }
                }
        }
    }
}

struct WelcomeView: View {
    var body: some View {
        VStack {
            Text("Welcome to the App")
                .font(.largeTitle)
                .padding()
            // Weird!
            // Should use the ones who uses value in init
            NavigationLink { 
                PersonalInfoView()
            } label: { 
                Text("Go to Preferences")
            }

            NavigationLink(value: OnboardingStep.personalInfo, label: {
                Text("Go to Personal Info")
            })
            NavigationLink("TitleKey, Destination", destination: {
                PersonalInfoView()
            })
            NavigationLink("Next", value: OnboardingStep.personalInfo)
            NavigationLink("Next", value: OnboardingStep.personalInfo)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
    }
}

struct PersonalInfoView: View {
    var body: some View {
        VStack {
            Text("Enter Your Personal Information")
                .font(.title)
                .padding()
            NavigationLink("Next", value: OnboardingStep.preferences)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
    }
}

struct PreferencesView: View {
    var body: some View {
        VStack {
            Text("Set Your Preferences")
                .font(.title)
                .padding()
            NavigationLink("Next", value: OnboardingStep.summary)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
    }
}

struct SummaryView: View {
    var body: some View {
        VStack {
            Text("Summary")
                .font(.title)
                .padding()
            Text("You have completed the onboarding process!")
                .padding()
            NavigationLink(destination: MainAppView().navigationBarBackButtonHidden(true)) {
                Text("Go to Main App")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
    }
}

struct MainAppView: View {
    var body: some View {
        Text("Welcome to the Main App!")
            .font(.largeTitle)
            .padding()
    }
}


// example with other navigationLinks
//enum OnboardingStep: Hashable {
//    case welcome
//    case personalInfo
//    case preferences
//    case summary
//}
//
//class OnboardingPath: ObservableObject {
//    @Published var steps: [OnboardingStep] = []
//}
//
//struct OnboardingView: View {
//    @StateObject private var path = OnboardingPath()
//
//    var body: some View {
//        NavigationStack(path: $path.steps) {
//            WelcomeView()
//                .navigationDestination(for: OnboardingStep.self) { step in
//                    switch step {
//                    case .welcome:
//                        WelcomeView()
//                    case .personalInfo:
//                        PersonalInfoView()
//                    case .preferences:
//                        PreferencesView()
//                    case .summary:
//                        SummaryView()
//                    }
//                }
//        }
//        .environmentObject(path)
//    }
//}
//
//struct WelcomeView: View {
//    @EnvironmentObject var path: OnboardingPath
//    
//    var body: some View {
//        VStack {
//            Text("Welcome to the App")
//                .font(.largeTitle)
//                .padding()
//            
//            NavigationLink(destination: PersonalInfoView()) {
//                Text("Go to Personal Info")
//            }
//            .padding()
//            
//            NavigationLink(value: OnboardingStep.personalInfo) {
//                Text("Go to Personal Info")
//            }
//            .padding()
//            
//            NavigationLink("Go to Personal Info", destination: PersonalInfoView())
//                .padding()
//                .background(Color.blue)
//                .foregroundColor(.white)
//                .cornerRadius(8)
//        }
//    }
//}
//
//struct PersonalInfoView: View {
//    @EnvironmentObject var path: OnboardingPath
//    
//    var body: some View {
//        VStack {
//            Text("Enter Your Personal Information")
//                .font(.title)
//                .padding()
//            
//            NavigationLink("Next", value: OnboardingStep.preferences)
//                .padding()
//                .background(Color.blue)
//                .foregroundColor(.white)
//                .cornerRadius(8)
//        }
//    }
//}
//
//struct PreferencesView: View {
//    @EnvironmentObject var path: OnboardingPath
//    
//    var body: some View {
//        VStack {
//            Text("Set Your Preferences")
//                .font(.title)
//                .padding()
//            
//            NavigationLink("Next", value: OnboardingStep.summary)
//                .padding()
//                .background(Color.blue)
//                .foregroundColor(.white)
//                .cornerRadius(8)
//        }
//    }
//}
//
//struct SummaryView: View {
//    @EnvironmentObject var path: OnboardingPath
//    
//    var body: some View {
//        VStack {
//            Text("You have completed the onboarding process!")
//                .padding()
//            
//            NavigationLink(destination: MainAppView().navigationBarBackButtonHidden(true)) {
//                Text("Go to Main App")
//                    .padding()
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(8)
//            }
//        }
//    }
//}
//
//struct MainAppView: View {
//    var body: some View {
//        Text("Welcome to the Main App!")
//            .font(.largeTitle)
//            .padding()
//    }
//}

// Documentation -> 
/*
Sí, hay varios inicializadores de NavigationLink que puedes usar para manejar la navegación en SwiftUI. Aquí te explico las diferentes formas y sus casos de uso:

1. NavigationLink(destination:label:)
Descripción:
Este inicializador te permite especificar directamente la vista de destino y el contenido del enlace. Es el más común y directo.

Uso:
Directo: Cuando quieres navegar a una vista específica y no necesitas usar un valor para determinar el destino.
Configuración: Permite una configuración completa del enlace y de la vista de destino.
Ejemplo:

NavigationLink(destination: PersonalInfoView()) {
    Text("Go to Personal Info")
}
En este caso, al presionar el botón "Go to Personal Info", se navega directamente a PersonalInfoView.

2. NavigationLink(value:label:)
Descripción:
Este inicializador usa un valor para determinar la vista de destino a través de una NavigationStack que usa un path y navigationDestination(for:).

Uso:
Path-Driven Navigation: Ideal cuando tienes una navegación basada en valores y quieres que la vista de destino se maneje a través del path de la navegación.
Declarativo: Permite una configuración más declarativa y dinámica de la navegación.
Ejemplo:


NavigationLink(value: OnboardingStep.personalInfo) {
    Text("Go to Personal Info")
}
Este NavigationLink usa el valor OnboardingStep.personalInfo para determinar la vista a mostrar, basada en el path de NavigationStack.

3. NavigationLink("Title", destination:)
Descripción:
Este inicializador permite especificar un título (como una cadena) y una vista de destino. Es útil cuando deseas un enlace con un texto estático y una vista específica.

Uso:
Texto Estático: Cuando tienes un título fijo para el enlace y deseas especificar la vista de destino.
Ejemplo:


NavigationLink("Go to Personal Info", destination: PersonalInfoView())
El texto del enlace será "Go to Personal Info" y llevará a PersonalInfoView.
 
 
 🚨 __________________________________________________________________________________________________ 🚨
 
 
 La diferencia clave en el comportamiento entre NavigationLink(value:label:) y NavigationLink(destination:label:) radica en cómo interactúan con el NavigationStack y cómo se maneja el estado de navegación.

 NavigationLink(value:label:)
 Comportamiento:

 Navegación Basada en la Ruta: Este inicializador está diseñado para funcionar con un NavigationStack que utiliza una ruta para gestionar el estado de navegación. Cuando usas NavigationLink(value:), estás empujando un valor en la ruta, que el NavigationStack luego usa para determinar qué vista mostrar.
 Navegación Dinámica: Dado que la ruta es una lista dinámica, puedes agregar múltiples valores a ella, lo que te permite navegar a través de una secuencia de vistas. Cada valor en la ruta corresponde a una vista, y el NavigationStack se encarga de mostrar la vista correcta en función de la ruta actual.
 Ejemplo de Uso:

 swift
 Copy code
 NavigationLink(value: OnboardingStep.personalInfo) {
     Text("Ir a Información Personal")
 }
 En este caso, OnboardingStep.personalInfo se agrega a la ruta. El NavigationStack usa la ruta para determinar la vista a mostrar en función del valor.

 NavigationLink(destination:label:)
 Comportamiento:

 Navegación Directa: Este inicializador crea un enlace directo a una vista específica. Cuando usas este tipo de NavigationLink, estás especificando directamente una vista de destino única. Hacer clic en el enlace te lleva directamente a esa vista.
 Navegación Estática: Una vez que navegas a la vista de destino, el estado de navegación se gestiona dentro de la vista misma. Si deseas navegar a otra vista desde la vista de destino, necesitas manejar el estado de navegación manualmente en esa vista de destino.
 Ejemplo de Uso:

 swift
 Copy code
 NavigationLink(destination: PersonalInfoView()) {
     Text("Ir a Información Personal")
 }
 En este caso, hacer clic en "Ir a Información Personal" te lleva directamente a PersonalInfoView. Sin embargo, si PersonalInfoView contiene otro NavigationLink(destination:label:) a otra vista, no funcionará como se espera porque el estado de navegación no se comparte ni se actualiza a través de una ruta.

 Por Qué la Navegación Basada en el Valor Funciona para Múltiples Vistas
 Al usar NavigationLink(value:), aprovechas la capacidad del NavigationStack para gestionar una ruta de navegación. Esto te permite agregar múltiples valores (pasos) a la ruta, cada uno correspondiente a una vista diferente, lo que habilita una navegación fluida y consistente a través de una secuencia de vistas.

 Por Qué la Navegación Basada en el Destino No Permite Múltiples Vistas
 Con NavigationLink(destination:), la navegación es más directa y aislada. Cada enlace solo maneja la navegación a una única vista. Si deseas manejar una navegación adicional dentro de esa vista de destino, necesitas gestionarla directamente dentro de la vista de destino misma, lo que puede llevar a problemas si no se maneja correctamente.

EJEMPLO-> 
 
 struct WelcomeView: View {
     @EnvironmentObject var path: OnboardingPath
     
     var body: some View {
         VStack {
             Text("Welcome View")
             
             // Path-driven navigation 🌟
             NavigationLink(value: OnboardingStep.personalInfo) {
                 Text("Go to Personal Info")
             }
             .padding()
             
             // Static destination-based navigation (not path-driven) 🌟
             NavigationLink(destination: PersonalInfoView()) {
                 Text("Go to Personal Info")
             }
             .padding()
             .background(Color.blue)
             .foregroundColor(.white)
             .cornerRadius(8)
         }
     }
 }
*/
