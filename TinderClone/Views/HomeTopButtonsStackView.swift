//
//  HomeTopButtonsStackView.swift
//  TinderClone
//
//  Created by Ibrahim  Zakarya  on 8/3/19.
//  Copyright © 2019 Ibrahim  Zakarya . All rights reserved.
//

import UIKit

class HomeTopButtonsStackView: UIStackView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        distribution = .fillEqually
        
        let subviews = [#imageLiteral(resourceName: " 3 6"), #imageLiteral(resourceName: " 3 7"), #imageLiteral(resourceName: " 3 8")].map { (image) -> UIView in
            let button = UIButton(type: .system)
            button.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
            return button
        }
        
        subviews.forEach { (v) in
            addArrangedSubview(v)
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
