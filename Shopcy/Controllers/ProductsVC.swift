//
//  ProductsVC.swift
//  Shopcy
//
//  Created by Sai Dinesh Kopparthi on 3/6/24.
//

import UIKit
import SDWebImage
class ProductsVC: UIViewController {

    //Collection of Product Views
    @IBOutlet var productViewCLCTN: [ProductView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var count = 0
        let products: [String : Product] = FireStoreOperations.products
        for key in products.keys{
            let product = products[key]!
            productViewCLCTN[count].titleLBL.text = product.title
            productViewCLCTN[count].descriptionLBL.text = product.description
            productViewCLCTN[count].ratingLBL.text = "\(product.rating)/5.0"
            productViewCLCTN[count].discounAndActualPriceLBL.text = "\(product.discountPercentage)/\(product.price)"
            productViewCLCTN[count].productIMG.sd_setImage(with: URL(string: product.thumbnail), placeholderImage: UIImage(systemName: "iphone.gen1"))
            
            count += 1
        }
    }
}
