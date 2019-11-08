//
//  RegistrationController.swift
//  TinderClone
//
//  Created by Ibrahim  Zakarya  on 8/12/19.
//  Copyright © 2019 Ibrahim  Zakarya . All rights reserved.
//

import UIKit

class RegistrationController: UIViewController {

    let gradinetLayer = CAGradientLayer()
    
    let selectPhotoButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.heightAnchor.constraint(equalToConstant: 250).isActive = true
        btn.layer.cornerRadius = 16
        btn.setTitle("Selec Photo", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: .heavy)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = .white
        return btn
    }()
    
    let nameTF: CustomTextField = {
        let tf = CustomTextField(padding: 16)
        tf.placeholder = "Enter your name"
        tf.backgroundColor = .white
        tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return tf
    }()
    
    let emailTF: CustomTextField = {
        let tf = CustomTextField(padding: 16)
        tf.placeholder = "Enter your name"
        tf.backgroundColor = .white
        tf.keyboardType = .emailAddress
        tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return tf
    }()
    
    let passwordTF: CustomTextField = {
        let tf = CustomTextField(padding: 16)
        tf.placeholder = "Enter your name"
        tf.backgroundColor = .white
        tf.isSecureTextEntry = true
        tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return tf
    }()
    
    let registerBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Register", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        btn.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        btn.backgroundColor = #colorLiteral(red: 0.768972218, green: 0.1061631516, blue: 0.2892245948, alpha: 1)
        btn.layer.cornerRadius = 25
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn.setTitleColor(.lightGray, for: .disabled)
        btn.isEnabled = false
        return btn
    }()
    
    lazy var stackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
        nameTF,
        emailTF,
        passwordTF,
        registerBtn
        ])
        sv.spacing = 8
        sv.axis = .vertical
        sv.distribution = .fillEqually
        return sv
    }()
    
    lazy var overallStackView = UIStackView(arrangedSubviews: [
        selectPhotoButton,
        stackView
        ])
    
    let registrationViewModel = RegistrationViewModel()
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if self.traitCollection.verticalSizeClass == .compact {
            overallStackView.axis = .horizontal
        } else {
            overallStackView.axis = .vertical
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupGradient()
        setupLayout()
        setupNotificationObserver()
        setupRegisrationViewModel()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss))
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        NotificationCenter.default.removeObserver(self)
    }
    
    fileprivate func setupRegisrationViewModel() {
        registrationViewModel.isValidFormObserver = { [unowned self] (isValidForm) in
            if isValidForm {
                self.registerBtn.setTitleColor(.white, for: .normal)
                self.registerBtn.isEnabled = true
            } else {
                self.registerBtn.setTitleColor(.lightGray, for: .disabled)
                self.registerBtn.isEnabled = false
            }
            
        }
    }
    
    @objc fileprivate func handleTextChange(textField: UITextField) {
        if textField == nameTF {
            registrationViewModel.name = textField.text
        } else if textField == emailTF {
            registrationViewModel.email = textField.text
        } else {
            registrationViewModel.password = textField.text
        }
    }
    
    @objc func handleTapDismiss() {
        view.endEditing(true)
    }
    
    @objc func handleHideKeyboard() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            self.view.transform = .identity
        })
    }
    
    fileprivate func setupNotificationObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleHideKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func handleKeyboardShow(notification: Notification) {
        guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = value.cgRectValue
        let bottomSpace = view.frame.height - overallStackView.frame.origin.y - overallStackView.frame.height
        
        let difference = keyboardFrame.height - bottomSpace
        self.view.transform = CGAffineTransform(translationX: 0, y: -difference - 8)
    }
    
    fileprivate func setupLayout() {
        
        overallStackView.axis = .vertical
        overallStackView.spacing = 12
        selectPhotoButton.widthAnchor.constraint(equalToConstant: 275).isActive = true
        view.addSubview(overallStackView)
        overallStackView.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 50, bottom: 0, right: 50))
        overallStackView.centerYAnchor.constraint(equalToSystemSpacingBelow: view.centerYAnchor, multiplier: 1).isActive = true
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        gradinetLayer.frame = view.bounds
    }
    
    fileprivate func setupGradient() {
        
        let topColor = #colorLiteral(red: 0.9614489675, green: 0.3336345553, blue: 0.318431735, alpha: 1).cgColor
        let bottomColor = #colorLiteral(red: 0.8510704637, green: 0.1149692014, blue: 0.4193041325, alpha: 1).cgColor
        gradinetLayer.colors = [topColor, bottomColor]
        gradinetLayer.locations = [0, 1]
        view.layer.addSublayer(gradinetLayer)
        gradinetLayer.frame = view.bounds
    }
    
    @objc func handleRegister() {
        print("handle register")
    }

}
