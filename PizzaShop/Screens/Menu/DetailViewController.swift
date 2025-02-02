//
//  DetailViewViewController.swift
//  PizzaShop
//
//  Created by Dmitriy Eliseev on 01.02.2025.
//

import UIKit
import SnapKit

class DetailViewController: UIViewController {
   
    private lazy var verticalStackView: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 15
        $0.alignment = .fill
        $0.distribution = .fill
        $0.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        $0.isLayoutMarginsRelativeArrangement = true
        return $0
    }(UIStackView())
    
    private lazy var productImageView: UIImageView = {
        $0.image = UIImage(named: "chicken")
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        return $0
    }(UIImageView())
    
    private lazy var captionLabel: UILabel = {
        $0.text = "Гавайская"
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        return $0
    }(UILabel())
    
    private lazy var detailLabel: UILabel = {
        $0.text = "Гавайская"
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        return $0
    }(UILabel())
    
    private lazy var zeroView: UIView = {
        return $0
    }(UIView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setupViews()
        setupConstraints()
    }
   
}


extension DetailViewController {

    private func setupViews() {
        [verticalStackView].forEach{
            view.addSubview($0)
        }
        
        [productImageView, captionLabel, detailLabel, zeroView].forEach{
            verticalStackView.addArrangedSubview($0)
        }
    }
    
    private func setupConstraints(){
        let safeArea = view.safeAreaLayoutGuide
        verticalStackView.snp.makeConstraints { make in
            make.top.right.bottom.left.equalTo(safeArea)
        }
        productImageView.snp.makeConstraints { make in
            make.width.equalTo(Screen.width * 0.7)
            make.height.equalTo(productImageView.snp.width)
        }
        
    }
}
