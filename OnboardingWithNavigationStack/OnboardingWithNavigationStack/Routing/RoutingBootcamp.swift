//
//  RoutingBootcamp.swift
//  OnboardingWithNavigationStack
//
//  Created by Juan Sebastian Bueno on 8/3/24.
//

import SwiftUI
import SwiftfulRouting

//struct MyHomeViewNS: View {
//    @State var showSheet = false
//    var body: some View {
//        NavigationStack { 
//            Button("Go to Sheet") { 
//                showSheet = true
//            }
//        }
//        .navigationTitle("Home View")
//        .sheet(isPresented: $showSheet, content: {
//            MyThirdScreenNS()
//        })
//    }
//}
//
//
//struct MyThirdScreenNS: View {
//    var body: some View {
//        NavigationStack(root: { 
//            Text("Hello from third screen")
//            
//            NavigationLink("Go to anotherScreen") { 
//                Text("Another Screen")
//            }
//            .navigationTitle("Third View")
//        })
//    }
//}
//
//// Main View
//struct RoutingBootcampNS: View {
//    var body: some View {
//        NavigationStack{
//            MyHomeViewNS()            
//        }
//    }
//}


// Main View
struct RoutingBootcamp: View {
    var body: some View {
        RouterView { router in
            MyHomeView(viewModel: MyHomeViewModel(router: router))
        }
    }
}

final class MyHomeViewModel: ObservableObject {
    let router: AnyRouter
    
    init(router: AnyRouter) {
        self.router = router
    }
    
    func goToNextScreen() {
        router.showScreen(.push) { router in
            MyThirdScreen(router: router)
        }
    }
}

struct MyHomeView: View {
    // doin the routing from the view
//    @Environment(\.router) var router
//    let router: AnyRouter
    @StateObject var viewModel: MyHomeViewModel
    let route: AnyRoute = AnyRoute(.push) { router in
        MyThirdScreen(router: router)
    }
    
    var body: some View {
        Button(action: {
            viewModel.goToNextScreen()
        }, label: {
            Text("Click me")
        })
//        Button(action: {
//            router.showScreen(.sheet) { _ in
//                MyThirdScreen()
//            }
//        }, label: {
//            Text("Click me")
//        })
        .navigationTitle("Home View")
    }
}


struct MyThirdScreen: View {
    // doin the routing from the view
//    @Environment(\.router) var router
    let router: AnyRouter
    var body: some View {
        Button(action: {
            router.dismissScreen()
        }, label: {
            Text("Dismiss")
        })
        .navigationTitle("Third View")
    }
}

#Preview {
    RoutingBootcamp()
}
