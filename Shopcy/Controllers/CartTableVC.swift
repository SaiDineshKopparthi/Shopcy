//
//  CartTableVC.swift
//  Shopcy
//
//  Created by Sai Dinesh Kopparthi on 3/14/24.
//

import UIKit

class CartTableVC: UIViewController {
    
    @IBOutlet weak var productsTV: UITableView!
    
    @IBOutlet weak var messageLBL: UILabel!
    @IBOutlet weak var priceLBL: UILabel!
    
    let products: [String : Product] = FireStoreOperations.products
    var requiredProductsKeys: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.productsTV.delegate = self
        self.productsTV.dataSource = self
        
        for key in products.keys {
            let product = products[key]!
            if product.cartCount > 0{
                requiredProductsKeys.append(key)
            }
        }
        
        if requiredProductsKeys.count == 0 {
            self.messageLBL.text = "Cart is Empty"
        }
        
        
        print(requiredProductsKeys)
        
    }
    
    @IBAction func buyCart(_ sender: UIButton) {
        
    }
    
    @IBAction func clearCart(_ sender: UIButton) {
        
    }
    
}

extension CartTableVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return requiredProductsKeys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as! ProductTableViewCell
        cell.selectionStyle = .none
        let product = products[requiredProductsKeys[indexPath.row]]!
        cell.productIV.sd_setImage(with: URL(string: product.thumbnail), placeholderImage: UIImage(systemName: "iphone.gen1"))
        cell.titleLBL.text = product.title
        cell.priceLBL.text = "$" + String(format: "%.2f", product.price - product.price * (product.discountPercentage / 100))
        cell.productCountLBL.text = String(product.cartCount)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}
