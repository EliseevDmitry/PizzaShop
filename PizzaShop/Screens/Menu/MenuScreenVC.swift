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
    //это заставляет обновлять таблицу при каждом обновлении перевменной products?
    var products: [Product] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    //всегда был вопрос по набору параметров которые мы устанавливаем при инициализации во время создания таблицы
    //private lazy - не сразу появилось, не совсем понимаю ее логику в ключе клоужура (тем более без нее - не работает)
    private lazy var tableView: UITableView = {
        //не думал что их можно прописать тут (всегдла прописывал в viewDidLoad())
        $0.dataSource = self //таблица делегирует свои методы по заполнению таблицы (datasource)
        $0.delegate = self //методы поведения (delegate) на выполение контроллеру
        //Чтобы ячейка взлетела нужно зарегистрировать ячейку в таблице
        //что дает сокращенная форма записи:
        //tableView.register(ProductCell.self, forCellReuseIdentifier: ProductCell.reuseId)
        $0.registerCell(ProductCell.self) // - просто для понимания - что это дает?
        //если мы НЕ используем SnapKit требуется translatesAutoresizingMaskIntoConstraints установить false!!
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .orange
        $0.rowHeight = UIScreen.main.bounds.width * 0.4
        $0.separatorStyle = .none
        $0.contentInset = UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0)
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
        products = productService.fetchProducts()
    }
}

//Выносим в отдельный extension методы расстановки view и констрэйнтов
extension MenuScreenVC {
    //установка UI
    private func setupViews() {
        view.addSubview(tableView)
    }
    
    //установка констрэйнтов
    private func setupConstraints(){
        let safeArea = view.safeAreaLayoutGuide
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 0).isActive = true
        tableView.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: .zero).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: .zero).isActive = true
        tableView.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: .zero).isActive = true
    }
}

extension MenuScreenVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return 1 //Возвращаем количество ячеек в таблице в секции
        //Количество ячеек будет создаваться от количества элементов в массиве - products
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //создать ячейку в методе датасорса tableView: cellForRowAt:
        
        //использовал let cell без guard, также пока непонятна форма записи с дженериком
        //let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.reuseId, for: indexPath) as! ProductCell //работает без кастинга as! ProductCell
        
        let cell = tableView.dequeuCell(indexPath) as ProductCell
        let product = products[indexPath.row]
        cell.update(product)
        // return UITableViewCell() // инициализируем пустую ячейку
        return cell
    }
    
}
