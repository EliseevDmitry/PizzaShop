//
//  ViewController.swift
//  PizzaShop
//
//  Created by Dmitriy Eliseev on 18.11.2024.
//

import UIKit

//закрываем класс от наследования
final class MenuScreenVC: UIViewController, SelectCollectionViewItemProtocol {
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
    
    var fixedHeaderView: UIView?
    let menu = MenuItemCV()
    
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
}

extension MenuScreenVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Количество ячеек будет создаваться от количества элементов в массиве - products
        
        return catProducts[section].products.count //+ 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
//        if products[indexPath.section] == 0 {
//            if products[indexPath.section].products[indexPath.row] == 0 {
//                let cell = tableView.dequeueCell(indexPath) as TopMenuCell
//                return cell
//            }
//        }
        let product = self.catProducts[indexPath.section].products[indexPath.row]
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        print("количество секций - \(catProducts.count)")
        return catProducts.count
      }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    
       // print(section)
        if section == 1 {
            fixedHeaderView = UIView()
            guard let header = fixedHeaderView else { return nil }
            header.backgroundColor = .white

            menu.cellDelegate = self
            
            header.addSubview(menu)

            menu.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }

            return header
        }
        print(section)
        return UIView()
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        print("Секция № \(section)")
        return section == 1 ? 44 : 0
    }
    

    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let visibleCells = tableView.visibleCells
            
            // Получаем индекс первой видимой ячейки
            if let firstVisibleCell = visibleCells.first,
               let indexPath = tableView.indexPath(for: firstVisibleCell) {
                
                let section = indexPath.section
                
                print("Начало новой секции: \(section)")
               // menu.cellForItem(at: IndexPath(row: 0, section: section))
            }
        }
    
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

    
    

