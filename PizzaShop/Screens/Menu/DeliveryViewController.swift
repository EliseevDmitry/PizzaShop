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



final class DeliveryViewController: UIViewController {
    
    private let map: MKMapView = {
        return $0
    }(MKMapView())
    
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
    
    private let view1: UIView = {
        
        $0.frame.size.height = 100
        $0.frame.size.width = 100
        $0.backgroundColor = .red
        return $0
    }(UIView())
    
    private let view2: UIView = {
        $0.frame.size.height = 50
        $0.frame.size.width = 50
        $0.backgroundColor = .green
        return $0
    }(UIView())
    
    private let stack: UIStackView = {
        $0.axis = .vertical
        $0.alignment = .center
       // $0.distribution = .fillEqually
        $0.backgroundColor = .gray
        return $0
    }(UIStackView())
    
    private let view3: UIView = {
        
        return $0
    }(UIView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        setupViews()
        setupConstraints()
        Task{
            let loader = await DaDataLoader(coordinate: CLLocationCoordinate2D(latitude: 56.0090336, longitude: 92.8668773)).getAddress()
        }
    }
    
    
}

extension DeliveryViewController {
    
    private func setupViews(){
        [map, stack].forEach {
            view.addSubview($0)
        }
        [segmentedControl].forEach {
            map.addSubview($0)
        }
        [view1, view2, view3].forEach {
            stack.addArrangedSubview($0)
        }
    }
    
    private func setupConstraints() {
        map.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(300)
        }
        
        segmentedControl.snp.makeConstraints { make in
            make.left.top.right.equalTo(map).inset(10)
            make.height.equalTo(30)
        }
        stack.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
            make.top.equalTo(map.snp.bottom)
        }
        view1.snp.makeConstraints { make in
            make.height.width.equalTo(100)
        }
        view2.snp.makeConstraints { make in
            make.height.width.equalTo(200)
        }
    }
    
}

extension DeliveryViewController: MKMapViewDelegate {
    
}


struct DeliveryViewControllerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> DeliveryViewController {
        DeliveryViewController()
    }
    func updateUIViewController(_ uiViewController: DeliveryViewController, context: Context) {}
}



#Preview {
    DeliveryViewControllerWrapper()
}
