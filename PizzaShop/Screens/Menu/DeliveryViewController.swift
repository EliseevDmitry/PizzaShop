//
//  DeliveryViewController.swift
//  PizzaShop
//
//  Created by Dmitriy Eliseev on 01.04.2025.
//

import UIKit
import MapKit
import SnapKit
import SwiftUI

struct TextPlaceholder {
    static let height: CGFloat = 50//вопрос Артуру
    static let offset: CGFloat = 16
    static let description = "Меню, цены и акции зависят от пиццерии"
    static let city = "Город улица и дом"
    static let entrance = "Подъезд"
    static let doorCode = "Код двери"
    static let floor = "Этаж"
    static let apartment = "Квартира"
    static let comments = "Комментарий к адресу"
}

final class DeliveryViewController: UIViewController {
    
    let addressLoader = DaDataLoader(coordinate: CLLocationCoordinate2D(latitude: 56.0090336, longitude: 92.8668773))
    
    private let verticalStack: UIStackView = {
        $0.axis = .vertical
        $0.distribution = .fill
        $0.spacing = 10
        return $0
    }(UIStackView())
    
    private let map: MKMapView = {
        let coordinate = CLLocationCoordinate2D(latitude: 56.0090336, longitude: 92.8668773)
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            $0.setRegion(region, animated: false)
        return $0
    }(MKMapView())
    
    var pinImageView: UIImageView = {
        $0.image = UIImage(systemName: "mappin")
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .red
        return $0
    }(UIImageView())
    
    private let segmentedControl: UISegmentedControl = {
        
        // $0.apportionsSegmentWidthsByContent = false
        $0.insertSegment(withTitle: "Доставка", at: 0, animated: true)
        $0.setImage(UIImage(systemName: "figure.walk"), forSegmentAt: 0)
        $0.insertSegment(withTitle: "В пиццерии", at: 1, animated: true)
        $0.selectedSegmentIndex = 0
        $0.selectedSegmentTintColor = UIColor.systemBlue  // Цвет выделенного сегмента
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 50
        
        return $0
    }(UISegmentedControl())
    
    private lazy var infoLabel: UILabel = {
        $0.numberOfLines = 2
        $0.textAlignment = .left
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.5
        let imageAttachment = NSTextAttachment()
        let imageConfig = UIImage.SymbolConfiguration(
            pointSize: 20,
            weight: .bold
        )
        imageAttachment.image = UIImage(
            systemName: "mappin",
            withConfiguration: imageConfig
        )?
            .withTintColor(.red, renderingMode: .alwaysOriginal)
        imageAttachment.bounds = CGRect(
            x: 0,
            y: -4,
            width: 20,
            height: 20
        )
        let fullString = NSMutableAttributedString(string: "Передвиньте метку ")
        fullString.append(NSAttributedString(attachment: imageAttachment))
        fullString.append(NSAttributedString(string: " или укажите ваш адрес"))
        $0.attributedText = fullString
        $0.font = UIFont.boldSystemFont(ofSize: 25)
        return $0
    }(UILabel())
    
    private lazy var descriptionLabel: UILabel = {
        $0.text = TextPlaceholder.description
        $0.font = UIFont.boldSystemFont(ofSize: 16)
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.5
        $0.numberOfLines = 1
        $0.textAlignment = .left
        $0.textColor = .lightGray
        return $0
    }(UILabel())
    
