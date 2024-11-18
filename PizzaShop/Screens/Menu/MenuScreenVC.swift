//
//  ViewController.swift
//  PizzaShop
//
//  Created by Dmitriy Eliseev on 18.11.2024.
//

import UIKit

//закрываем класс от наследования
final class MenuScreenVC: UIViewController {
    
   fileprivate var products = ["Гавайская", "Маргарита", "Буженина", "4 Сыра", "Пеперрони"]
    
    //всегда был вопрос по набору параметров которые мы устанавливаем при инициализации во время создания таблицы
    //private lazy - 
    private lazy var tableView: UITableView = {
        let tableView = UITableView()

        //не думал что их можно прописать тут (всегдла прописывал в viewDidLoad())
        tableView.dataSource = self //таблица делегирует свои методы по заполнению таблицы (datasource)
        tableView.delegate = self //методы поведения (delegate) на выполение контроллеру
        
        //Чтобы ячейка взлетела нужно зарегистрировать ячейку в таблице
        tableView.register(ProductCell.self, forCellReuseIdentifier: ProductCell.reuseId)
        
        //если мы НЕ используем SnapKit требуется translatesAutoresizingMaskIntoConstraints установить false!!
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .orange
        return tableView
    }()

    //точка входа в контроллер
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setupViews()
        setupConstraints()
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
        //как избасляться оптимально от magicNumbers такие как 0 и прочее?
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
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.reuseId, for: indexPath) as! ProductCell //работает без кастинга as! ProductCell
        
        let product = products[indexPath.row]
        cell.update(productName: product)
       // return UITableViewCell() // инициализируем пустую ячейку
        return cell
    }
}
