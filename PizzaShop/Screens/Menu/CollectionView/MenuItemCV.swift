//
//  MenuItemCV.swift
//  PizzaShop
//
//  Created by Dmitriy Eliseev on 18.12.2024.
//

import UIKit
import SnapKit

protocol SelectCollectionViewItemProtocol: AnyObject {
    func selectItem(index: Int)
}

final class MenuItemCV: UICollectionView  {
    
    
    let categoryLayout = UICollectionViewFlowLayout()
    let menuItems = ProductsService().fetchMenuItems()

    weak var cellDelegate: SelectCollectionViewItemProtocol?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: categoryLayout)
        configure()
    }
    
    //разобрать сегодня инициализаторы
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
}

//MARK: - UICollectionViewDelegate

extension MenuItemCV: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
        
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true) //перемещение при нажатии на требуюмую ячейку
        cellDelegate?.selectItem(index: indexPath.item) //передаем indexPath в cellDelegate
    }
}

//MARK: - UICollectionViewDataSource

extension MenuItemCV: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        menuItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(indexPath) as MenuCVCell
        cell.updateLabel(nameItem: menuItems[indexPath.row])
        return cell
    }

}

//MARK: - UICollectionViewDelegateFlowLayout

extension MenuItemCV: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let categoryFont = UIFont(name: "Arial Bold", size: 18)
        let categoryAttributes = [NSAttributedString.Key.font : categoryFont as Any]
        let categoryWidth = menuItems[indexPath.item].size(withAttributes: categoryAttributes).width + 20
        return CGSize(
            width: categoryWidth,
            height: collectionView.frame.height
        )
    }
}


extension MenuItemCV {
    
    private func configure(){
        backgroundColor = .none
        categoryLayout.minimumLineSpacing = 5
        categoryLayout.scrollDirection = .horizontal
        
        bounces = false //оттягивание от края
        showsHorizontalScrollIndicator = false
        
        delegate = self
        dataSource = self
        registerCell(MenuCVCell.self)
        
        selectItem(at: [0,0], animated: true, scrollPosition: .left) // установка первой ячейки
    }
    

}
