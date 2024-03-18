//
//  ProductDetailsVC.swift
//  Shopcy
//
//  Created by Sri Charan Vattikonda on 3/9/24.
//

import UIKit

class ProductDetailsVC: UIViewController {
    
    @IBOutlet weak var descriptionTV: UITextView!
    
    @IBOutlet weak var ratingLBL: UILabel!
    @IBOutlet weak var messageLBL: UILabel!
    @IBOutlet weak var priceLBL: UILabel!
    
    @IBOutlet weak var imgIV: UIImageView!
    
    @IBOutlet weak var imageChangePC: UIPageControl!
    
    @IBOutlet weak var itemColors: UIButton!
    @IBOutlet weak var cartBTN: UIButton!
    @IBOutlet weak var buyBTN: UIButton!
    @IBOutlet weak var memorySize: UIButton!
    
    var productKey: String  = ""
    var product: Product = Product(title: "", description: "", price: 0, discountPercentage: 0, rating: 0, thumbnail: "", images: [], cartCount: 0)
    var imgCount = 0
    var imageIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        product = FireStoreOperations.products[productKey]!
        
        navigationItem.title = product.title
        descriptionTV.text = product.description
        ratingLBL.text = String(product.rating) + "⭐️"
        imgIV.sd_setImage(with: URL(string: product.thumbnail), placeholderImage: UIImage(systemName: "iphone.gen1"))
        priceLBL.text = "$" + String(format: "%.2f", product.price - product.price * (product.discountPercentage / 100))
        imageChangePC.numberOfPages = product.images.count
        
        imgCount = product.images.count
        imgIV.isUserInteractionEnabled = true
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeImages))
        imgIV.addGestureRecognizer(swipeLeft)
        swipeLeft.direction = .left
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeImages))
        imgIV.addGestureRecognizer(swipeRight)
        swipeRight.direction = .right
        
        imageChangePC.currentPage = imageIndex
        setUpColorButton()
        setSizeButton()
        
        
        print(productKey)
    }
    
    
    @objc func swipeImages(_ imageSwipe: UISwipeGestureRecognizer){
        
        if imageSwipe.direction == .left{
            if imageIndex >= 0 && imageIndex < imgCount-1{
                imageIndex = imageIndex + 1
            }
        }
        else if imageSwipe.direction == .right{
            if imageIndex > 0 && imageIndex < imgCount{
                imageIndex = imageIndex - 1
            }
        }
        imgIV.sd_setImage(with: URL(string: product.images[imageIndex]))
        imageChangePC.currentPage = imageIndex
    }
    
    func setUpColorButton(){
        
        let options = {(action : UIAction) in
            print(action.title)}
        
        itemColors.menu = UIMenu(title: "Color", children: [
            UIAction(title: "White⬜️", state: .on, handler: options),
            UIAction(title: "Black⬛️", handler: options),
            UIAction(title: "Red🟥", handler: options),
            UIAction(title: "Green🟩", handler: options),
            UIAction(title: "Blue🟦", handler: options)])
        
        itemColors.showsMenuAsPrimaryAction = true
        itemColors.changesSelectionAsPrimaryAction = true
    }
    
    func setSizeButton(){
        
        let options = {(action : UIAction) in
            print(action.title)}
        
        memorySize.menu = UIMenu(title: "Memory", children: [
            UIAction(title: "128GB", state: .on, handler: options),
            UIAction(title: "256GB", handler: options),
            UIAction(title: "512GB", handler: options),
            UIAction(title: "1TB", handler: options),
            UIAction(title: "2TB", handler: options)])
        
        memorySize.showsMenuAsPrimaryAction = true
        memorySize.changesSelectionAsPrimaryAction = true
    }
    
    @IBAction func addToCart(_ sender: UIButton) {
        FireStoreOperations.products[productKey]!.cartCount = (FireStoreOperations.products[productKey]!.cartCount) + 1
        
        Task{
            await FireStoreOperations.updateProduct(productKey)
        }
        self.messageLBL.text = "Item Added To Cart"
        sender.isEnabled = false
    }
    
    @IBAction func buy(_ sender: UIButton) {
        
        let price = Double(product.price) - (Double(product.discountPercentage / 100) * Double(product.price))
        
        let formattedTotalPrice = String(format: "%.2f", price)
        let selectedSize = memorySize.title(for: .normal) ?? ""
        let selectedColor = itemColors.title(for: .normal) ?? ""
        
        let message = "Price: \(formattedTotalPrice)\nSize: \(selectedSize)\nColor: \(selectedColor)"
        
        let confirmAlert = UIAlertController(title: "Confirm Order", message: message, preferredStyle: .alert)
        confirmAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        confirmAlert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { _ in
            let thankYouAlert = UIAlertController(title: "Thank You", message: "Thanks for shopping with us!", preferredStyle: .alert)
            thankYouAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(thankYouAlert, animated: true, completion: nil)
        }))
        
        present(confirmAlert, animated: true, completion: nil)
    }
    
    @IBAction func logout(_ sender: UIBarButtonItem) {
        let logoutAlert = UIAlertController(title: "Logout", message: "Would you like to logout?", preferredStyle: .alert)
        logoutAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        logoutAlert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { _ in
            do{
                try AuthenticationManager.shared.signOut()
            }
            catch{
                print("Logout error: \(error.localizedDescription)")
            }
            self.performSegue(withIdentifier: "productDetailsToLogin", sender: self)
        }))
        
        self.present(logoutAlert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "productDetailsToLogin":
            let destVC = segue.destination as? LoginVC
            destVC?.navigationItem.title = ""
            destVC?.navigationItem.hidesBackButton = true
        default:
            break
        }
    }
}
