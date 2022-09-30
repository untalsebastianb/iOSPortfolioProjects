//
//  ViewModel.swift
//  Instagram-SwiftUI
//
//  Created by Sebastian on 29/09/22.
//

import Foundation
import SwiftUI

class ViewModel: ObservableObject {
    @Published var timeLineList = [TimelineModel]()
    @Published var storyList = [StoryModel]()
    
    init() {
        self.timeLineList = TimelineModel.getPost()
        self.storyList = StoryModel.getStories()
    }
}
