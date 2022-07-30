//
//  CalculatePrimeOperation.swift
//  ConcurrencyTest
//
//  Created by Sebastian on 30/07/22.
//  Copyright © 2022 raywenderlich. All rights reserved.
//

import Foundation

class CalculatePrimeOperation: Operation {

    override func main() {
        for number in 0...1_000_000 {
          let isPrimeNumber = isPrime(number: number)
          print("\(number) is prime: \(isPrimeNumber)")
        }
    }
    
    func isPrime(number: Int) -> Bool {
      if number <= 1 {
        return false
      }
      if number <= 3 {
        return true
      }
      var i = 2
      while i * i <= number {
        if number % i == 0 {
          return false
        }
        i = i + 2
      }
      return true
    }
}
