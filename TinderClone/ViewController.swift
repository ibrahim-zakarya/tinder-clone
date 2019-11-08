//
//  ViewController.swift
//  TinderClone
//
//  Created by Ibrahim  Zakarya  on 8/3/19.
//  Copyright © 2019 Ibrahim  Zakarya . All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    
    let topButtons = HomeTopButtonsStackView()
    let cardDeckView = UIView()
    let bottomButtons = HomeBottomButtonsStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayouts()
        setupDummyCards()
    }
    
    // MARK:- Fileprivate
    
    fileprivate func setupDummyCards() {
        let cardView = CardView(frame: .zero)
        cardDeckView.addSubview(cardView)
        cardView.fillSuperview()
    }
    
    fileprivate func setupLayouts() {
        // Do any additional setup after loading the view.

        
        let ovearalStackView = UIStackView(arrangedSubviews: [topButtons, cardDeckView, bottomButtons])
        ovearalStackView.axis = .vertical
        ovearalStackView.distribution = .fill
        
        view.addSubview(ovearalStackView)
        ovearalStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
        ovearalStackView.isLayoutMarginsRelativeArrangement = true
        ovearalStackView.layoutMargins = .init(top: 0, left: 12, bottom: 0, right: 12)
        
        ovearalStackView.bringSubviewToFront(cardDeckView)
    }

}

