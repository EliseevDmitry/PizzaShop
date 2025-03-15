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
    
    private lazy var tableView: UITableView = {
        $0.dataSource = self
        $0.delegate = self
        if #available(iOS 15.0, *) {
            $0.sectionHeaderTopPadding = 0
        }
        $0.registerCell(ProductTableViewCell.self)
        $0.backgroundColor = .green
        $0.separatorStyle = .none
        $0.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        $0.rowHeight = UITableView.automaticDimension
        return $0
    }(UITableView())
    
    private lazy var promocodeButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = .darkGray
        configuration.baseForegroundColor = UIColor.white
        configuration.cornerStyle = .capsule
        configuration.buttonSize = .large
        configuration.title = "Ввести промокод"
        $0.configuration = configuration
        return $0
    }(UIButton())
    
    private lazy var verticalStackView: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 15
        $0.alignment = .leading
        $0.distribution = .fill
        $0.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 12, trailing: 15)
        $0.isLayoutMarginsRelativeArrangement = true
        return $0
    }(UIStackView())
    
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
    
}

extension BasketViewController {
    private func setupViews() {
        [verticalStackView].forEach{
            view.addSubview($0)
        }
        
        [promocodeButton, stackTotalView, stackDodoView, deliveryDodoStack, deliveryBackground, emptyView].forEach {
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
        //let safeArea = view.safeAreaLayoutGuide
        verticalStackView.snp.makeConstraints { make in
            make.top.right.bottom.left.equalToSuperview()
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
    
    @objc private func infoButtonTapped() {
        print("Нажата кнопка информации!")
    }
    
}

extension BasketViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }

}

struct BasketPreview: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> BasketViewController {
        return BasketViewController()
    }
    
    func updateUIViewController(_ uiViewController: BasketViewController, context: Context) {}
}

#Preview{
    BasketPreview()
}
