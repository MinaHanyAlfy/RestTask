//
//  ProductTableViewCell.swift
//  RestTask
//
//  Created by John Doe on 2023-01-25.
//

import UIKit
import SDWebImage

class ProductTableViewCell: UITableViewCell {

    
    @IBOutlet weak var numberOfProductLabel: UILabel!
    @IBOutlet weak var quantLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    
    @IBOutlet weak var mainView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    private func setUpView() {
        productImageView.clipsToBounds = true
        productImageView.layer.cornerRadius = productImageView.frame.width/2
        mainView.clipsToBounds = true
        mainView.layer.cornerRadius = 12
    }
    func cellConfigCart(product: Product) {
        productNameLabel.text = product.name
        productPriceLabel.text = "\(String(product.retailPrice))$"
        quantLabel.isHidden = false
        numberOfProductLabel.isHidden = false
        numberOfProductLabel.text = String(product.quantity ?? 1)
        productImageView.sd_setImage(with: URL(string: product.imageURL))

        
    }
    func cellConfigProduct(name: String, price: Int,image: String) {
        productNameLabel.text = name
        productPriceLabel.text = "\(String(price))$"
        productImageView.sd_setImage(with: URL(string: image))
        
        quantLabel.isHidden = true
        numberOfProductLabel.isHidden = true
    }
}
