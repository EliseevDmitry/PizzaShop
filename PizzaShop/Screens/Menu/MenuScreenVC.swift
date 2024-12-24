//
//  ViewController.swift
//  PizzaShop
//
//  Created by Dmitriy Eliseev on 18.11.2024.
//

import UIKit

//закрываем класс от наследования
// , SelectCollectionViewItemProtocol
final class MenuScreenVC: UIViewController {
    
    func selectItem(index: Int) {
        let indexPath = IndexPath(row: 0, section: index)
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }

    //let productService = ProductsService()
    let productsLoader = ProductsLoader()
    //это заставляет обновлять таблицу при каждом обновлении переменной products?
    
    var catProducts: [AllProducts] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    //var fixedHeaderView: UIView?
    let menu = MenuItemCV()
    var indexCatArr: [IndexPath] = []
    
    //всегда был вопрос по набору параметров которые мы устанавливаем при инициализации во время создания таблицы
    //private lazy - не сразу появилось, не совсем понимаю ее логику в ключе клоужура (тем более без нее - не работает)
    private lazy var tableView: UITableView = {
        
        //не думал что их можно прописать тут (всегда прописывал в viewDidLoad())
        $0.dataSource = self //таблица делегирует свои методы по заполнению таблицы (datasource)
        $0.delegate = self //методы поведения (delegate) на выполнение контроллеру
        if #available(iOS 15.0, *) {
            $0.sectionHeaderTopPadding = 0
        }
        //Чтобы ячейка взлетела нужно зарегистрировать ячейку в таблице
        //что дает сокращенная форма записи:
        //tableView.register(ProductCell.self, forCellReuseIdentifier: ProductCell.reuseId)
        //регистрируем несколько ячеек в одной таблице
        $0.registerCell(ProductCell.self)
        $0.registerCell(PromoCell.self)
        $0.registerCell(TopMenuCell.self)
        //если мы НЕ используем SnapKit требуется translatesAutoresizingMaskIntoConstraints установить false!!
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .orange
        //$0.rowHeight = UIScreen.main.bounds.width * 0.4
        $0.separatorStyle = .none
        $0.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) //отступ от верха таблицы 100
        
        //
        //$0.estimatedRowHeight = 458  // Используйте предполагаемую высоту
        $0.rowHeight = UITableView.automaticDimension
        //
        
        return $0
    }(UITableView())
    
    //точка входа в контроллер
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setupViews()
        setupConstraints()
        fetchProducts()
        
        setupObservers()
    }

    private func fetchProducts() {
        productsLoader.loadProducts() { [weak self] item in
            self?.catProducts = item
        }
    }
    
    func setupObservers() {
        //tableView.onProductSelected = {}
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
//        if products[indexPath.section] == 0 {
//            if products[indexPath.section].products[indexPath.row] == 0 {
//                let cell = tableView.dequeueCell(indexPath) as TopMenuCell
//                return cell
//            }
//        }
        let products = catProducts.flatMap{$0.products}
        let product = products[indexPath.row]
        if product.isPromo {
            indexCatArr.append(indexPath)
            let cell = tableView.dequeueCell(indexPath) as PromoCell
            
            print("\(cell.bounds) - ячейка ПРОМО")
            print("\(cell.frame) - ячейка ПРОМО")
            
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
            //guard let header = fixedHeaderView else { return nil }
            fixedHeaderView.backgroundColor = .white
            //menu.cellDelegate = self
            
            menu.onProductSelected = { index in
                print(index)
                print(self.indexCatArr)
                tableView.scrollToRow(at: self.indexCatArr[index], at: .top, animated: true)
            }
            
            fixedHeaderView.addSubview(menu)
            menu.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            return fixedHeaderView
        }
        return UIView()
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 44 : 0
    }
    

    
    //Массив промо - и индекс
    //выравнивание по экрану
    

//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100  // Замените на нужную высоту для ячейки
//    }

    

    
    //
//    func scrollToSection(section: Int) {
//        let indexPath = IndexPath(row: 0, section: section)
//        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
//    }
 
}


//extension UITableView: SelectCollectionViewItemProtocol {
//    func selectItem(index: Int) {
//        let indexPath = IndexPath(row: index, section: 0)
//        self.scrollToRow(at: indexPath, at: .top, animated: true)
////        let indexPath = IndexPath(row: 0, section: section)
////        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
//    }

    
    

