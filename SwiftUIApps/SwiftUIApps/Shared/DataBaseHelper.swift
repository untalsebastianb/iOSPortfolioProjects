//
//  DataBaseHelper.swift
//  SwiftUIApps
//
//  Created by Juan Sebastian Bueno on 7/31/24.
//

import Foundation

struct DataBaseHelper {
    func getProducts() async throws -> [Product] {
        guard let url = URL(string: "https://dummyjson.com/products") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let products = try JSONDecoder().decodeWithDetailedError(ProductArray.self, from: data)
        return products.products
    }
    
    func getUsers() async throws -> [User] {
        guard let url = URL(string: "https://dummyjson.com/users") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let user = try JSONDecoder().decodeWithDetailedError(UserArray.self, from: data)
        return user.users
    }
}

// Extension to see what's wrong while decoding
extension JSONDecoder {
    func decodeWithDetailedError<T: Decodable>(_ type: T.Type, from data: Data) throws -> T {
        do {
            return try self.decode(T.self, from: data)
        } catch let DecodingError.dataCorrupted(context) {
            print("Data corrupted: \(context.debugDescription)")
            print("CodingPath: \(context.codingPath)")
            throw DecodingError.dataCorrupted(context)
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found: \(context.debugDescription)")
            print("CodingPath: \(context.codingPath)")
            throw DecodingError.keyNotFound(key, context)
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found: \(context.debugDescription)")
            print("CodingPath: \(context.codingPath)")
            throw DecodingError.valueNotFound(value, context)
        } catch let DecodingError.typeMismatch(type, context) {
            print("Type '\(type)' mismatch: \(context.debugDescription)")
            print("CodingPath: \(context.codingPath)")
            throw DecodingError.typeMismatch(type, context)
        } catch {
            print("Error: \(error.localizedDescription)")
            throw error
        }
    }
}


