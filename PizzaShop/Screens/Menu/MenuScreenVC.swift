//
//  ViewController.swift
//  PizzaShop
//
//  Created by Dmitriy Eliseev on 18.11.2024.
//

import UIKit

//закрываем класс от наследования
final class MenuScreenVC: UIViewController {
    
    let productService = ProductsService()
    //это заставляет обновлять таблицу при каждом обновлении переменной products?
    
    var products: [Product] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    //всегда был вопрос по набору параметров которые мы устанавливаем при инициализации во время создания таблицы
    //private lazy - не сразу появилось, не совсем понимаю ее логику в ключе клоужура (тем более без нее - не работает)
    private lazy var tableView: UITableView = {
        
        //не думал что их можно прописать тут (всегда прописывал в viewDidLoad())
        $0.dataSource = self //таблица делегирует свои методы по заполнению таблицы (datasource)
        $0.delegate = self //методы поведения (delegate) на выполнение контроллеру
        
        //Чтобы ячейка взлетела нужно зарегистрировать ячейку в таблице
        //что дает сокращенная форма записи:
        //tableView.register(ProductCell.self, forCellReuseIdentifier: ProductCell.reuseId)
        //регистрируем несколько ячеек в одной таблице
        $0.registerCell(ProductCell.self)
        $0.registerCell(PromoCell.self)
        //если мы НЕ используем SnapKit требуется translatesAutoresizingMaskIntoConstraints установить false!!
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .orange
        //$0.rowHeight = UIScreen.main.bounds.width * 0.4
        $0.separatorStyle = .none
        $0.contentInset = UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0)
        return $0
    }(UITableView())
    
    //точка входа в контроллер
    override func viewDidLoad() {
        super.viewDidLoad()
        print(UIScreen.main.bounds.width)
        print(UIScreen.main.bounds.height)
        view.backgroundColor = .red
        setupViews()
        setupConstraints()
        fetchProducts()
    }
    
    private func fetchProducts() {
        products = productService.fetchProducts()
    }
}

//Выносим в отдельный extension методы расстановки view и констрэйнтов
extension MenuScreenVC {
    //установка UI
    private func setupViews() {
        [tableView].forEach{
            view.addSubview($0)
        }
    }
    
    //установка констрэйнтов (переделать под SNP)
    private func setupConstraints(){
        let safeArea = view.safeAreaLayoutGuide
        tableView.snp.makeConstraints { make in
            make.top.right.bottom.left.equalTo(safeArea)
        }
    }
//    private func setupConstraints(){
//        let safeArea = view.safeAreaLayoutGuide
//        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 0).isActive = true
//        tableView.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: .zero).isActive = true
//        tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: .zero).isActive = true
//        tableView.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: .zero).isActive = true
//    }
}

extension MenuScreenVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Количество ячеек будет создаваться от количества элементов в массиве - products
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let product = products[indexPath.row]
        if product.isPromo {
            let cell = tableView.dequeueCell(indexPath) as PromoCell
            cell.update(product)
            return cell
        } else {
            let cell = tableView.dequeueCell(indexPath) as ProductCell
            cell.update(product)
            return cell
        }
    }
    
}
