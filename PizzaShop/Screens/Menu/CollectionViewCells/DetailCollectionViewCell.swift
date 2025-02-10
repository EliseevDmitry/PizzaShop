//
//  DetailCellCollectionView.swift
//  PizzaShop
//
//  Created by Dmitriy Eliseev on 10.02.2025.
//

import UIKit
import SnapKit
import SwiftUI

class DetailCollectionViewCell: UICollectionViewCell {
    static let reuseId = "detailCell"
    
    //MARK: - LAZY VAR
    
    private var containerView: UIView = {
        $0.backgroundColor = .clear
        return $0
    }(UIView())
    
    private lazy var verticalStackView: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 10
        $0.alignment = .leading
        $0.distribution = .fill
        $0.directionalLayoutMargins = NSDirectionalEdgeInsets(
            top: 8,
            leading: 10,
            bottom: 12,
            trailing: 10
        )
        $0.isLayoutMarginsRelativeArrangement = true
        return $0
    }(UIStackView())
    
    private lazy var horizontalStackView: UIStackView = {
        $0.axis = .horizontal
        $0.spacing = 10
        $0.alignment = .center
        $0.distribution = .fill
        $0.directionalLayoutMargins = NSDirectionalEdgeInsets(
            top: 0,
            leading: 0,
            bottom: 0,
            trailing: 0
        )
        $0.isLayoutMarginsRelativeArrangement = true
        return $0
    }(UIStackView())
    
    private lazy var nameLabel: UILabel = {
        $0.text = "Говядина с песто"
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.textColor = .black
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.5
        $0.numberOfLines = 2
        $0.textAlignment = .left
        return $0
    }(UILabel())
    
    private var infoButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = .clear
        configuration.image = UIImage(systemName: "info.circle")
        configuration.baseForegroundColor = .black
        $0.configuration = configuration
        return $0
    }(UIButton())
    
    private lazy var choiceLabel: UILabel = {
        $0.text = "25 см, тонкое тесто, 570 г"
        $0.font = UIFont.systemFont(ofSize: 18)
        $0.textColor = .darkGray
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.8
        $0.numberOfLines = 1
        $0.textAlignment = .left
        return $0
    }(UILabel())
    
    private lazy var textView: UITextView = {
        $0.frame = CGRect(x: 20, y: 100, width: 300, height: 200)
        $0.font = UIFont.systemFont(ofSize: 18)
        $0.textColor = .black
        return $0
    }(UITextView())
    
    private lazy var diametrPizzas: UISegmentedControl = {
        $0.insertSegment(withTitle: "25 см", at: 0, animated: true)
        $0.insertSegment(withTitle: "30 см", at: 1, animated: true)
        $0.insertSegment(withTitle: "35 см", at: 2, animated: true)
        $0.selectedSegmentIndex = 0
        $0.addTarget(
            self,
            action: #selector(segmentChangedDiameter(_:)),
            for: .valueChanged
        )
        //не работает (разобраться)!!!
        $0.layer.cornerRadius = $0.frame.height / 2
        $0.layer.masksToBounds = true
        return $0
    }(UISegmentedControl())
    
    private lazy var pizzasDough: UISegmentedControl = {
        $0.insertSegment(withTitle: "Традиционное", at: 0, animated: true)
        $0.insertSegment(withTitle: "Тонкое", at: 0, animated: true)
        $0.selectedSegmentIndex = 0
        $0.addTarget(
            self,
            action: #selector(segmentChangedDough(_:)),
            for: .valueChanged
        )
        return $0
    }(UISegmentedControl())
    
    private lazy var addonsTitleLabel: UILabel = {
        $0.text = "Добавить по вкусу"
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.textColor = .black
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.5
        $0.numberOfLines = 2
        $0.textAlignment = .left
        return $0
    }(UILabel())
    
    //MARK: - FUNCTIONS OF THE LIFE CYCLE
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        addText()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - EXTENSION

extension DetailCollectionViewCell {
    
    private func setupViews(){
        [containerView, verticalStackView, addonsTitleLabel].forEach {
            contentView.addSubview($0)
        }
        
        [horizontalStackView, choiceLabel, textView, diametrPizzas, pizzasDough].forEach {
            verticalStackView.addArrangedSubview($0)
        }
        
        [nameLabel, infoButton].forEach {
            horizontalStackView.addArrangedSubview($0)
        }
        
    }
    
