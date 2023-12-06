//
//  String.swift
//  SwiftUICrypto
//
//  Created by Juan Sebastian Bueno on 12/6/23.
//

import Foundation

extension String {
    
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
}
