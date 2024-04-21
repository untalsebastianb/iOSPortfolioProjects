//
//  SwiftUI_ConceptsApp.swift
//  SwiftUI+Concepts
//
//  Created by Juan Sebastian Bueno on 3/20/24.
//

import SwiftUI

@main
struct SwiftUI_ConceptsApp: App {
    let dataService = ProductionDataService(url: URL(string: "https://jsonplaceholder.typicode.com/posts")!)
    var body: some Scene {
        WindowGroup {
            Transition()
            //DependencyInjectionBootcamp(dataService: dataService)
        }
    }
}
