//
//  ProductDetailsViewController.swift
//  RestTask
//
//  Created by John Doe on 2023-01-26.
//

import UIKit

class ProductDetailsViewController: UIViewController {
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var dataView: UIView!
    @IBOutlet weak var productView: UIView!
    @IBOutlet weak var descTextView: UITextView!
    
    var product: Product? {
        didSet {
            DispatchQueue.main.async { [self] in
                handleDataShow()
            }
        }
    }

    static func ViewController() -> ProductDetailsViewController {
        let sb = UIStoryboard(name: "Main", bundle: .main)
        if let vc = sb.instantiateViewController(withIdentifier: "ProductDetailsViewController") as? ProductDetailsViewController {
            return vc
        }
        fatalError("Products vc not found!")
    }
    
    //MARK: - Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        handleViews()
    }
    
    //MARK: - UI -
    private func handleViews() {
        productView.clipsToBounds = true
        productView.layer.cornerRadius = productView.frame.width/2
        productImageView.clipsToBounds = true
        productImageView.layer.cornerRadius = productImageView.frame.width/2
        dataView.clipsToBounds = true
        dataView.layer.cornerRadius = 12
    }
    
    //MARK: - Data -
    private func handleDataShow() {
        guard product != nil else { return }
        productImageView.sd_setImage(with: URL(string: product?.imageURL ?? ""))
        nameLabel.text = product?.name
        priceLabel.text = "\(product?.retailPrice ?? 0)$"
        descTextView.text = product?.description
    }
    
    
    
}
