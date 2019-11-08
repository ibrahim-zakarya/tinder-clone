//
//  RegistrationViewModel.swift
//  TinderClone
//
//  Created by Ibrahim  Zakarya  on 8/13/19.
//  Copyright © 2019 Ibrahim  Zakarya . All rights reserved.
//

import UIKit

class RegistrationViewModel {
    var name: String? { didSet {checkFormValidity()} }
    var email: String? { didSet {checkFormValidity()} }
    var password: String? { didSet {checkFormValidity()} }
    
    var isValidFormObserver: ((Bool) -> ())?
    
    fileprivate func checkFormValidity() {
        let isFormValid = name?.isEmpty == false && email?.isEmpty == false && password?.isEmpty == false
        isValidFormObserver?(isFormValid)
    }
    
}
