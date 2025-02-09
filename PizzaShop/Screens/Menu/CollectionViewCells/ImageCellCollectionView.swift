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

    private lazy var productImageView: UIImageView = {
        $0.image = UIImage(named: "chicken")
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        return $0
    }(UIImageView())

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension ImageCellCollectionView {
    
    private func setupViews(){
        [productImageView].forEach {
            contentView.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        productImageView.snp.makeConstraints { make in
            make.left.top.right.bottom.equalTo(contentView)
        }
    }
    
}

    //MARK: - Preview

struct ImageCellCollectionViewPreviews: PreviewProvider {

    struct ImageCellCollectionViewContainer: UIViewRepresentable {
        
        func makeUIView(context: Context) -> UIView {
            let cell = ImageCellCollectionView()
            cell.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
            return cell
        }
        
        func updateUIView(_ uiView: UIView, context: Context) { }
    }
    
    static var previews: some View {
        ImageCellCollectionViewContainer()
            .previewLayout(.sizeThatFits)
            .frame(width: 300, height: 300)
            .padding()
    }
}