    private let addressTextField: UITextField = {
        $0.backgroundColor = .white
        $0.font = .systemFont(ofSize: 23)
        $0.placeholder = TextPlaceholder.city
        let paddingView = UIView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: 15,
                height: 0
            )
        )
        $0.leftView = paddingView
        $0.leftViewMode = .always
        $0.layer.cornerRadius = 20
        $0.layer.borderWidth = 2
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layoutMargins = UIEdgeInsets(
            top: 10,
            left: 10,
            bottom: 10,
            right: 10
        )
        return $0
    }(UITextField())
    
    private let firstAddressLine: UIStackView = {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 10
        return $0
    }(UIStackView())
    
    private let entranceTextField: UITextField = {
        $0.backgroundColor = .white
        $0.font = .systemFont(ofSize: 23)
        $0.placeholder = TextPlaceholder.entrance
        let paddingView = UIView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: 15,
                height: 0
            )
        )
        $0.leftView = paddingView
        $0.leftViewMode = .always
        $0.layer.cornerRadius = 20
        $0.layer.borderWidth = 2
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layoutMargins = UIEdgeInsets(
            top: 10,
            left: 10,
            bottom: 10,
            right: 10
        )
        return $0
    }(UITextField())
    
    private let doorCodeTextField: UITextField = {
        $0.backgroundColor = .white
        $0.font = .systemFont(ofSize: 23)
        $0.placeholder = TextPlaceholder.doorCode
        let paddingView = UIView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: 15,
                height: 0
            )
        )
        $0.leftView = paddingView
        $0.leftViewMode = .always
        $0.layer.cornerRadius = 20
        $0.layer.borderWidth = 2
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layoutMargins = UIEdgeInsets(
            top: 10,
            left: 10,
            bottom: 10,
            right: 10
        )
        return $0
    }(UITextField())
    
    private let secondAddressLine: UIStackView = {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 10
        return $0
    }(UIStackView())
    
    private let floorTextField: UITextField = {
        $0.backgroundColor = .white
        $0.font = .systemFont(ofSize: 23)
        $0.placeholder = TextPlaceholder.floor
        let paddingView = UIView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: 15,
                height: 0
            )
        )
        $0.leftView = paddingView
        $0.leftViewMode = .always
        $0.layer.cornerRadius = 20
        $0.layer.borderWidth = 2
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layoutMargins = UIEdgeInsets(
            top: 10,
            left: 10,
            bottom: 10,
            right: 10
        )
        return $0
    }(UITextField())
    
    private let apartmentCodeTextField: UITextField = {
        $0.backgroundColor = .white
        $0.font = .systemFont(ofSize: 23)
        $0.placeholder = TextPlaceholder.apartment
        let paddingView = UIView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: 15,
                height: 0
            )
        )
        $0.leftView = paddingView
        $0.leftViewMode = .always
        $0.layer.cornerRadius = 20
        $0.layer.borderWidth = 2
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layoutMargins = UIEdgeInsets(
            top: 10,
            left: 10,
            bottom: 10,
            right: 10
        )
        return $0
    }(UITextField())
    
    private let commentsTextField: UITextField = {
        $0.backgroundColor = .white
        $0.font = .systemFont(ofSize: 23)
        $0.placeholder = TextPlaceholder.comments
        let paddingView = UIView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: 15,
                height: 0
            )
        )
        $0.leftView = paddingView
        $0.leftViewMode = .always
        $0.layer.cornerRadius = 20
        $0.layer.borderWidth = 2
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layoutMargins = UIEdgeInsets(
            top: 10,
            left: 10,
            bottom: 10,
            right: 10
        )
        return $0
    }(UITextField())
    
    private lazy var oderButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = .orange
        configuration.baseForegroundColor = UIColor.white
        configuration.cornerStyle = .capsule
        configuration.buttonSize = .large
        configuration.title = "Заказать сюда"
        $0.configuration = configuration
        // $0.addTarget(self, action: #selector(checkoutTapped), for: .touchUpInside)
        return $0
    }(UIButton())
    
    //zero
    private let spacer: UIView = {
        return $0
    }(UIView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupViews()
        setupConstraints()
        map.delegate = self
        //        Task{
        //            let loader = await DaDataLoader(coordinate: CLLocationCoordinate2D(latitude: 56.0090336, longitude: 92.8668773)).getAddress()
        //        }
    }
    
}

extension DeliveryViewController {
    
    private func setupViews(){
        [verticalStack].forEach {
            view.addSubview($0)
        }
        [map, infoLabel, descriptionLabel, addressTextField, firstAddressLine, secondAddressLine, commentsTextField, oderButton, spacer].forEach {
            verticalStack.addArrangedSubview($0)
        }
        
        [segmentedControl, pinImageView].forEach {
            map.addSubview($0)
        }
        
        [entranceTextField, doorCodeTextField].forEach {
            firstAddressLine.addArrangedSubview($0)
        }
        
        [floorTextField, apartmentCodeTextField].forEach {
            secondAddressLine.addArrangedSubview($0)
        }
        
    }
    
    private func setupConstraints() {
        verticalStack.snp.makeConstraints { make in
            make.top.equalTo(self.view.snp.top)
            make.left.right.bottom.equalToSuperview()
        }
        
        map.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(400)
        }
        
        segmentedControl.snp.makeConstraints { make in
            make.left.right.equalTo(map).inset(TextPlaceholder.offset)
            make.top.equalTo(self.view.snp.top).inset(70)
            make.height.equalTo(30)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(verticalStack.snp.horizontalEdges).inset(TextPlaceholder.offset)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(verticalStack.snp.horizontalEdges).inset(TextPlaceholder.offset)
        }
        
        pinImageView.snp.makeConstraints { make in
            make.height.width.equalTo(50)
            make.center.equalToSuperview()
        }
        
        addressTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(verticalStack.snp.horizontalEdges).inset(TextPlaceholder.offset)
            make.height.equalTo(TextPlaceholder.height)
        }
        
        firstAddressLine.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(verticalStack.snp.horizontalEdges).inset(TextPlaceholder.offset)
        }
        
        entranceTextField.snp.makeConstraints { make in
            make.height.equalTo(TextPlaceholder.height)
        }
        
        secondAddressLine.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(verticalStack.snp.horizontalEdges).inset(TextPlaceholder.offset)
        }
        
        floorTextField.snp.makeConstraints { make in
            make.height.equalTo(TextPlaceholder.height)
        }
        
        commentsTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(verticalStack.snp.horizontalEdges).inset(TextPlaceholder.offset)
            make.height.equalTo(TextPlaceholder.height)
        }
        
        oderButton.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(verticalStack.snp.horizontalEdges).inset(TextPlaceholder.offset)
            make.height.equalTo(TextPlaceholder.height)
        }
    }
    
}

extension DeliveryViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = mapView.centerCoordinate
        let location =  CLLocationCoordinate2D(latitude: center.latitude, longitude: center.longitude)
        let address = addressLoader.getAddress(coordinate: location)
        addressTextField.text = address
    }
}


struct DeliveryViewControllerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> DeliveryViewController {
        DeliveryViewController()
    }
    func updateUIViewController(_ uiViewController: DeliveryViewController, context: Context) {}
}

#Preview {
    DeliveryViewControllerWrapper()
        .ignoresSafeArea()
}
