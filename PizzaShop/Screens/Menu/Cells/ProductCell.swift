//
//  ProductCell.swift
//  PizzaShop
//
//  Created by Dmitriy Eliseev on 18.11.2024.
//

import UIKit

final class ProductCell: UITableViewCell {
    
    static let reuseId = "ProductCell" //зачем static?? стало понятно - forCellReuseIdentifier - String (поэтому и static)
    
    //    private var containerView: UIView = {
    //        var view = UIView()
    //        view.backgroundColor = .white
    //        view.applyShadow(cornerRadius: 10)
    //        view.translatesAutoresizingMaskIntoConstraints = false
    //        return view
    //    }()
    
    //идея в краткости? и лаконичности?
    private var containerView: UIView = {
        $0.backgroundColor = .white
        $0.applyShadow(cornerRadius: 10)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    private var verticalStackView: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 15 // как бороться с magicNumber и нужно ли делать это тут?
        $0.alignment = .leading
        //разобраться
        $0.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 12, trailing: 0)
        $0.isLayoutMarginsRelativeArrangement = true
        //разобраться
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView())
    
    private var nameLabel: UILabel = {
        $0.text = "Гавайская" //Хардкод
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private var detailLabel: UILabel = {
        $0.text = "Тесто, Цыпленок, моцарелла, томатный соус"
        $0.textColor = .darkGray
        $0.numberOfLines = 0
        $0.font = UIFont.boldSystemFont(ofSize: 15)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private var priceButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = .orange.withAlphaComponent(0.1) // сделать более прозрачно
        configuration.baseForegroundColor = UIColor.brown
        configuration.cornerStyle = .capsule
        configuration.buttonSize = .medium
        configuration.title = "от 469 руб"
        $0.configuration = configuration
        //реализация через uiButtonConfiguration для IOS15
        // button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton())
    
    //    private var priceButton: UIButton = {
    //        $0.setTitle("от 469 руб", for: .normal)
    //        $0.backgroundColor = .orange.withAlphaComponent(0.1) // сделать более прозрачно
    //        $0.layer.cornerRadius = 20
    //        $0.setTitleColor(.brown, for: .normal)
    //        //реализация через uiButtonConfiguration для IOS15
    //        // button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
    //        $0.translatesAutoresizingMaskIntoConstraints = false
    //        return $0
    //    }(UIButton())
    
    private var productImageView: UIImageView = {
        $0.image = UIImage(named: "hawaii")
        $0.contentMode = .scaleAspectFill
        //        эта история не поехала без SnapKit (делал через через constraint), также пришлось у TableView делать высоту ячейки под размер изображения Pizza - tableView.rowHeight = UIScreen.main.bounds.width * 0.4
        //        let width = UIScreen.main.bounds.width
        //        imageView.heightAnchor.constraint(equalToConstant: 0.40 * width).isActive = true
        //        imageView.widthAnchor.constraint(equalToConstant: 0.40 * width).isActive = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Почему нам при создании ячейки нужно вызывать designated init который будет вызывать init у родительского класса
    
    
    
    func update(_ product: Product) {
        nameLabel.text = product.name
        detailLabel.text = product.detail
        priceButton.setTitle("\(product.price) р", for: .normal)
        productImageView.image = UIImage(named: product.image)
    }
    
    
    //При создании через Cocoa Touch Class создает два перегруженного метода. Нужно ли создавать через Cocoa - или просто голый Swift файл и делать более предсказуемые вещи самостоятельно?
    
    /*
     override func awakeFromNib() {
     super.awakeFromNib()
     // Initialization code
     }
     
     override func setSelected(_ selected: Bool, animated: Bool) {
     super.setSelected(selected, animated: animated)
     
     // Configure the view for the selected state
     }
     */
}

extension ProductCell {
    
    //почему структура а не enum - общепринятая практика?
    struct Layout {
        static let offset: CGFloat = 10
        static let horisontal: CGFloat = 16
        static let vertical: CGFloat = 8
    }
    
    private func setupViews(){
        //        contentView.addSubview(containerView)
        //        containerView.addSubview(productImageView)
        //        containerView.addSubview(verticalStackView)
        //        verticalStackView.addArrangedSubview(nameLabel)
        //        verticalStackView.addArrangedSubview(detailLabel)
        //        verticalStackView.addArrangedSubview(priceButton)
        //эта история скорости не прибавляет - ?
        [containerView].forEach {
            contentView.addSubview($0)
        }
        [productImageView, verticalStackView].forEach {
            containerView.addSubview($0)
        }
        [nameLabel, detailLabel, priceButton].forEach {
            verticalStackView.addArrangedSubview($0)
        }
    }
    
    private func setupConstraints() {
        //Остается вопрос с magicNumber?
        containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: Layout.vertical).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -Layout.horisontal).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -Layout.vertical).isActive = true
        containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: Layout.horisontal).isActive = true
        productImageView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: Layout.offset).isActive = true
        productImageView.topAnchor.constraint(equalTo: self.containerView.topAnchor).isActive = true
        productImageView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor).isActive = true
        productImageView.heightAnchor.constraint(equalTo: self.containerView.heightAnchor).isActive = true
        productImageView.widthAnchor.constraint(equalTo: productImageView.heightAnchor).isActive = true
        productImageView.centerYAnchor.constraint(equalTo: self.verticalStackView.centerYAnchor).isActive = true
        verticalStackView.rightAnchor.constraint(equalTo: self.containerView.rightAnchor, constant: -Layout.offset).isActive = true
        verticalStackView.leftAnchor.constraint(equalTo: self.productImageView.rightAnchor, constant: Layout.offset).isActive = true
    }
}
