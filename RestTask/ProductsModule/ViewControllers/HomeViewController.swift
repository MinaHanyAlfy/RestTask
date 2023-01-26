//
//  HomeViewController.swift
//  RestTask
//
//  Created by John Doe on 2023-01-25.
//

import UIKit
import Combine
import SVProgressHUD
class HomeViewController: UIViewController {
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var totalStackView: UIStackView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var zeroStateView: UIStackView!
    let coredata = CoreDataManager.shared
    var viewModel: HomeViewModelProtocol!
    
    //MARK: - Lif Cycle - 
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HomeViewModel()
        tableViewSetup()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
        setupNavigation()
        
    }
    

    
    //MARK: - UI -
    private func setupNavigation() {
        title = "Cart"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.tintColor = .black
    }
    
    private func tableViewSetup() {
        tableView.registerCell(tableViewCell: ProductTableViewCell.self)
        self.tableView.estimatedRowHeight = 88.0
        self.tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func showError(error: ErorrMessage) {
        let alert = UIAlertController(title: "Error fetching data", message: "Please, Check network, close the app and reopen it", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Thanks", style: .cancel))
        self.present(alert, animated: true)
    }
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Congratulations!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Thanks", style: .cancel))
        self.present(alert, animated: true)
    }
    
    @IBAction func buyAction(_ sender: Any) {
        viewModel.clearProducts()
        if viewModel.getProductsCount() == 0 {
            self.tableView.reloadData()
            self.tableView.isHidden = true
            self.totalStackView.isHidden = true
            totalPriceLabel.text = "0"
            zeroStateView.isHidden = false
            self.showAlert(message: "You buy products successfully.")
        } else {
            self.showError(error: ErorrMessage.InvalidRequest)
            
        }
    }
    
    @IBAction func addAction(_ sender: Any) {
        let vc = ProductsViewController.ViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func loadData() {
        SVProgressHUD.show()
        viewModel.getSavedProducts()
        if viewModel.getProductsCount() > 0 {
            SVProgressHUD.dismiss()
            tableView.isHidden = false
            totalStackView.isHidden = false
            handleTotalView()
            zeroStateView.isHidden = true
            self.tableView.reloadData()
        } else {
            zeroStateView.isHidden = false
            tableView.isHidden = true
            totalStackView.isHidden = true
            SVProgressHUD.dismiss()
        }
    }
    
    func handleTotalView() {
        totalPriceLabel.text = String(viewModel.getTotalPrice())
    }
   
}
//MARK: UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(tableViewCell: ProductTableViewCell.self, forIndexPath: indexPath)

        cell.cellConfigCart(product: viewModel.getProduct(index: indexPath.row))
    
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getProductsCount()
    }
}

//MARK: - UITableViewDelegate -
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected ", viewModel.getProduct(index: indexPath.row))
        
        let vc = ProductDetailsViewController.ViewController()
        vc.product = viewModel.getProduct(index: indexPath.row)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
