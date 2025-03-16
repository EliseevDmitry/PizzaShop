//
//  CustomStepper.swift
//  PizzaShop
//
//  Created by Dmitriy Eliseev on 17.03.2025.
//

import UIKit
import SnapKit
import SwiftUI

class StepperView: UIView {
    
    var onValueChanged: ((Int) -> Void)?

    private lazy var horizontalStackView: UIStackView = {
        $0.axis = .horizontal
        $0.spacing = 5
        $0.alignment = .center
        $0.distribution = .fillEqually
        $0.isLayoutMarginsRelativeArrangement = true
        return $0
    }(UIStackView())
    
    private let minusButton: UIButton = {
        $0.setTitle("−", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.setTitleColor(.white, for: .normal)
        return $0
    }(UIButton())
    
    private let plusButton: UIButton = {
        $0.setTitle("+", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.setTitleColor(.white, for: .normal)
        return $0
    }(UIButton())
    
    private let valueLabel: UILabel = {
        $0.text = ""
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.textAlignment = .center
        $0.textColor = .white
        return $0
    }(UILabel())
    
    var value: Int = 1 {
            didSet {
                valueLabel.text = "\(value)"
                onValueChanged?(value)
            }
        }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
    
    
}

extension StepperView {
    private func setupView() {
        valueLabel.text = "\(value)"
        self.backgroundColor = .darkGray
        [horizontalStackView].forEach {
            self.addSubview($0)
        }
        
        [minusButton, valueLabel, plusButton].forEach {
            horizontalStackView.addArrangedSubview($0)
        }
        
        minusButton.addTarget(self, action: #selector(decrementValue), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(incrementValue), for: .touchUpInside)
    }
    
    private func setupConstraints(){
        horizontalStackView.snp.makeConstraints { make in
            make.top.trailing.bottom.leading.equalToSuperview()
        }
    }
    
    
    @objc private func decrementValue() {
        if value > 0 {
            value -= 1
        }
    }
    
    @objc private func incrementValue() {
        if value < 99 {
            value += 1
        }
    }
    
}


struct StepperViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> StepperView {
        return StepperView(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
    }
    
    func updateUIView(_ uiView: StepperView, context: Context) {}
}

#Preview {
    StepperViewRepresentable()
}


