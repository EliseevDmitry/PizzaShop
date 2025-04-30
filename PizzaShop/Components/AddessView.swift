//
//  AddessView.swift
//  PizzaShop
//
//  Created by Dmitriy Eliseev on 30.04.2025.
//

import UIKit
import SnapKit

final class AddessView: UIView {
    
    private let verticalStack: UIStackView = {
        $0.axis = .vertical
        $0.distribution = .fillProportionally
        $0.spacing = 10
        return $0
    }(UIStackView())
    
    private lazy var infoLabel: UILabel = {
        $0.numberOfLines = 2
        $0.textAlignment = .left
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.5
        let imageAttachment = NSTextAttachment()
        let imageConfig = UIImage.SymbolConfiguration(
            pointSize: 20,
            weight: .bold
        )
        imageAttachment.image = UIImage(
            systemName: "mappin",
            withConfiguration: imageConfig
        )?
            .withTintColor(.red, renderingMode: .alwaysOriginal)
        imageAttachment.bounds = CGRect(
            x: 0,
            y: -4,
            width: 20,
            height: 20
        )
        let fullString = NSMutableAttributedString(string: "Передвиньте метку ")
        fullString.append(NSAttributedString(attachment: imageAttachment))
        fullString.append(NSAttributedString(string: " или укажите ваш адрес"))
        $0.attributedText = fullString
        $0.font = UIFont.boldSystemFont(ofSize: 25)
        return $0
    }(UILabel())
    
    private lazy var descriptionLabel: UILabel = {
        $0.text = TextPlaceholder.description
        $0.font = UIFont.boldSystemFont(ofSize: 16)
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.5
        $0.numberOfLines = 1
        $0.textAlignment = .left
        $0.textColor = .lightGray
        return $0
    }(UILabel())
    
    private let addressTextField: FixedHeightTextField = {
        $0.backgroundColor = .white
        $0.font = .systemFont(ofSize: 23)
        $0.placeholder = TextPlaceholder.city
        let paddingView = UIView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: 15,
                height: 0
            )
        )
        $0.leftView = paddingView
        $0.leftViewMode = .always
        $0.layer.cornerRadius = 20
        $0.layer.borderWidth = 2
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layoutMargins = UIEdgeInsets(
            top: 10,
            left: 10,
            bottom: 10,
            right: 10
        )
        return $0
    }(FixedHeightTextField())
    
    private let firstAddressLine: UIStackView = {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 10
        return $0
    }(UIStackView())
    
    private let entranceTextField: FixedHeightTextField = {
        $0.backgroundColor = .white
        $0.font = .systemFont(ofSize: 23)
        $0.placeholder = TextPlaceholder.entrance
        let paddingView = UIView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: 15,
                height: 0
            )
        )
        $0.leftView = paddingView
        $0.leftViewMode = .always
        $0.layer.cornerRadius = 20
        $0.layer.borderWidth = 2
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layoutMargins = UIEdgeInsets(
            top: 10,
            left: 10,
            bottom: 10,
            right: 10
        )
        return $0
    }(FixedHeightTextField())
    
    private let doorCodeTextField: FixedHeightTextField = {
        $0.backgroundColor = .white
        $0.font = .systemFont(ofSize: 23)
        $0.placeholder = TextPlaceholder.doorCode
        let paddingView = UIView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: 15,
                height: 0
            )
        )
        $0.leftView = paddingView
        $0.leftViewMode = .always
        $0.layer.cornerRadius = 20
        $0.layer.borderWidth = 2
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layoutMargins = UIEdgeInsets(
            top: 10,
            left: 10,
            bottom: 10,
            right: 10
        )
        return $0
    }(FixedHeightTextField())
    
    private let secondAddressLine: UIStackView = {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 10
        return $0
    }(UIStackView())
    
    private let floorTextField: FixedHeightTextField = {
        $0.backgroundColor = .white
        $0.font = .systemFont(ofSize: 23)
        $0.placeholder = TextPlaceholder.floor
        let paddingView = UIView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: 15,
                height: 0
            )
        )
        $0.leftView = paddingView
        $0.leftViewMode = .always
        $0.layer.cornerRadius = 20
        $0.layer.borderWidth = 2
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layoutMargins = UIEdgeInsets(
            top: 10,
            left: 10,
            bottom: 10,
            right: 10
        )
        return $0
    }(FixedHeightTextField())
    
    private let apartmentCodeTextField: FixedHeightTextField = {
        $0.backgroundColor = .white
        $0.font = .systemFont(ofSize: 23)
        $0.placeholder = TextPlaceholder.apartment
        let paddingView = UIView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: 15,
                height: 0
            )
        )
        $0.leftView = paddingView
        $0.leftViewMode = .always
        $0.layer.cornerRadius = 20
        $0.layer.borderWidth = 2
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layoutMargins = UIEdgeInsets(
            top: 10,
            left: 10,
            bottom: 10,
            right: 10
        )
        return $0
    }(FixedHeightTextField())
    
    private let commentsTextField: FixedHeightTextField = {
        $0.backgroundColor = .white
        $0.font = .systemFont(ofSize: 23)
        $0.placeholder = TextPlaceholder.comments
        let paddingView = UIView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: 15,
                height: 0
            )
        )
        $0.leftView = paddingView
        $0.leftViewMode = .always
        $0.layer.cornerRadius = 20
        $0.layer.borderWidth = 2
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layoutMargins = UIEdgeInsets(
            top: 10,
            left: 10,
            bottom: 10,
            right: 10
        )
        return $0
    }(FixedHeightTextField())
    
    private lazy var oderButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = .orange
        configuration.baseForegroundColor = UIColor.white
        configuration.cornerStyle = .capsule
        configuration.buttonSize = .large
        configuration.title = "Заказать сюда"
        $0.configuration = configuration
        // $0.addTarget(self, action: #selector(checkoutTapped), for: .touchUpInside)
        return $0
    }(UIButton())
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

    
}


extension AddessView {
    
    func updateText(text: String) {
        addressTextField.text = text
    }
    
    
    func setupView() {
       
        self.addSubview(verticalStack)
        
        [infoLabel, descriptionLabel, addressTextField, firstAddressLine, secondAddressLine, commentsTextField, oderButton].forEach {
            verticalStack.addArrangedSubview($0)
        }
        
        [entranceTextField, doorCodeTextField].forEach {
            firstAddressLine.addArrangedSubview($0)
        }
        
        [floorTextField, apartmentCodeTextField].forEach {
            secondAddressLine.addArrangedSubview($0)
        }
    }
    
    func setupConstraints() {
        verticalStack.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview().inset(16)
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(16)
        }
        
        
       
        
        
    }
}
