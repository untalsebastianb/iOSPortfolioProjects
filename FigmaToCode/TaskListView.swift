//
//  TaskListView.swift
//  FigmaToCode
//
//  Created by Juan Sebastian Bueno on 23/05/23.
//

import SwiftUI

struct TaskListView: View {

    var tasks = Task.getDummyTask()
    var body: some View {

        ZStack {
            Color("Background")
                .ignoresSafeArea()

            ScrollView {
                ZStack {
                    Rectangle()
                        .foregroundColor(.white)
                    VStack{
                        HStack{
                            Text("Today")
                            Spacer()
                            Text("\(tasks.count)")
                            Image("ic-chevron")
                        }
                        .font(.taskText)

                        ForEach(tasks) { task in
                            HStack {
                                Image("ic-checkbox")
                                Text(task.title)
                                    .font(.taskText)
                                Spacer()
                                VStack (alignment: .trailing, spacing: 3){
                                    Text("18:00")
                                        .foregroundColor(Color("Alarm"))
                                        .font(.taskAlarmText)
                                    Image("ic-alarm")
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 16)
            }

            VStack {
                Spacer()
                HStack{
                    Spacer()
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 64, height: 64)
                        .foregroundColor(Color.accentColor)
                        .padding(.bottom, 28)
                        .padding(.trailing, 24)
                }
            }



        }
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
