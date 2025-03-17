//
//  BasketViewController.swift
//  PizzaShop
//
//  Created by Dmitriy Eliseev on 15.03.2025.
//

import UIKit
import SwiftUI
import SnapKit

final class BasketViewController: UIViewController {
    
    let products: [Product]
    
    init(product: [Product]) {
        self.products = product
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var scrollView: UIScrollView = {
        $0.backgroundColor = .black
        return $0
    }(UIScrollView())
    
    private lazy var verticalStackView: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 15
        $0.alignment = .leading
        $0.distribution = .fill
        $0.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 12, trailing: 15)
        $0.isLayoutMarginsRelativeArrangement = true
        return $0
    }(UIStackView())
    
    private lazy var backgroundView: UIView = {
        $0.backgroundColor = .clear
        return $0
    }(UIView())
    
    private lazy var titleLabel: UILabel = {
        $0.text = "Корзина"
        $0.font = UIFont.boldSystemFont(ofSize: 16)
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.5
        $0.numberOfLines = 1
        $0.textAlignment = .center
        $0.textColor = .white
        return $0
    }(UILabel())
    
    
    private lazy var closeButton: UIButton = {
        $0.setTitle("Закрыть", for: .normal)
        $0.setTitleColor(.orange, for: .normal)
        $0.addTarget(nil, action: #selector(testBtn), for: .touchUpInside)
        return $0
    }(UIButton())
    
    private lazy var totalLabel: UILabel = {
        let rubleSymbol = "\u{20BD}"
        $0.text = "3 товара на 1398 \(rubleSymbol)"
        $0.font = UIFont.boldSystemFont(ofSize: 25)
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.5
        $0.numberOfLines = 1
        $0.textAlignment = .left
        $0.textColor = .white
        return $0
    }(UILabel())
    
    
    private lazy var tableView: UITableView = {
        $0.dataSource = self
        $0.delegate = self
        if #available(iOS 15.0, *) {
            $0.sectionHeaderTopPadding = 0
        }
        $0.registerCell(BasketTableViewCell.self)
        $0.backgroundColor = .green
        $0.separatorStyle = .none
        $0.rowHeight = UITableView.automaticDimension
        $0.bounces = false
        return $0
    }(UITableView())
    
    private lazy var addToProductsLabel: UILabel = {
        $0.text = "Добавить к заказу?"
        $0.font = UIFont.boldSystemFont(ofSize: 25)
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.5
        $0.numberOfLines = 1
        $0.textAlignment = .left
        $0.textColor = .white
        return $0
    }(UILabel())
    
    private let layout: UICollectionViewFlowLayout = {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 10
        return $0
    }(UICollectionViewFlowLayout())
    
    private lazy var addToProductsCV: UICollectionView = {
        $0.backgroundColor = .black
        $0.delegate = self
        $0.dataSource = self
        $0.showsHorizontalScrollIndicator = false
        $0.registerCell(AddToProductCell.self)
        return $0
    }(UICollectionView(frame: .zero, collectionViewLayout: layout))
    
    private lazy var promocodeButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = .darkGray
        configuration.baseForegroundColor = UIColor.white
        configuration.cornerStyle = .capsule
        configuration.buttonSize = .large
        configuration.title = "Ввести промокод"
        $0.configuration = configuration
        $0.addTarget(self, action: #selector(applyPromoTapped), for: .touchUpInside)
        return $0
    }(UIButton())
    
    
    
    private lazy var stackTotalView: UIStackView = {
        $0.axis = .horizontal
        $0.spacing = 15
        $0.alignment = .firstBaseline
        $0.distribution = .equalSpacing
        $0.isLayoutMarginsRelativeArrangement = true
        return $0
    }(UIStackView())
    
    private lazy var itemsLabel: UILabel = {
        $0.text = "3 товара"
        $0.font = UIFont.boldSystemFont(ofSize: 16)
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.5
        $0.numberOfLines = 2
        $0.textAlignment = .center
        $0.textColor = .white
        return $0
    }(UILabel())
    
    private lazy var totalCostLabel: UILabel = {
        $0.text = "2157"
        $0.font = UIFont.boldSystemFont(ofSize: 16)
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.5
        $0.numberOfLines = 2
        $0.textAlignment = .center
        $0.textColor = .white
        return $0
    }(UILabel())
    
    private lazy var stackDodoView: UIStackView = {
        $0.axis = .horizontal
        $0.spacing = 15
        $0.alignment = .firstBaseline
        $0.distribution = .equalSpacing
        $0.isLayoutMarginsRelativeArrangement = true
        return $0
    }(UIStackView())
    
    private lazy var dodoCoinsLabel: UILabel = {
        $0.text = "Додокоины"
        $0.font = UIFont.boldSystemFont(ofSize: 16)
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.5
        $0.numberOfLines = 2
        $0.textAlignment = .center
        $0.textColor = .white
        return $0
    }(UILabel())
    
    private lazy var totalCostDodoCoinsLabel: UILabel = {
        $0.text = "+108 D"
        $0.font = UIFont.boldSystemFont(ofSize: 16)
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.5
        $0.numberOfLines = 2
        $0.textAlignment = .center
        $0.textColor = .white
        return $0
    }(UILabel())
    
    private lazy var deliveryDodoStack: UIStackView = {
        $0.axis = .horizontal
        $0.spacing = 15
        $0.alignment = .firstBaseline
        $0.distribution = .equalSpacing
        $0.isLayoutMarginsRelativeArrangement = true
        return $0
    }(UIStackView())
    
    private lazy var deliveryLabel: UILabel = {
        $0.text = "Доставка"
        $0.font = UIFont.boldSystemFont(ofSize: 16)
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.5
        $0.numberOfLines = 2
        $0.textAlignment = .center
        $0.textColor = .white
        return $0
    }(UILabel())
    //info.circle.fill
    
    private lazy var infoButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "info.circle.fill")
        $0.setImage(image, for: .normal)
        $0.tintColor = .white
        $0.contentHorizontalAlignment = .fill
        $0.contentVerticalAlignment = .fill
        $0.imageView?.contentMode = .scaleAspectFit
        $0.addTarget(self, action: #selector(infoButtonTapped), for: .touchUpInside)
        return $0
    }(UIButton())
    
    private lazy var deliveryTextBtnView: UIStackView = {
        $0.axis = .horizontal
        $0.spacing = 4
        $0.alignment = .center
        return $0
    }(UIStackView())
    
    
    private lazy var deliveryStatusLabel: UILabel = {
        $0.text = "Бесплатно"
        $0.font = UIFont.boldSystemFont(ofSize: 16)
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.5
        $0.numberOfLines = 2
        $0.textAlignment = .center
        $0.textColor = .white
        return $0
    }(UILabel())
    
    private lazy var deliveryBackground: UIView = {
        $0.backgroundColor = .darkGray
        return $0
    }(UIView())
    
    private lazy var oderButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = .orange
        configuration.baseForegroundColor = UIColor.white
        configuration.cornerStyle = .capsule
        configuration.buttonSize = .large
        let rubleSymbol = "\u{20BD}"
        configuration.title = "Оформить заказ на 799 \(rubleSymbol)"
        $0.configuration = configuration
        $0.addTarget(self, action: #selector(checkoutTapped), for: .touchUpInside)
        return $0
    }(UIButton())
    
    private lazy var emptyView: UIView = {
        $0.backgroundColor = .clear
        return $0
    }(UIView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupViews()
        setupConstraints()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Обновляем высоту таблицы после того, как содержимое будет готово
        tableView.snp.updateConstraints { make in
            make.height.equalTo((tableView.cellForRow(at: IndexPath(item: 0, section: 0))?.frame.height ?? 100) * 4)
        }
        
       
    }
    
    
}

