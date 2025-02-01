//
//  ViewController.swift
//  PizzaShop
//
//  Created by Dmitriy Eliseev on 18.11.2024.
//

import UIKit

final class MenuScreenVC: UIViewController {
    
    func selectItem(index: Int) {
        let indexPath = IndexPath(row: 0, section: index)
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }

    let productsLoader = ProductsLoader()
    
    var catProducts: [AllProducts] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    let menu = MenuItemCV()
    var indexCatArr: [IndexPath] = []

    private lazy var tableView: UITableView = {
        //не думал что их можно прописать тут (всегда прописывал в viewDidLoad())
        $0.dataSource = self //таблица делегирует свои методы по заполнению таблицы (datasource)
        $0.delegate = self //методы поведения (delegate) на выполнение контроллеру
        if #available(iOS 15.0, *) {
            $0.sectionHeaderTopPadding = 0
        }
        $0.registerCell(ProductCell.self)
        $0.registerCell(PromoCell.self)
        $0.registerCell(TopMenuCell.self)
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
    }

    private func fetchProducts() {
        productsLoader.loadProducts() { [weak self] item in
            self?.catProducts = item
        }
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
            let cell = tableView.dequeueCell(indexPath) as PromoCell
            cell.update(product)
            return cell
        } else {
            let cell = tableView.dequeueCell(indexPath) as ProductCell
            cell.update(product)
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
 
}

    
    

