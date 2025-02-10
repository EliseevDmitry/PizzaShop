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
    
    //MARK: - LAZY VAR
    
    private lazy var addonsProductCollectionView: UICollectionView = {
        $0.delegate = self
        $0.dataSource = self
        $0.registerCell(AddonsProductCollectionViewCell.self)
        $0.registerCell(ImageCellCollectionView.self)
        $0.registerCell(DetailCollectionViewCell.self)
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = .clear
        return $0
    }(UICollectionView(frame: .zero, collectionViewLayout: compositionalLayout))
    
    private var addingProductButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = .orange
        configuration.baseForegroundColor = UIColor.white
        configuration.cornerStyle = .capsule
        configuration.buttonSize = .large
        let rubleSymbol = "\u{20BD}"
        configuration.title = "В корзину за 799 \(rubleSymbol)"
        $0.configuration = configuration
        return $0
    }(UIButton())
    
    private lazy var compositionalLayout: UICollectionViewCompositionalLayout = {
        
        //productImageViewItem
        let imageItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .absolute(Screen.width * 0.8),
                heightDimension: .absolute(Screen.width * 0.8)
            )
        )
        imageItem.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: (Screen.width * 0.2) / 2,
            bottom: 0,
            trailing: (Screen.width * 0.2) / 2
        )
        
        //productImageViewGroup
        let imageGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .absolute(Screen.width * 0.8),
                heightDimension: .absolute(Screen.width * 0.8)
            ),
            subitems: [imageItem]
        )
        
        //productImageViewSection
        let imageSection = NSCollectionLayoutSection(group: imageGroup)
        imageSection.orthogonalScrollingBehavior = .none
        
        imageSection.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: (Screen.width - (Screen.width * 0.8)) / 2,
            bottom: 0,
            trailing: (Screen.width - (Screen.width * 0.8)) / 2
        )
        
        
        //detailItem------------
        let choseItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .absolute(Screen.width),
                heightDimension: .absolute(280)
            )
        )
        imageItem.contentInsets = NSDirectionalEdgeInsets(
            top: 10,
            leading: 10,
            bottom: 10,
            trailing: 10
        )
        
        //detailGroup
        let choseGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .absolute(Screen.width),
                heightDimension: .absolute(280)
            ),
            subitems: [choseItem]
        )
        
        //detailSection
        let choseSection = NSCollectionLayoutSection(group: choseGroup)
        choseSection.orthogonalScrollingBehavior = .none
        
        
        //choseProductsItem------------
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.33),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 5,
            leading: 5,
            bottom: 5,
            trailing: 5
        )
        
        //choseProductsItem
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(200)
            ),
            subitems: [item, item, item]
        )
        
        
        //choseProductsSection------------
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        
        let layout = UICollectionViewCompositionalLayout { sectionIndex, environment in
            switch sectionIndex {
            case 0: return imageSection
            case 1: return choseSection
            default:
                return section
            }
        }
        return layout
    }()
    
    //MARK: - FUNCTIONS OF THE LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupConstraints()
    }
    
}

//MARK: - EXTENSION

extension DetailViewController {
    
    private func setupViews() {
        [addonsProductCollectionView, addingProductButton].forEach{
            view.addSubview($0)
        }
    }
    
    private func setupConstraints(){
        
        addonsProductCollectionView.snp.makeConstraints { make in
            make.top.right.left.equalToSuperview()
            make.bottom.equalTo(addingProductButton.snp.top).offset(-20)
        }
        
        addingProductButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(32)
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(20)
        }
    }
    
}

extension DetailViewController: UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0, 1: return 1
        default:
            return addonsProducts.count
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3 //пока статика
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueCell(indexPath) as ImageCellCollectionView
            return cell
        case 1:
            let cell = collectionView.dequeueCell(indexPath) as DetailCollectionViewCell
            return cell
        default:
            let cell = collectionView.dequeueCell(indexPath) as AddonsProductCollectionViewCell
            cell.updateData(item: addonsProducts[indexPath.row])
            return cell
        }
    }
  
}

//MARK: - PREVIEW

struct DetailViewControllerPreviews: PreviewProvider {
    
    struct DetailViewControllerContainer: UIViewControllerRepresentable {
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