    private func setupConstraints() {
        
        containerView.snp.makeConstraints { make in
            make.left.top.right.bottom.equalToSuperview()
        }
        
        verticalStackView.snp.makeConstraints { make in
            make.left.top.right.equalTo(containerView)
            make.bottom.equalTo(addonsTitleLabel).inset(50).priority(.low)
        }
        
        horizontalStackView.snp.makeConstraints { make in
            make.left.right.equalTo(verticalStackView.layoutMargins)
            make.height.equalTo(20).priority(.high)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.width.equalTo(100)
            
        }
        
        choiceLabel.snp.makeConstraints { make in
            make.left.right.equalTo(verticalStackView.layoutMargins)
            make.top.equalTo(horizontalStackView.snp.bottom)
            make.bottom.equalTo(textView.snp.top)
            make.height.equalTo(40)
        }
        
        infoButton.snp.makeConstraints { make in
            make.right.equalTo(horizontalStackView.snp.rightMargin)
            make.width.equalTo(40)
        }
        
        diametrPizzas.snp.makeConstraints { make in
            make.left.right.equalTo(verticalStackView.layoutMargins)
            make.height.equalTo(30)
        }
        
        pizzasDough.snp.makeConstraints { make in
            make.left.right.equalTo(verticalStackView.layoutMargins)
            make.height.equalTo(30
            )
        }
        
        textView.snp.makeConstraints { make in
            make.bottom.equalTo(diametrPizzas.snp.bottom).inset(0)
            make.left.right.equalTo(containerView).offset(0)
            make.top.equalTo(choiceLabel.snp.bottom).offset(0).priority(.low)
            //make.height.equalTo().priority(.low)
        }
        
        addonsTitleLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.top.equalTo(pizzasDough.snp.bottom).offset(10).priority(.high)
            make.left.equalTo(containerView).inset(10)
        }
        
    }
    
    
    //MARK: - @OBJC FUNC
    
    @objc private func segmentChangedDiameter(_ sender: UISegmentedControl) {
        if let selectedIndexTitle = sender.titleForSegment(at: sender.selectedSegmentIndex) {
            updateDiameterChoseLabel(selectedIndexTitle)
        }
    }
    
    @objc private func segmentChangedDough(_ sender: UISegmentedControl) {
        if let selectedIndexTitle = sender.titleForSegment(at: sender.selectedSegmentIndex) {
            updateDoughChoseLable(selectedIndexTitle)
        }
    }
    
    //MARK: - PRIVATE FUNC
    
    private func updateDiameterChoseLabel(_ text: String) {
        if let doughTitle = pizzasDough.titleForSegment(at: pizzasDough.selectedSegmentIndex) {
            choiceLabel.text = "\(text), \(doughTitle.lowercased()) тесто, 570 г"
        }
    }
    
    private func updateDoughChoseLable(_ text: String) {
        if let diameterTitle = diametrPizzas.titleForSegment(at: diametrPizzas.selectedSegmentIndex) {
            choiceLabel.text = "\(diameterTitle), \(text.lowercased()) тесто, 570 г"
        }
    }
    
    //функция для реализации интерфейса
    private func addText(){
        let text = "Пряная говядина"
        let attributedString = NSMutableAttributedString(string: text)
        let buttonAttachment = NSTextAttachment()
        buttonAttachment.image = UIImage(systemName: "xmark.circle")?.withTintColor(.black)
        buttonAttachment.bounds = CGRect(x: 0, y: 3, width: 15, height: 15)
        let buttonString = NSAttributedString(attachment: buttonAttachment)
        attributedString.append(buttonString)
        attributedString.append(NSAttributedString(string: " соус песто, шампинионы"))
        attributedString.append(buttonString)
        attributedString.append(NSAttributedString(string: " сладкий перец, моцарелла"))
        textView.attributedText = attributedString
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(didTapTextView(_:))
        )
        textView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func didTapTextView(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: textView)
        if let tappedPosition = textView.closestPosition(to: location) {
            let tappedCharacterIndex = textView.offset(from: textView.beginningOfDocument, to: tappedPosition)
            let attributes = textView.textStorage.attributes(at: tappedCharacterIndex, effectiveRange: nil)
            if let _ = attributes[NSAttributedString.Key.attachment] {
                textView.text = ""
            }
        }
    }
    
}

//MARK: - PREVIEW

struct DetailCollectionViewCellPreviews: PreviewProvider {
    
    struct DetailCollectionViewCellContainer: UIViewRepresentable {
        func makeUIView(context: Context) -> UIView {
            DetailCollectionViewCell()
        }
        func updateUIView(_ uiView: UIView, context: Context) { }
    }
    
    static var previews: some View {
        DetailCollectionViewCellContainer()
            .previewLayout(.sizeThatFits)
            .frame(width: Screen.width, height: 300)
            .padding()
    }
    
}
