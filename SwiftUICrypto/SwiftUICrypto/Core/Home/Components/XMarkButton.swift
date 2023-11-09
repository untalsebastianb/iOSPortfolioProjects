//
//  XMarkButton.swift
//  SwiftUICrypto
//
//  Created by Juan Sebastian Bueno on 11/8/23.
//

import SwiftUI

struct XMarkButton: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Button { 
            dismiss()
        } label: { 
            Image(systemName: "xmark")
                .font(.headline)
        }
    }
}

struct XMarkButton_Previews: PreviewProvider {
    static var previews: some View {
        XMarkButton()
    }
}
