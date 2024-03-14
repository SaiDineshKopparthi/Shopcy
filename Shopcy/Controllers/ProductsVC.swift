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
    
    var viewTag = 0
    var productKeys: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.displayProducts()
        self.productDetails()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let identifier = segue.identifier
        switch identifier{
        case "ProductDetail":
            guard let productDetailsVC = segue.destination as? ProductDetailsVC,
                  let selectedProductKey = sender as? String
            else{return}
            productDetailsVC.productKey = selectedProductKey
        default:
            break
        }
    }
    
    private func displayProducts(){
        var count = 0
        let products: [String : Product] = FireStoreOperations.products
        
        for key in products.keys{
            let product = products[key]!
            productViewCLCTN[count].titleLBL.text = product.title
            productViewCLCTN[count].descriptionLBL.text = product.description
            productViewCLCTN[count].ratingLBL.text = "\(product.rating) / 5.00"
            productViewCLCTN[count].discounAndActualPriceLBL.text = "$" + String(format: "%.2f", product.price - ((product.discountPercentage / 100) * product.price)) + " / $" + String(format: "%.2f", product.price)
            productViewCLCTN[count].productIMG.sd_setImage(with: URL(string: product.thumbnail), placeholderImage: UIImage(systemName: "iphone.gen1"))
            
            count += 1
            productKeys.append(key)
        }
    }
    
    func productDetails(){
        productViewCLCTN.forEach{ (product) in
            
            let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
            longPress.minimumPressDuration = 0.5
            
            product.isUserInteractionEnabled = true
            product.contentMode = .scaleToFill
            product.addGestureRecognizer(longPress)
        }
    }
    
    @objc func handleLongPress(_ sender: UILongPressGestureRecognizer){
        
        guard let recognizerView = sender.view
        else{return}
        viewTag = recognizerView.tag
        switch sender.state {
        case .began:
            let selectedProductKey = productKeys[viewTag]
            self.performSegue(withIdentifier: "ProductDetail", sender: selectedProductKey)
        default:
            break
        }
    }
}


