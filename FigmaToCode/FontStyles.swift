//
//  FontStyles.swift
//  FigmaToCode
//
//  Created by Juan Sebastian Bueno on 23/05/23.
//

import Foundation
import SwiftUI

extension Font {
    static var navTitle: Font {
        return Font.custom("Inter-Bold", size: 17)
    }

    static var taskText: Font {
        return Font.custom("Inter-SemiBold", size: 14)
    }

    static var taskAlarmText: Font {
        return Font.custom("Inter-SemiBold", size: 12)
    }
}
