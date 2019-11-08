//
//  HomeBottomButtonsStackView.swift
//  TinderClone
//
//  Created by Ibrahim  Zakarya  on 8/3/19.
//  Copyright © 2019 Ibrahim  Zakarya . All rights reserved.
//

import UIKit

class HomeBottomButtonsStackView: UIStackView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        distribution = .fillEqually
        heightAnchor.constraint(equalToConstant: 90).isActive = true
        let subviews = [#imageLiteral(resourceName: " 3 1"), #imageLiteral(resourceName: " 3 2"), #imageLiteral(resourceName: " 3 3"), #imageLiteral(resourceName: " 3 4"), #imageLiteral(resourceName: " 3 5")].map { (image) -> UIView in
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
