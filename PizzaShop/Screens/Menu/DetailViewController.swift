//
//  DetailViewViewController.swift
//  PizzaShop
//
//  Created by Dmitriy Eliseev on 01.02.2025.
//

import UIKit
import SnapKit
import SwiftUI

class DetailViewController: UIViewController  {
   
    let addonsProducts = ProductsService().fetchAddonsProduct()

    

    
    private lazy var compositionalLayout: UICollectionViewCompositionalLayout = {
        
        // Создание элемента для productImageView
                let imageItem = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .absolute(Screen.width),
                        heightDimension: .absolute(Screen.width)
                    )
                )
                imageItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
                
                // Создание группы для изображения
                let imageGroup = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .absolute(Screen.width),
                        heightDimension: .absolute(Screen.width)
                    ),
                    subitems: [imageItem]
                )
                
  
                let imageSection = NSCollectionLayoutSection(group: imageGroup)
                imageSection.orthogonalScrollingBehavior = .none
        
        
        
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.33),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        // Группа с тремя элементами в ряду
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(200)
            ),
            subitems: [item, item, item] // 3 элемента в ряду
        )
        
        // Секция
        
        let section = NSCollectionLayoutSection(group: group)
        
        // Вертикальный скролл
        section.orthogonalScrollingBehavior = .none
        
        let layout = UICollectionViewCompositionalLayout { sectionIndex, environment in
                    if sectionIndex == 0 {
                        return imageSection  // Первая секция для изображения
                    } else {
                        return section  // Вторая секция для других элементов
                    }
                }
        
        return layout
    }()
    
    private lazy var addonsProductCollectionView: UICollectionView = {
        $0.delegate = self
        $0.dataSource = self
        $0.registerCell(AddonsProductCollectionViewCell.self)
        $0.registerCell(ImageCellCollectionView.self)
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = .brown
        
        return $0
    }(UICollectionView(frame: .zero, collectionViewLayout: compositionalLayout))

    private lazy var zeroView: UIView = {
        return $0
    }(UIView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red.withAlphaComponent(0.1)
        
        setupViews()
        setupConstraints()
    }
   
}


extension DetailViewController {

    private func setupViews() {
        [addonsProductCollectionView].forEach{
            view.addSubview($0)
        }
    }
    
    private func setupConstraints(){
        
        addonsProductCollectionView.snp.makeConstraints { make in
            make.top.right.bottom.left.equalToSuperview()
        }

    }
    
}

//MARK: - Preview

struct DetailViewControllerPreviews: PreviewProvider {
    
    // Структура для передачи mock-данных в Preview
    struct DetailViewControllerContainer: UIViewControllerRepresentable {
        
        var addonsProducts: [Addons] = [
            Addons(name: "Сырный бортик", price: 179, image: "cheesecrust"),
            Addons(name: "Пряная говядина", price: 119, image: "spicybeef"),
            Addons(name: "Моцарелла", price: 79, image: "mozzarella")
        ]
        
        func makeUIViewController(context: Context) -> some UIViewController {
            let viewController = DetailViewController()
            return UINavigationController(rootViewController: viewController)
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
    }
    
    static var previews: some View {
        DetailViewControllerContainer()
            .ignoresSafeArea()
    }
}


extension DetailViewController: UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
                return 1 // Первая секция для изображения
            } else {
                return addonsProducts.count // Вторая секция для других элементов
            }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if indexPath.section == 0 {
                    // В первой секции, возвращаем пустую ячейку или настройте для изображения
            let cell = collectionView.dequeueCell(indexPath) as ImageCellCollectionView
                    return cell
                } else  {
                    // Для других секций
                    let cell = collectionView.dequeueCell(indexPath) as AddonsProductCollectionViewCell
                    //print(indexPath.row)
                    cell.updateData(item: addonsProducts[indexPath.row])
                    return cell
                }
    }
    
}


