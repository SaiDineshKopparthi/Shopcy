//
//  Model.swift
//  Shopcy
//
//  Created by Sai Dinesh Kopparthi on 2/5/24.
//

import Foundation
import Alamofire

struct ProductResponse: Decodable {
    let products: [Product]
    let total: Int
    let skip: Int
    let limit: Int
}

struct Product: Decodable {
    let id: Int
    let title: String
    let description: String
    let price: Double
    let discountPercentage: Double
    let rating: Double
    let stock: Int
    let brand: String
    let category: String
    let thumbnail: String
    let images: [String]
}

class ProductManager {
    static let shared = ProductManager()
    
    var productResponse: ProductResponse?
    
    func fetchProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
        let url = "https://dummyjson.com/products"
        
        AF.request(url)
            .validate()
            .responseDecodable(of: ProductResponse.self) { response in
                switch response.result {
                case .success(let productResponse):
                    self.productResponse = productResponse
                    completion(.success(productResponse.products))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
