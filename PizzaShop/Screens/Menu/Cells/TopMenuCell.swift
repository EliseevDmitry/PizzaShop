//
//  PromoItemsCell.swift
//  PizzaShop
//
//  Created by Dmitriy Eliseev on 03.12.2024.
//

import UIKit
import SnapKit

final class TopMenuCell: UITableViewCell {
    
    static let reuseId = "PromoItemsCell"

    // MARK: - UI
    
    private lazy var verticalStackView: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 10
        $0.alignment = .leading
        $0.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 12, trailing: 0)
        $0.isLayoutMarginsRelativeArrangement = true
        $0.backgroundColor = .blue
        return $0
    }(UIStackView())
    
    private lazy var nameLabel: UILabel = {
        $0.text = "Выгодно и вкусно"
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.backgroundColor = .lightGray
        return $0
    }(UILabel())
    
    private lazy var itemsPizzasCollectionView: UICollectionView = {
       $0.dataSource = self
        $0.delegate = self
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        
        layout.itemSize.width = Screen.width * 0.8
        layout.itemSize.height = layout.itemSize.width / 3 * 2
        
        $0.frame = .zero
        $0.collectionViewLayout = layout
        $0.showsHorizontalScrollIndicator = false
        $0.registerCell(PizzaCell.self)
        return $0
    }(UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()))
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension TopMenuCell {

    private func setupViews(){
        
           [verticalStackView].forEach {
               contentView.addSubview($0)
           }
        
           [nameLabel, itemsPizzasCollectionView].forEach {
               verticalStackView.addArrangedSubview($0)
           }
        
       }

       private func setupConstraints() {
           verticalStackView.snp.makeConstraints { make in
               make.left.top.right.equalTo(contentView).inset(15)
               make.bottom.equalTo(contentView).inset(12)
           }
           
           itemsPizzasCollectionView.snp.makeConstraints { make in
               make.right.equalTo(verticalStackView)
               make.height.equalTo(calculateCollectionHeight())
           }
           
       }
    
    private func calculateCollectionHeight() -> CGFloat {
        let itemWidth = Screen.width * 0.8
        let itemHeight = itemWidth / 3 * 2
        let totalHeight = itemHeight
        return totalHeight
    }
    
}

extension TopMenuCell: UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(indexPath) as PizzaCell
        return cell
    }
 
}
