//
//  ContentView.swift
//  GRtest
//
//  Created by Juan Sebastian Bueno on 9/20/24.
//

// TODO: initial value with different Heights, when views are conditionals
// calculate the size with a GR using + @Binding from parent to child
/**
 .background(
     GeometryReader(content: { proxy in
         Color.clear
             .onAppear(perform: {
                 updateDetents(height: proxy.size.height + 30)
             })
             .onChange(of: proxy.size, {
                 updateDetents(height: proxy.size.height + 30)
             })
     })

 )
 */
// TODO: update detent height when toggle state
/**

 +Onchange in parent view like 🚨Approach #1
 this can also be done with preference Key

 .background(
     GeometryReader(content: { proxy in
         Color.clear
             .onAppear(perform: {
                 updateDetents(height: proxy.size.height + 30)
             })
             .onChange(of: proxy.size, {
                 updateDetents(height: proxy.size.height + 30)
             })
     })

 you need to always update the supportedDetents
 Task {
     let finalHeight = height
     let newDetent: PresentationDetent = .height(finalHeight)
     supportedDetents.insert(newDetent)
     selectedDetent = newDetent
 }

 )
 */
// use approach with onChange and with Preference Key
import SwiftUI

/** 🚨Approach #1 with animation and SupportedDetents
struct ParentView: View {
    @State private var showSheet = false
    @State var selectedDetent: PresentationDetent = .height(0)
    @State var supportedDetents: Set<PresentationDetent> = [.medium]

    var body: some View {
        VStack {
            Text("show Sheet")
                .onTapGesture {
                    showSheet = true
                }
        }
        .sheet(isPresented: $showSheet) {
            ContentView(selectedDetent: $selectedDetent, supportedDetents: $supportedDetents)
                .presentationDetents(supportedDetents, selection: $selectedDetent)
                .onChange(of: selectedDetent) { _, newValue in
                    selectedDetent = newValue
                }
        }
    }
}

struct ContentView: View {
    @State private var showConsoles = false
    @State private var showGames = false
    @Binding var selectedDetent: PresentationDetent
    @Binding var supportedDetents: Set<PresentationDetent>
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")

            if showConsoles {
                VStack(spacing: 10, content: {
                    Text("Xbox")
                    Text("PlayStation5")
                    Text("Nintendo Switch")
                })
            }

            if showGames {
                VStack(spacing: 10, content: {
                    Text("COD MW3")
                    Text("FC24")
                    Text("It Takes 2")
                })
            }


            HStack(spacing: 10, content: {
                Button(action: {
                    withAnimation {
                        showConsoles.toggle()
                    }
                }, label: {
                    Text("Show Consoles")
                })
                Button(action: {
                    withAnimation {
                        showGames.toggle()
                    }
                }, label: {
                    Text("Show Games")
                })
            })
        }
        .background(
            GeometryReader(content: { proxy in
                Color.clear
                    .onAppear(perform: {
                        updateDetents(height: proxy.size.height + 30)
                    })
                    .onChange(of: proxy.size, {
                        updateDetents(height: proxy.size.height + 30)
                    })
            })

        )
        .padding(.top, 40)
        .padding(.bottom, 30)

    }

    private func updateDetents(height: CGFloat) {
        Task {
            let finalHeight = height
            let newDetent: PresentationDetent = .height(finalHeight)
            supportedDetents.insert(newDetent)
            selectedDetent = newDetent
        // if delay 0.4 seg and updated supportedDetents set only with newDetent to eliminate drag gesture
        }

    }

}

 **/

struct ParentView: View {
    @State private var showSheet = false
    @State var selectedDetent: PresentationDetent = .height(0)
    @State var supportedDetents: Set<PresentationDetent> = [.medium]
    @State var viewHeigh: CGFloat = .zero

    var body: some View {
        VStack {
            Text("show Sheet")
                .onTapGesture {
                    showSheet = true
                }
        }
        .sheet(isPresented: $showSheet) {
            ContentView(viewHeight: $viewHeigh)
                .presentationDetents([.height(viewHeigh)])
        }
    }
}

struct ContentView: View {
    @State private var showConsoles = false
    @State private var showGames = false
    @Binding var viewHeight: CGFloat
    var body: some View {
        VStack(spacing: 20) {
            Text("view Height: \(viewHeight)")
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")

            if showConsoles {
                VStack(spacing: 10, content: {
                    Text("Xbox")
                    Text("PlayStation5")
                    Text("Nintendo Switch")
                })
            }

            if showGames {
                VStack(spacing: 10, content: {
                    Text("COD MW3")
                    Text("FC24")
                    Text("It Takes 2")
                })
            }


            HStack(spacing: 10, content: {
                Button(action: {showConsoles.toggle()}, label: {
                    Text("Show Consoles")
                })
                Button(action: {showGames.toggle()}, label: {
                    Text("Show Games")
                })
            })
        }
        .padding(.top, 20)
        .background(
            GeometryReader(content: { proxy in
                Color.clear
                    .onAppear(perform: {
                        viewHeight = proxy.size.height
                    })
                    .onChange(of: proxy.size, {
                            viewHeight = proxy.size.height
                    })
            })

        )
        .overlay(
            ShowSize()
        )
    }
}


/** Read the frame with GEOMETRY READER - using OnChange
struct ContentView: View {
    @State private var showConsoles = false
    @State private var showGames = false
    @State private var viewHeight: CGFloat = 0
    var body: some View {
        VStack(spacing: 20) {
            Text("view Height: \(viewHeight)")
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")

            if showConsoles {
                VStack(spacing: 10, content: {
                    Text("Xbox")
                    Text("PlayStation5")
                    Text("Nintendo Switch")
                })
            }

            if showGames {
                VStack(spacing: 10, content: {
                    Text("COD MW3")
                    Text("FC24")
                    Text("It Takes 2")
                })
            }


            HStack(spacing: 10, content: {
                Button(action: {showConsoles.toggle()}, label: {
                    Text("Show Consoles")
                })
                Button(action: {showGames.toggle()}, label: {
                    Text("Show Games")
                })
            })
        }
        .padding(.top, 20)
        .background(
            GeometryReader(content: { proxy in
                Color.clear
                    .onAppear(perform: {
                        viewHeight = proxy.size.height
                    })
                    .onChange(of: proxy.size, {
                        viewHeight = proxy.size.height
                    })
            })

        )
        .overlay(
            ShowSize()
                .offset(y: -30)
        )
        .border(.red)
    }
}

 **/

struct ShowSize: View {
    var comment: String = ""
    var body: some View {
        GeometryReader(content: { proxy in
            ZStack(alignment: .center, content: {
                Rectangle()
                    .strokeBorder(.red, style: StrokeStyle(dash: [1, 0, 1]))
                Text("w:\(String(format: "%.2f", proxy.size.width)) h:\(String(format: "%.2f", proxy.size.height)) - \(comment)")
                    .font(.footnote)
                    .foregroundColor(.white)
                    .padding(5)
                    .background(Color.black.opacity(0.5))
            })
        })
    }
}


#Preview {
    ParentView()
}
