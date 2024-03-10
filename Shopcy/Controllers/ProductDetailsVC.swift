//
//  ProductDetailsVC.swift
//  Shopcy
//
//  Created by Sri Charan Vattikonda on 3/9/24.
//

import UIKit

class ProductDetailsVC: UIViewController {
    
    var products: [Product] = []
    var imgCount = 0
    var imageIndex = 0
    
    @IBOutlet weak var descriptionLBL: UILabel!
    @IBOutlet weak var ratingLBL: UILabel!
    @IBOutlet weak var imgIV: UIImageView!
    @IBOutlet weak var imageChangePC: UIPageControl!
    @IBOutlet weak var priceLBL: UILabel!
    @IBOutlet weak var discountSW: UISwitch!
    @IBOutlet weak var discountPrice: UILabel!
    @IBOutlet weak var iemColors: UIButton!
    @IBOutlet weak var quantityTF: UITextField!
    @IBOutlet weak var cartBTN: UIButton!
    @IBOutlet weak var buyBTN: UIButton!
    @IBOutlet weak var memorySize: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print(products)
        navigationItem.title = products[0].title
        //titleLBL.text = products[0].title
        descriptionLBL.text = products[0].description
        ratingLBL.text = String(products[0].rating) + "⭐️"
        imgIV.sd_setImage(with: URL(string: products[0].thumbnail), placeholderImage: UIImage(systemName: "iphone.gen1"))
        priceLBL.text = "$" + String(products[0].price)
        discountSW.isOn = false
        imageChangePC.numberOfPages = products[0].images.count
        
        imgCount = products[0].images.count
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
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addDiscount(_ sender: UISwitch) {
        if sender.isOn {
                let discount = products[0].price * (products[0].discountPercentage / 100)
                let discountedPrice = products[0].price - discount
                let formattedDiscount = String(format: "%.2f", discount)
                let formattedDiscountedPrice = String(format: "%.2f", discountedPrice)
            discountPrice.text = "\(products[0].discountPercentage)% discount is added. You save $\(formattedDiscount)"
                priceLBL.text = "$\(formattedDiscountedPrice)"
            } else {
                let formattedPrice = String(format: "%.2f", products[0].price)
                priceLBL.text = "$\(formattedPrice)"
                discountPrice.text = "No discount added"
            }

    }
    
    
    @objc func swipeImages(_ imageSwipe: UISwipeGestureRecognizer){

            if imageSwipe.direction == .left{
                if imageIndex >= 0 && imageIndex < imgCount{
                    imageIndex = imageIndex + 1
                }
            }
            else if imageSwipe.direction == .right{
                if imageIndex > 0 && imageIndex < imgCount{
                    imageIndex = imageIndex - 1
                }
            }
        imgIV.sd_setImage(with: URL(string: products[0].images[imageIndex]))
        imageChangePC.currentPage = imageIndex
        }
    
    func setUpColorButton(){
            
            let options = {(action : UIAction) in
                print(action.title)}
            
            iemColors.menu = UIMenu(title: "Color", children: [
                UIAction(title: "White⬜️", state: .on, handler: options),
                UIAction(title: "Black⬛️", handler: options),
                UIAction(title: "Red🟥", handler: options),
                UIAction(title: "Green🟩", handler: options),
                UIAction(title: "Blue🟦", handler: options)])
            
            iemColors.showsMenuAsPrimaryAction = true
            iemColors.changesSelectionAsPrimaryAction = true
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

    
    
    @IBAction func selectColor(_ sender: UIButton) {
    }
    
    @IBAction func addToCart(_ sender: UIButton) {
    }
    
    @IBAction func buy(_ sender: UIButton) {
        guard let quantity = Int(quantityTF.text ?? "1"), quantity > 0 else {
                return
            }
            
            var totalPrice = Double(products[0].price) * Double(quantity)
            if discountSW.isOn {
                let discount = Double(products[0].discountPercentage / 100) * Double(products[0].price)
                totalPrice -= discount
            }
            
            let formattedTotalPrice = String(format: "%.2f", totalPrice)
            let selectedSize = memorySize.title(for: .normal) ?? ""
            let selectedColor = iemColors.title(for: .normal) ?? ""
            let selectedQuantity = quantityTF.text ?? "1"
            
            var message = "Price: \(formattedTotalPrice)\nSize: \(selectedSize)\nColor: \(selectedColor)\nQuantity: \(selectedQuantity)"
            
            if discountSW.isOn {
                let discountAmount = discountPrice.text ?? "0"
                message += "\nDiscount: \(discountAmount)"
            }
            
            let confirmAlert = UIAlertController(title: "Confirm Order", message: message, preferredStyle: .alert)
            confirmAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            confirmAlert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { _ in
                let thankYouAlert = UIAlertController(title: "Thank You", message: "Thanks for shopping with us!", preferredStyle: .alert)
                thankYouAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(thankYouAlert, animated: true, completion: nil)
            }))
            
            present(confirmAlert, animated: true, completion: nil)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
