//
//  Advertiser.swift
//  TinderClone
//
//  Created by Ibrahim  Zakarya  on 8/11/19.
//  Copyright © 2019 Ibrahim  Zakarya . All rights reserved.
//

import UIKit

struct Advertiser: ProduceCardViewModel {
    let title: String
    let brandName: String
    let posterPhotoName: String
    
    func toCardViewModel() -> CardViewModel {
        let attributedString = NSMutableAttributedString(string: title, attributes: [.font: UIFont.systemFont(ofSize: 34, weight: .heavy)])
        attributedString.append(NSAttributedString(string: "\n" + brandName, attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .semibold)]))
        
        return CardViewModel(imageNames: [posterPhotoName], attributedString: attributedString, textAlignment: .center)
    }
}

