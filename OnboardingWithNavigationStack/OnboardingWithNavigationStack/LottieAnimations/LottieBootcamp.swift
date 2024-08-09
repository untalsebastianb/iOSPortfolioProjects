//
//  LottieBootcamp.swift
//  OnboardingWithNavigationStack
//
//  Created by Juan Sebastian Bueno on 8/3/24.
//

import SwiftUI
import Lottie

struct LottieBootcamp: View {
    var body: some View {
        LottieView(animation: .named("StarAnimation"))
            .resizable()
            .playbackMode(.playing(.toProgress(1, loopMode: .loop)))
            .animationDidFinish { completed in
                // execute code. 
            }
            .frame(width: 30, height: 30)
    }
}

#Preview {
    LottieBootcamp()
}
