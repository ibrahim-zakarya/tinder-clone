//
//  User.swift
//  TinderClone
//
//  Created by Ibrahim  Zakarya  on 8/5/19.
//  Copyright © 2019 Ibrahim  Zakarya . All rights reserved.
//

import UIKit

struct User: ProduceCardViewModel {
    let name: String
    let age: Int
    let profession: String
    let imageNames: [String]
    
    func toCardViewModel() -> CardViewModel {
        let attreText = NSMutableAttributedString(string: name, attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy)])
        attreText.append(NSMutableAttributedString(string: "  \(age)", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .regular)]))
        attreText.append(NSMutableAttributedString(string: "\n\(profession)", attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .regular)]))

        return CardViewModel(imageNames: imageNames, attributedString: attreText, textAlignment: .left)
    }
}

