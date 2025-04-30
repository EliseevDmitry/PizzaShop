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
    
    private let addressView: AddessView = {
        return $0
    }(AddessView())
    
    
    
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
        [map, pinImageView, addressView].forEach {
            view.addSubview($0)
        }
        
        [segmentedControl, pinImageView].forEach {
            map.addSubview($0)
        }
    }

    private func setupConstraints() {
        map.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.bottom.equalTo(addressView.snp.top)
           // make.height.equalTo(300)
        }
        
        pinImageView.snp.makeConstraints { make in
            make.center.equalTo(map.snp.center)
            make.height.width.equalTo(50)
        }
        
        addressView.snp.makeConstraints { make in
           // make.top.equalTo(map.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        
        
        
        segmentedControl.snp.makeConstraints { make in
            make.left.right.equalTo(map).inset(TextPlaceholder.offset)
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.height.equalTo(30)
        }
        
    }
    
}

extension DeliveryViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = mapView.centerCoordinate
        let location =  CLLocationCoordinate2D(latitude: center.latitude, longitude: center.longitude)
        let address = addressLoader.getAddress(coordinate: location)
        addressView.updateText(text: address) 
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
