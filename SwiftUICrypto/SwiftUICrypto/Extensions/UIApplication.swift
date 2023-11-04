//
//  UIApplication.swift
//  SwiftUICrypto
//
//  Created by Juan Sebastian Bueno on 11/4/23.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
