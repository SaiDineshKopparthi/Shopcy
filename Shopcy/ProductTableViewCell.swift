//
//  ProductTableViewCell.swift
//  Shopcy
//
//  Created by Sai Dinesh Kopparthi on 3/14/24.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productIV: UIImageView!
    @IBOutlet weak var titleLBL: UILabel!
    @IBOutlet weak var priceLBL: UILabel!
    @IBOutlet weak var productCountLBL: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
