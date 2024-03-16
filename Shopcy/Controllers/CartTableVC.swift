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
    
    var products: [String : Product] = FireStoreOperations.products
    var requiredProductsKeys: [String] = []
    var totalPrice: Double = 0
    
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
        
        for key in requiredProductsKeys {
            let product = products[key]!
            let price = (product.price - product.price * (product.discountPercentage/100)) * Double(product.cartCount)
            self.totalPrice += price
        }
        
        self.priceLBL.text = "$" + String(format: "%.2f", self.totalPrice)
        
    }
    
    @IBAction func buyCart(_ sender: UIButton) {
        let confirmAlert = UIAlertController(title: "Confirm Order", message: "Do you want make the total purchase of amount $" + String(format: "%.2f", self.totalPrice), preferredStyle: .alert)
        confirmAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        confirmAlert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { _ in
            for key in self.requiredProductsKeys {
                FireStoreOperations.products[key]!.cartCount = 0
                Task{
                    await FireStoreOperations.updateProduct(key)
                }
            }
            let thankYouAlert = UIAlertController(title: "Thank You", message: "Thanks for shopping with us!", preferredStyle: .alert)
            thankYouAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(thankYouAlert, animated: true, completion: nil)
            self.messageLBL.text = "Cart is Empty"
            self.totalPrice = 0
            self.priceLBL.text = "$" + String(format: "%.2f", self.totalPrice)
            self.requiredProductsKeys = []
            self.productsTV.reloadData()
        }))
        
        present(confirmAlert, animated: true, completion: nil)
    }
    
    @IBAction func clearCart(_ sender: UIButton) {
        let confirmAlert = UIAlertController(title: "Clear Cart", message: "Do you wish to clear items in your cart?", preferredStyle: .alert)
        confirmAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        confirmAlert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { _ in
            for key in self.requiredProductsKeys {
                FireStoreOperations.products[key]!.cartCount = 0
                Task{
                    await FireStoreOperations.updateProduct(key)
                }
            }
            let clearAlert = UIAlertController(title: "Clear Cart", message: "Your cart has been cleared", preferredStyle: .alert)
            clearAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(clearAlert, animated: true, completion: nil)
            self.messageLBL.text = "Cart is Empty"
            self.totalPrice = 0
            self.priceLBL.text = "$" + String(format: "%.2f", self.totalPrice)
            self.requiredProductsKeys = []
            self.productsTV.reloadData()
        }))
        
        present(confirmAlert, animated: true, completion: nil)
        
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
        self.products = FireStoreOperations.products
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
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let removeAction = UIContextualAction(style: .normal, title: "-"){ action, view,
            completion in
            let key = self.requiredProductsKeys[indexPath.row]
            if FireStoreOperations.products[key]!.cartCount == 1 {
                self.requiredProductsKeys.remove(at: indexPath.row)
            }
            FireStoreOperations.products[key]!.cartCount = FireStoreOperations.products[key]!.cartCount - 1
            Task{
                await FireStoreOperations.updateProduct(key)
            }
            
            self.productsTV.reloadData()
            
            self.totalPrice = 0
            for key in self.requiredProductsKeys {
                let product = self.products[key]!
                let price = (product.price - product.price * (product.discountPercentage/100)) * Double(product.cartCount)
                self.totalPrice += price
            }
            if(self.totalPrice == 0){
                self.messageLBL.text = "Cart is Empty"
            }
            
            self.priceLBL.text = "$" + String(format: "%.2f", self.totalPrice)
            completion(true)
        }
        
        removeAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [removeAction])
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let addAction = UIContextualAction(style: .normal, title: "+"){ action, view,
            completion in
            let key = self.requiredProductsKeys[indexPath.row]
            FireStoreOperations.products[key]!.cartCount = FireStoreOperations.products[key]!.cartCount + 1
            Task{
                await FireStoreOperations.updateProduct(key)
            }
            
            
            self.productsTV.reloadData()
            self.totalPrice = 0
            for key in self.requiredProductsKeys {
                let product = self.products[key]!
                let price = (product.price - product.price * (product.discountPercentage/100)) * Double(product.cartCount)
                self.totalPrice += price
            }
            
            self.priceLBL.text = "$" + String(format: "%.2f", self.totalPrice)
            completion(true)
        }
        
        addAction.backgroundColor = .green
        return UISwipeActionsConfiguration(actions: [addAction])
    }
    
}
