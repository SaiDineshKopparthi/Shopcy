//
//  ViewController.swift
//  Shopcy
//
//  Created by Sai Dinesh Kopparthi on 2/5/24.
//

import UIKit

class ViewController: UIViewController {
    
    let productArray: [Int] = [1, 2, 3, 4, 5, 6, 7, 8]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //        ProductManager.shared.fetchProducts { result in
        //            switch result {
        //            case .success(let products):
        //                print("Products: \(products)")
        //            case .failure(let error):
        //                print("Error fetching products: \(error)")
        //            }
        //        }
        
        for (index, value) in productArray.enumerated() {
            
            let prouductView = ProductView()
            
        }
        
        
    }


}

