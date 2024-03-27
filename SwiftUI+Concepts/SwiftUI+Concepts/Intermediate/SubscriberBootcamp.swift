//
//  SubscriberBootcamp.swift
//  SwiftUI+Concepts
//
//  Created by Juan Sebastian Bueno on 3/27/24.
//

import SwiftUI
import Combine

/*
 
 
 this is the same of this
 .onReceive(vm.$textField, perform: { text in
            print("->> \(text)")
            vm.textIsValid = text.count > 3
        })
 
 
 func addTextfieldSubscriber() {
     $textField
         .map { text in
             if text.count > 3 {
                 return true
             } 
             return false
         }
         .assign(to: \.textIsValid, on: self)
         .store(in: &cancellables)
 }
 
 Cancel publishers ->
 class SubscriberBootcampVM: ObservableObject {
     @Published var count: Int = 0
     var timer: AnyCancellable?
     var cancellables = Set<AnyCancellable>()
     
     init() {
         setUpTimer()
     }
     
     func setUpTimer() {
         timer = Timer
             .publish(every: 1, on: .main, in: .common)
             .autoconnect()
             .sink { [weak self] _ in
                 guard let self = self else { return }
                 self.count += 1
                 // cancel 🔥
                 if self.count >= 10 {
                     self.timer?.cancel()
                 }
             }
 */

class SubscriberBootcampVM: ObservableObject {
    @Published var count: Int = 0
    var timer: AnyCancellable?
    var cancellables = Set<AnyCancellable>()
    @Published var textField = ""
    @Published var textIsValid: Bool = false
    @Published var showButton: Bool = false
    
    init() {
        setUpTimer()
        addTextfieldSubscriber()
        addButtonSubscriber()
    }
    
    func addTextfieldSubscriber() {
        $textField
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map { text in
                if text.count > 3 {
                    return true
                } 
                return false
            }
        // instead of using assing use sink! to use weak self
            .sink(receiveValue: { [weak self] isValid in
                self?.textIsValid = isValid
            })
//            .assign(to: \.textIsValid, on: self)
            .store(in: &cancellables)
    }
    
    func setUpTimer() {
         Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.count += 1
                // cancel 🔥
//                if self.count >= 10 {
//                    self.timer?.cancel()
//                }
            }
            .store(in: &cancellables)
    }
    
    func addButtonSubscriber() {
        $textIsValid
            .combineLatest($count)
            .sink { [weak self] isValid, count in
                guard let self = self else { return }
                if isValid && count > 10 {
                    self.showButton = true
                } else {
                    self.showButton = false
                }
            }
            .store(in: &cancellables)
    }
}

struct SubscriberBootcamp: View {
    
    @StateObject var vm = SubscriberBootcampVM()
    var body: some View {
        VStack {
            Text("\(vm.count)")
            Text(vm.textIsValid.description)
            
            TextField("Type here please", text: $vm.textField)
                .padding(.leading)
                .frame(height: 55)
                .font(.headline)
                .background(.gray)
                .cornerRadius(20)
                .overlay(
                    ZStack {
                        Image(systemName: "xmark")
                            .foregroundColor(.red)
                            .opacity(
                                vm.textField.count < 1 ? 0.0 :
                                vm.textIsValid ? 0.0 : 1.0)
                        
                        Image(systemName: "checkmark")
                            .foregroundColor(.green)
                            .opacity(vm.textIsValid ? 1.0 : 0.0)
                    }
                        .font(.title)
                        .padding(.trailing),
                    alignment: .trailing
                )
            
            
            Button { 
                
            } label: { 
                Text("Submit")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(.blue)
                    .cornerRadius(10)
                    .opacity(vm.showButton ? 1.0 : 0.5)
                
            }
            .disabled(!vm.showButton)

        }
        .padding(.horizontal)
//        .onReceive(vm.$count, perform: { count  in
//            print("timer value is -> \(count)")
//        })
//        .onReceive(vm.$textField, perform: { text in
//                   print("->> \(text)")
//                   vm.textIsValid = text.count > 3
//               })
    }
}

#Preview {
    SubscriberBootcamp()
}
