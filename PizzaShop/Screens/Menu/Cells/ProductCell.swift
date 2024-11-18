//
//  ProductCell.swift
//  PizzaShop
//
//  Created by Dmitriy Eliseev on 18.11.2024.
//

import UIKit

final class ProductCell: UITableViewCell {

    static let reuseId = "ProductCell" //зачем static?? стало понятно - forCellReuseIdentifier - String (поэтому и static)
    
    var nameLabel: UILabel = {
        var label = UILabel()
        label.text = "Гавайская" //Хардкод
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Почему нам при создании ячейки нужно вызывать designated init который будет вызывать init у родительского класса
    
   private func setupViews(){
        contentView.addSubview(nameLabel)
    }
    
    private func setupConstraints() {
        nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 20).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
    }
    
    func update(productName product: String) {
        nameLabel.text = product
    }
    
    //При создании через Cocoa Touch Class создает два перегруженного метода. Нужно ли создавать через Cocoa - или просто голый Swift файл и делать более предсказуемые вещи самостоятельно?
    
    /*
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
     */

}
