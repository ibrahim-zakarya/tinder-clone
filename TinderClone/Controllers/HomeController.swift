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
    
    let cardViewModels: [CardViewModel] = {
        let producer = [User(name: "Jane", age: 18, profession: "DJ music", imageNames: ["jane1", "jane2", "jane3"]),
         Advertiser(title: "Slide Out Menu", brandName: "Lets build that app", posterPhotoName: "slide_out_menu_poster"),
            User(name: "Kelly", age: 22, profession: "Actor", imageNames: ["kelly1", "kelly2", "kelly3"])] as [ProduceCardViewModel]
        
        let viewModels = producer.map({ return $0.toCardViewModel()})
        return viewModels
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayouts()
        setupDummyCards()
    }
    
    // MARK:- Fileprivate
    
    fileprivate func setupDummyCards() {
        cardViewModels.forEach { (cardVM) in
            let cardView = CardView(frame: .zero)
            cardView.cardViewModel = cardVM
            cardDeckView.addSubview(cardView)
            cardView.fillSuperview()
        }
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

