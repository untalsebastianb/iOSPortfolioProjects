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
        // Do any additional setup after loading the view.
    }


}

class APICaller {
    static let shared = APICaller()
    
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
    let name: String
    let identifier: String
    let imageName: String
}

struct Recipes: Codable {
    let name: String
    let recipiesType: String
    let imageName: String
}
