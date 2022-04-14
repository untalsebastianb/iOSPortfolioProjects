//
//  View+Extensions.swift
//  GameStream
//
//  Created by Sebastian on 14/04/22.
//

import SwiftUI

extension View {
    func hideNavigationBar() -> some View {
        self
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
    }
}