extension BasketViewController {
    private func setupViews() {
        [scrollView, backgroundView].forEach{
            view.addSubview($0)
        }
        
        [verticalStackView].forEach{
            scrollView.addSubview($0)
        }
        
        [titleLabel, closeButton].forEach{
            backgroundView.addSubview($0)
        }
        
        
        [totalLabel, tableView, addToProductsLabel, addToProductsCV, promocodeButton, stackTotalView, stackDodoView, deliveryDodoStack, deliveryBackground, emptyView].forEach {
            verticalStackView.addArrangedSubview($0)
        }
        
        [oderButton].forEach {
            deliveryBackground.addSubview($0)
        }
        
        
        [itemsLabel, totalCostLabel].forEach {
            stackTotalView.addArrangedSubview($0)
        }
        
        [dodoCoinsLabel, totalCostDodoCoinsLabel].forEach {
            stackDodoView.addArrangedSubview($0)
        }
        
        [deliveryTextBtnView, deliveryStatusLabel].forEach {
            deliveryDodoStack.addArrangedSubview($0)
        }
        
        [deliveryLabel, infoButton].forEach {
            deliveryTextBtnView.addArrangedSubview($0)
        }

    }
    
    private func setupConstraints(){
        
        let safeArea = view.safeAreaLayoutGuide
        
        backgroundView.snp.makeConstraints { make in
            make.top.left.right.equalTo(safeArea)
            make.height.equalTo(50)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.top.right.bottom.equalTo(backgroundView)
            make.centerY.equalTo(backgroundView.snp.centerY)
        }
        
        closeButton.snp.makeConstraints { make in
            make.left.equalTo(backgroundView).offset(16)
            make.centerY.equalTo(backgroundView.snp.centerY)
        }
        
        scrollView.snp.makeConstraints { make in
            make.right.bottom.left.equalTo(safeArea)
            make.top.equalTo(backgroundView.snp.bottom)
        }
        verticalStackView.snp.makeConstraints { make in
            make.top.right.bottom.left.equalTo(scrollView)
            make.width.equalTo(scrollView)
        }
        
        totalLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(verticalStackView).offset(16)
            make.height.equalTo(100)
        }
        
