//
//  TaskListView.swift
//  FigmaToCode
//
//  Created by Juan Sebastian Bueno on 23/05/23.
//

import SwiftUI

struct TaskListView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image("ic-hamburguer")
                }

                ToolbarItem(placement: .principal) {
                    Text("Today")
                        .font(.navTitle)
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Image("ic-dots")
                }

            }
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}
