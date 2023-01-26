//
//  ProductListViewController.swift
//  RestTask
//
//  Created by John Doe on 2023-01-25.
//

import UIKit
import Combine
import SVProgressHUD

class ProductsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    static func ViewController() -> ProductsViewController {
        let sb = UIStoryboard(name: "Main", bundle: .main)
        if let vc = sb.instantiateViewController(withIdentifier: "ProductsViewController") as? ProductsViewController {
            
            return vc
        }
        fatalError("Products vc not found!")
    }
    let coredata = CoreDataManager.shared
    var viewModel: ProductsViewModelProtocol!
    
    private var cancellabels = Set<AnyCancellable>()
    
    //MARK: - Lif Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ProductsViewModel()
        bindProducts()
        loadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableViewSetup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
    }
    //MARK: - UI -
    private func setupNavigation() {
        title = "Products"
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
        let alert = UIAlertController(title: "Error fetching data", message: "Please, Check network, back and try to add again.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Thanks", style: .cancel))
        self.present(alert, animated: true)
    }
    
    //MARK: - Data -
    func loadData() {
        SVProgressHUD.show()
        viewModel.getProducts()
    }
    
    func bindProducts() {
        viewModel.errorPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] error in
                if let error = error {
                    SVProgressHUD.dismiss()
                    self?.showError(error: error)
                }
            })
            .store(in: &cancellabels)
        
        viewModel.productsSuccessPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] fetched in
                if fetched ?? false {
                    self?.fetchSuccess()
                    print("You can proceed now")
                }
            })
            .store(in: &cancellabels)
    }
    
    private func fetchSuccess() {
        SVProgressHUD.dismiss()
        self.tableView.reloadData()
    }
}
//MARK: - UITableViewDataSource -
extension ProductsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(tableViewCell: ProductTableViewCell.self, forIndexPath: indexPath)
        cell.cellConfigProduct(name: viewModel.productName(index: indexPath.row), price: viewModel.productPrice(index: indexPath.row),image: viewModel.productImage(index: indexPath.row))
        return cell
    }
}
//MARK: - UITableViewDelegate -
extension ProductsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.saveProduct(index: indexPath.row)
        self.navigationController?.popViewController(animated: true)
    }
}
