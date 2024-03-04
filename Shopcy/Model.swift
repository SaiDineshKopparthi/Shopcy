//
//  Model.swift
//  Shopcy
//
//  Created by Sai Dinesh Kopparthi on 2/5/24.
//

import Foundation
import Alamofire


struct Product {
    let title: String
    let description: String
    let price: Double
    let discountPercentage: Double
    let rating: Double
    let thumbnail: String
    let images:[String]
    let cartCount: Int
}

struct UtilityConstant {
    let products: [Product] = [
        Product(title: "iPhone 9", description: "An apple mobile which is nothing like apple", price: 549, discountPercentage: 12.96, rating: 4.69, thumbnail: "https://cdn.dummyjson.com/product-images/1/thumbnail.jpg", images: [
            "https://cdn.dummyjson.com/product-images/1/1.jpg",
            "https://cdn.dummyjson.com/product-images/1/2.jpg",
            "https://cdn.dummyjson.com/product-images/1/3.jpg",
            "https://cdn.dummyjson.com/product-images/1/4.jpg",
            "https://cdn.dummyjson.com/product-images/1/thumbnail.jpg"
        ], cartCount: 0),
        
        Product(title: "iPhone X", description: "SIM-Free, Model A19211 6.5-inch Super Retina HD display with OLED technology A12 Bionic chip.", price: 899, discountPercentage: 17.94, rating: 4.44, thumbnail: "https://cdn.dummyjson.com/product-images/2/thumbnail.jpg", images: [
            "https://cdn.dummyjson.com/product-images/2/1.jpg",
            "https://cdn.dummyjson.com/product-images/2/2.jpg",
            "https://cdn.dummyjson.com/product-images/2/3.jpg",
            "https://cdn.dummyjson.com/product-images/2/thumbnail.jpg"
        ], cartCount: 0),
        
        Product(title: "Samsung Universe 9", description: "Samsung's new variant which goes beyond Galaxy to the Universe", price: 1249, discountPercentage: 15.46, rating: 4.09, thumbnail: "https://cdn.dummyjson.com/product-images/3/thumbnail.jpg", images: [
            "https://cdn.dummyjson.com/product-images/3/1.jpg"
        ], cartCount: 0),
        
        Product(title: "OPPOF19", description: "OPPO F19 is officially announced on April 2021.", price: 280, discountPercentage: 17.91, rating: 4.3, thumbnail: "https://cdn.dummyjson.com/product-images/4/thumbnail.jpg", images: [
            "https://cdn.dummyjson.com/product-images/4/1.jpg",
            "https://cdn.dummyjson.com/product-images/4/2.jpg",
            "https://cdn.dummyjson.com/product-images/4/3.jpg",
            "https://cdn.dummyjson.com/product-images/4/4.jpg",
            "https://cdn.dummyjson.com/product-images/4/thumbnail.jpg"
        ], cartCount: 0),
        
        Product(title: "Huawei P30", description: "Huawei’s re-badged P30 Pro New Edition was officially unveiled yesterday in Germany and now the device has made its way to the UK.", price: 499, discountPercentage: 10.58, rating: 4.09, thumbnail: "https://cdn.dummyjson.com/product-images/5/thumbnail.jpg", images: [
            "https://cdn.dummyjson.com/product-images/5/1.jpg",
            "https://cdn.dummyjson.com/product-images/5/2.jpg",
            "https://cdn.dummyjson.com/product-images/5/3.jpg"
        ], cartCount: 0),
        
        Product(title: "MacBook Pro", description: "MacBook Pro 2021 with mini-LED display may launch between September, November", price: 1749, discountPercentage: 11.02, rating: 4.57, thumbnail: "https://cdn.dummyjson.com/product-images/6/thumbnail.png", images: [
            "https://cdn.dummyjson.com/product-images/6/1.png",
            "https://cdn.dummyjson.com/product-images/6/2.jpg",
            "https://cdn.dummyjson.com/product-images/6/3.png",
            "https://cdn.dummyjson.com/product-images/6/4.jpg"
        ], cartCount: 0),
        
        Product(title: "Samsung Galaxy Book", description: "Samsung Galaxy Book S (2020) Laptop With Intel Lakefield Chip, 8GB of RAM Launched", price: 1499, discountPercentage: 4.15, rating: 4.25, thumbnail: "https://cdn.dummyjson.com/product-images/7/thumbnail.jpg", images: [
            "https://cdn.dummyjson.com/product-images/7/1.jpg",
            "https://cdn.dummyjson.com/product-images/7/2.jpg",
            "https://cdn.dummyjson.com/product-images/7/3.jpg",
            "https://cdn.dummyjson.com/product-images/7/thumbnail.jpg"
        ], cartCount: 0),
        
        Product(title: "Microsoft Surface Laptop 4", description: "The Microsoft Surface Laptop 4 has the same design as the Surface Laptop 3.", price: 1299, discountPercentage: 13.33, rating: 4.38, thumbnail: "https://cdn.dummyjson.com/product-images/8/thumbnail.jpg", images: [
            "https://cdn.dummyjson.com/product-images/8/1.jpg",
            "https://cdn.dummyjson.com/product-images/8/2.jpg",
            "https://cdn.dummyjson.com/product-images/8/3.jpg",
            "https://cdn.dummyjson.com/product-images/8/thumbnail.jpg"
        ], cartCount: 0),
        
        Product(title: "Dell XPS 13", description: "Dell XPS 13 Laptop (2020) features a 13.4 inches display with a screen resolution of 1920 x 1200 pixels", price: 1199, discountPercentage: 8.34, rating: 4.52, thumbnail: "https://cdn.dummyjson.com/product-images/9/thumbnail.jpg", images: [
            "https://cdn.dummyjson.com/product-images/9/1.jpg",
            "https://cdn.dummyjson.com/product-images/9/2.jpg",
            "https://cdn.dummyjson.com/product-images/9/3.jpg",
            "https://cdn.dummyjson.com/product-images/9/thumbnail.jpg"
        ], cartCount: 0),
        
        Product(title: "Sony PlayStation 5", description: "Sony PlayStation 5 with an all-new design and a range of powerful features.", price: 499, discountPercentage: 6.41, rating: 4.86, thumbnail: "https://cdn.dummyjson.com/product-images/10/thumbnail.jpg", images: [
            "https://cdn.dummyjson.com/product-images/10/1.jpg",
            "https://cdn.dummyjson.com/product-images/10/2.jpg",
            "https://cdn.dummyjson.com/product-images/10/3.jpg",
            "https://cdn.dummyjson.com/product-images/10/thumbnail.jpg"
        ], cartCount: 0)
    ]

}

//struct ProductResponse: Decodable {
//    let products: [Product]
//    let total: Int
//    let skip: Int
//    let limit: Int
//}
//
//struct Product: Decodable {
//    let id: Int
//    let title: String
//    let description: String
//    let price: Double
//    let discountPercentage: Double
//    let rating: Double
//    let stock: Int
//    let brand: String
//    let category: String
//    let thumbnail: String
//    let images: [String]
//}
//
//class ProductManager {
//    static let shared = ProductManager()
//    
//    var productResponse: ProductResponse?
//    
//    func fetchProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
//        let url = "https://dummyjson.com/products"
//        
//        AF.request(url)
//            .validate()
//            .responseDecodable(of: ProductResponse.self) { response in
//                switch response.result {
//                case .success(let productResponse):
//                    self.productResponse = productResponse
//                    completion(.success(productResponse.products))
//                case .failure(let error):
//                    completion(.failure(error))
//                }
//            }
//    }
//}
