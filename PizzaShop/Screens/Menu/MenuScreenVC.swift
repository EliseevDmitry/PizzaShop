//
//  ViewController.swift
//  PizzaShop
//
//  Created by Dmitriy Eliseev on 18.11.2024.
//

import UIKit
import SwiftUI

final class MenuScreenVC: UIViewController {

    let productsLoader: IProductsLoader
    let cartStorage: IStorageService
    
    init(productsLoader: IProductsLoader, cartStorage: IStorageService) {
        self.productsLoader = productsLoader
        self.cartStorage = cartStorage
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var catProducts: [AllProducts] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    let menu = MenuCollectionView()
    var indexCatArr: [IndexPath] = []

    private lazy var tableView: UITableView = {
        //не думал что их можно прописать тут (всегда прописывал в viewDidLoad())
        $0.dataSource = self //таблица делегирует свои методы по заполнению таблицы (datasource)
        $0.delegate = self //методы поведения (delegate) на выполнение контроллеру
        if #available(iOS 15.0, *) {
            $0.sectionHeaderTopPadding = 0
        }
        $0.registerCell(ProductTableViewCell.self)
        $0.registerCell(PromoTableViewCell.self)
        $0.registerCell(TopMenuTableViewCell.self)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .orange
        $0.separatorStyle = .none
        $0.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        $0.rowHeight = UITableView.automaticDimension
        return $0
    }(UITableView())
    
    //точка входа в контроллер
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setupViews()
        setupConstraints()
        fetchProducts()
        let remove = cartStorage.removeAllEntities()
        print(remove)
    }

    private func fetchProducts() {
        productsLoader.loadProducts() { [weak self] item in
            self?.catProducts = item
        }
    }
    
    func selectItem(index: Int) {
        let indexPath = IndexPath(row: 0, section: index)
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    
}

extension MenuScreenVC {

    private func setupViews() {
        [tableView].forEach{
            view.addSubview($0)
        }
    }
    
    private func setupConstraints(){
        let safeArea = view.safeAreaLayoutGuide
        tableView.snp.makeConstraints { make in
            make.top.right.bottom.left.equalTo(safeArea)
        }
    }
}

extension MenuScreenVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Количество ячеек будет создаваться от количества элементов в массиве - products
        let countProduct = catProducts.map{$0.products.count}.reduce(0){ $0 + $1 }
        return countProduct
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let products = catProducts.flatMap{$0.products}
        let product = products[indexPath.row]
        if product.isPromo {
            indexCatArr.append(indexPath)
            let cell = tableView.dequeueCell(indexPath) as PromoTableViewCell
            cell.update(product)
            return cell
        } else {
            let cell = tableView.dequeueCell(indexPath) as ProductTableViewCell
            cell.update(product)
            
            cell.onProductTap = { product in
                print(product)
                self.productCellPriceTap(product)
            }
            
            return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let fixedHeaderView = UIView()
            fixedHeaderView.backgroundColor = .white
            menu.onProductSelected = { [weak self] index in   
                if let currentIndex = self?.getIndexPath(scrollIndex: index) {
                    tableView.scrollToRow(at: currentIndex, at: .top, animated: true)
                }
            }
            fixedHeaderView.addSubview(menu)
            menu.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            return fixedHeaderView
        }
        return UIView()
    }
    
    private func getIndexPath(scrollIndex: Int) -> IndexPath {
        var counter = Int()
        for (index, item) in catProducts.enumerated() {
            if index < scrollIndex {
                counter += item.products.count
            }
        }
        return IndexPath(row: counter, section: 0)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 44 : 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let products = catProducts.flatMap{$0.products}
        let product = products[indexPath.row]
        let detailVC = DetailViewController(detail: product.detail)
        detailVC.modalPresentationStyle = .automatic
            present(detailVC, animated: true)
    }
 
}

//MARK: Event Handler
extension MenuScreenVC {
    
    func productCellPriceTap(_ product: Product) {
        
        cartStorage.addProduct(product: product)
    }
}

//MARK: - Preview

//struct MenuScreenVCPreviews: PreviewProvider {
//    
//    struct MenuScreenVCContainer: UIViewControllerRepresentable {
//        func makeUIViewController(context: Context) -> some UIViewController {
//            UINavigationController(rootViewController:  MenuScreenVC(coder: <#NSCoder#>))
//        }
//        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
//    }
//    
//    static var previews: some View {
//        MenuScreenVCContainer().ignoresSafeArea()
//    }
//}

extension MenuScreenVC {
    
}
