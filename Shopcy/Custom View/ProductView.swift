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
    @IBOutlet weak var discountPriceLBL: UILabel!
    @IBOutlet weak var actualPriceLBL: UILabel!
    
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
        self.addSubview(viewOfXib)
    }

}
