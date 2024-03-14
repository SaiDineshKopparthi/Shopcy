//
//  Product.swift
//  Shopcy
//
//  Created by Sai Dinesh Kopparthi on 2/7/24.
//

import UIKit

class ProductView: UIView {

    @IBOutlet weak var titleLBL: UILabel!
    @IBOutlet weak var descriptionLBL: UILabel!
    @IBOutlet weak var ratingLBL: UILabel!
    @IBOutlet weak var discounAndActualPriceLBL: UILabel!
    
    
    @IBOutlet weak var productIMG: UIImageView!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.setUpXibView()
    }
    
    required init?(coder: NSCoder){
        super.init(coder: coder)
        self.setUpXibView()
    }
    
    private func setUpXibView(){
        guard let viewOfXib = Bundle.main.loadNibNamed("ProductView", owner: self)![0] as? UIView else {return}
        
        viewOfXib.frame = self.bounds
        viewOfXib.layer.cornerRadius = 5
        viewOfXib.layer.borderWidth = 2
        //viewOfXib.layer.borderColor = CGColor(red: 110, green: 90, blue: 238, alpha: 1)
        self.addSubview(viewOfXib)
    }

}
