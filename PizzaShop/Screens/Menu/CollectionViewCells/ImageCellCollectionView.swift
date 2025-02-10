//
//  ImageCellCollectionView.swift
//  PizzaShop
//
//  Created by Dmitriy Eliseev on 10.02.2025.
//

import UIKit
import SnapKit
import SwiftUI

class ImageCellCollectionView: UICollectionViewCell {
    static let reuseId = "imageCell"

    //MARK: - LAZY VAR
    
    private lazy var productImageView: UIImageView = {
        $0.image = UIImage(named: "chicken")
        $0.contentMode = .scaleAspectFill
        return $0
    }(UIImageView())

    //MARK: - FUNCTIONS OF THE LIFE CYCLE
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//MARK: - EXTENSION

extension ImageCellCollectionView {
    
    private func setupViews(){
        [productImageView].forEach {
            contentView.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        productImageView.snp.makeConstraints { make in
            
            make.left.top.right.bottom.equalToSuperview()
        }
    }
    
}

//MARK: - PREVIEW

struct ImageCellCollectionViewPreviews: PreviewProvider {

    struct ImageCellCollectionViewContainer: UIViewRepresentable {
        func makeUIView(context: Context) -> UIView {
            ImageCellCollectionView()
        }
        
        func updateUIView(_ uiView: UIView, context: Context) { }
    }
    
    static var previews: some View {
        ImageCellCollectionViewContainer()
            .previewLayout(.sizeThatFits)
            .frame(width: Screen.width, height: Screen.width)
            .padding()
    }
    
}