        tableView.snp.makeConstraints { make in
            make.height.equalTo(300)
            make.left.right.equalTo(verticalStackView)
        }
        
        addToProductsCV.snp.makeConstraints { make in
           make.height.equalTo(150)
            make.left.right.equalTo(verticalStackView)
        }
        
        promocodeButton.snp.makeConstraints { make in
            make.centerX.equalTo(verticalStackView)
            make.left.right.equalTo(verticalStackView).inset(60)
        }
        
        stackTotalView.snp.makeConstraints { make in
            make.left.right.equalTo(verticalStackView.layoutMargins)
        }
        
        
        stackDodoView.snp.makeConstraints { make in
            make.left.right.equalTo(verticalStackView.layoutMargins)
        }
        
        deliveryDodoStack.snp.makeConstraints { make in
            make.left.right.equalTo(verticalStackView.layoutMargins)
        }
        
        deliveryBackground.snp.makeConstraints { make in
            make.right.left.equalTo(verticalStackView)
        }
        
        oderButton.snp.makeConstraints { make in
           // make.centerX.equalTo(deliveryBackground)
            make.left.right.equalTo(deliveryBackground).inset(40)
            make.top.bottom.equalTo(deliveryBackground).inset(10)
        }
 
    }
    
    @objc private func applyPromoTapped(){
        print("Нажата кнопка ввода промокода!")
    }
    
    @objc private func infoButtonTapped() {
        print("Нажата кнопка информации!")
    }
    
    @objc private func checkoutTapped() {
        print("Нажата кнопка оформления заказа!")
    }
    //--------------------------------------
    @objc private func testBtn() {
        let test = getAllPrice()
        let rubleSymbol = "\u{20BD}"
        totalLabel.text = "\(test.0) товара на сумму \(test.1) \(rubleSymbol)"
    }
    //общее число продуктов
    private func getAllPrice() -> (Int, Int) {
        var countProducts = Int()
        var totalPrise = Int()
        for item in (0...products.count - 1) {
            let cell =  tableView.cellForRow(at: IndexPath(row: item, section: 0)) as! BasketTableViewCell
            let countProduct = cell.getValue()
            countProducts += countProduct
            totalPrise += (products[item].price * countProduct)
        }
        return (countProducts, totalPrise)
    }
    
}

extension BasketViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(indexPath) as BasketTableViewCell
        cell.update(products[indexPath.row])
        return cell
    }

}

extension BasketViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Получаем высоту коллекции, чтобы задать её в itemSize
        let height = collectionView.bounds.height // высота коллекции
        let width = 100.0 // или вычислите ширину в зависимости от ваших требований

        return CGSize(width: width, height: height)
    }
}

extension BasketViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(collectionView)
        print(indexPath)
        let cell = collectionView.dequeueCell(indexPath) as AddToProductCell
        cell.updateData(item: Addons(name: "Тест", price: 150, image: "mozzarella"))
        return cell
    }
 
}

struct BasketPreview: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> BasketViewController {
        return BasketViewController(product: [])
    }
    
    func updateUIViewController(_ uiViewController: BasketViewController, context: Context) {}
}

#Preview{
    BasketPreview()
}
