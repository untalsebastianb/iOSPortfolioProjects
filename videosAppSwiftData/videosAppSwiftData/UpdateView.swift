//
//  UpdateView.swift
//  videosAppSwiftData
//
//  Created by Juan Sebastian Bueno on 6/8/24.
//

import SwiftUI

struct UpdateView: View {
    @Bindable var video: Video
    
    var body: some View {
        Form {
            TextField("Edit video", text: $video.title)
            Toggle("Favorite Video", isOn: $video.medatadata.isFavorite)
        }
    }
}
