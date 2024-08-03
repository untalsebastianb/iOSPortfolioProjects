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

// OnboardingPath.swift
class OnboardingPath: ObservableObject {
    @Published var steps: [OnboardingStep] = []
}

// OnboardingStep.swift
enum OnboardingStep: Hashable, CaseIterable {
    case welcome
    case personalInfo
    case preferences
    case summary
}

// OnboardingView.swift
struct OnboardingView: View {
    @StateObject private var path = OnboardingPath()

    var body: some View {
        NavigationStack(path: $path.steps) {
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
        .environmentObject(path)
    }
}

// WelcomeView.swift
struct WelcomeView: View {
    @EnvironmentObject var path: OnboardingPath
    
    var body: some View {
        VStack {
            Text("Welcome to Our App!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            Text("This is the starting point of your onboarding journey. We'll guide you through the setup process.")
                .multilineTextAlignment(.center)
                .padding()
            
            Button("Get Started") {
                path.steps.append(.personalInfo)
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
    }
}

// PersonalInfoView.swift
struct PersonalInfoView: View {
    @EnvironmentObject var path: OnboardingPath
    
    var body: some View {
        VStack {
            Text("Personal Information")
                .font(.title2)
                .fontWeight(.semibold)
                .padding()
            Text("Please provide your personal information so we can tailor the experience just for you.")
                .multilineTextAlignment(.center)
                .padding()
            
            Button("Next: Preferences") {
                path.steps.append(.preferences)
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
    }
}

// PreferencesView.swift
struct PreferencesView: View {
    @EnvironmentObject var path: OnboardingPath
    
    var body: some View {
        VStack {
            Text("Set Your Preferences")
                .font(.title2)
                .fontWeight(.semibold)
                .padding()
            Text("Select your preferences to help us provide a more personalized experience.")
                .multilineTextAlignment(.center)
                .padding()
            
            Button("Next: Summary") {
                path.steps.append(.summary)
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
    }
}

// SummaryView.swift
struct SummaryView: View {
    @EnvironmentObject var path: OnboardingPath
    
    var body: some View {
        VStack {
            Text("Summary")
                .font(.title2)
                .fontWeight(.semibold)
                .padding()
            Text("You have completed the onboarding process. Here is a summary of your choices.")
                .multilineTextAlignment(.center)
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

// MainAppView.swift
struct MainAppView: View {
    var body: some View {
        Text("Welcome to the Main App!")
            .font(.largeTitle)
            .padding()
    }
}




// example with NavigationLink 
//
//enum OnboardingStep: Hashable {
//    case welcome
//    case personalInfo
//    case preferences
//    case summary
//}
//
//struct OnboardingView: View {
//    @State private var path: [OnboardingStep] = []
//
//    var body: some View {
//        NavigationStack(path: $path) {
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
//    }
//}
//
//struct WelcomeView: View {
//    var body: some View {
//        VStack {
//            Text("Welcome to the App")
//                .font(.largeTitle)
//                .padding()
//            NavigationLink("Next", value: OnboardingStep.personalInfo)
//                .padding()
//                .background(Color.blue)
//                .foregroundColor(.white)
//                .cornerRadius(8)
//        }
//    }
//}
//
//struct PersonalInfoView: View {
//    var body: some View {
//        VStack {
//            Text("Enter Your Personal Information")
//                .font(.title)
//                .padding()
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
//    var body: some View {
//        VStack {
//            Text("Set Your Preferences")
//                .font(.title)
//                .padding()
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
//    var body: some View {
//        VStack {
//            Text("Summary")
//                .font(.title)
//                .padding()
//            Text("You have completed the onboarding process!")
//                .padding()
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




