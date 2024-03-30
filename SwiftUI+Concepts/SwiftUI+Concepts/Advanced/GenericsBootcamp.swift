//
//  GenericsBootcamp.swift
//  SwiftUI+Concepts
//
//  Created by Juan Sebastian Bueno on 3/21/24.
//

import SwiftUI

struct StringModel {
    let info: String?
    func removeInfo() -> StringModel {
        return StringModel(info: nil)
    }
}

struct boolModel {
    let info: Bool?
    func removeInfo() -> boolModel {
        return boolModel(info: nil)
    }
}

struct GenericModel<T> {
    let info: T?
    func removeInfo() -> GenericModel {
        return GenericModel(info: nil)
    }
}

struct GenericView<CustomType: View>: View {
    let content: CustomType
    var body: some View {
        VStack {
            content
            Text("Hi G View") 
        }
    }
}

class GenericsViewModel: ObservableObject {
    
    @Published var stringModel = StringModel(info: "Hello World!")
    @Published var booleanModel = boolModel(info: true)
    @Published var genericStringModel = GenericModel(info: "Hello Generics")
    @Published var genericBoolModel = GenericModel(info: true)
    @Published var dataArray: [String] = []
    
    init() {
        dataArray = ["one", "two", "three"]
    }
    
    func removeData() {
        stringModel = stringModel.removeInfo()
        booleanModel = booleanModel.removeInfo()
        genericStringModel = genericStringModel.removeInfo()
        genericBoolModel = genericBoolModel.removeInfo()
    }
}

struct GenericsBootcamp: View {
    
    @StateObject private var vm = GenericsViewModel()
    
    var body: some View {
        VStack {
            
            GenericView(content: Text("Hii gg view"))
            
            Text(vm.stringModel.info ?? "no data")
            Text(vm.booleanModel.info?.description ?? "no data")
            Text(vm.genericBoolModel.info?.description ?? "no data")
            Text(vm.genericStringModel.info?.description ?? "no data")
            
        }
        .onTapGesture {
            vm.removeData()
        }
    }
}

#Preview {
    GenericsBootcamp()
}
