//
//  ViewController.swift
//  Generics
//
//  Created by Sebastian on 10/10/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //    Now i can call the API caller for many types
        APICaller.shared.performAPICall(url: "https:api.service.com/getCars", expectingReturnType: Car.self) { result in
            switch result {
            case .success(let car):
                print(car.carModel)
            case .failure(let error):
                print(error)
            }
        }
        
        APICaller.shared.performAPICall(url: "https:api.service.com/getFruits", expectingReturnType: Fruit.self) { result in
            switch result {
            case .success(let fruit):
                print(fruit.name)
            case .failure(let error):
                print(error)
            }
        }
    }
    



}

class APICaller {
    static let shared = APICaller()
    
//    Generic call
    public func performAPICall<T: Codable>(url:String, expectingReturnType: T.Type, completion: @escaping((Result<T, Error>) -> Void)) {
        let task =  URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
            guard let data = data , error == nil else {
                return
            }
            
//            if this is a car you need to replace the type, is not scallable
            let decodedResult: T?
            do {
                decodedResult = try JSONDecoder().decode(T.self, from: data)
            }
            catch {
                decodedResult = nil
            }
            
            guard let result = decodedResult else {
//                call failure cases
                return
            }
            
            completion(.success(result))
        })
        
        task.resume()
    }
    
//    non generic call
    public func getFruits() {
        URLSession.shared.dataTask(with: URL(string: "foo")!) { data, response, error in
            guard let data = data , error == nil else {
                return
            }
            
//            if this is a car you need to replace the type, is not scallable
            let fruit: Fruit?
            do {
                fruit = try JSONDecoder().decode(Fruit.self, from: data)
            }
            catch {
                print(error)
            }
        }
    }
}

// you probably will have more than one API CALL

struct Fruit: Codable {
    let name: String
    let identifier: String
    let imageName: String
}

struct Car: Codable {
    let carModel: String
    let name: String
    let identifier: String
    let imageName: String
}

struct Recipes: Codable {
    let name: String
    let recipiesType: String
    let imageName: String
}
