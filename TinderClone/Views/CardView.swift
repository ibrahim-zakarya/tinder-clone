//
//  CardView.swift
//  TinderClone
//
//  Created by Ibrahim  Zakarya  on 8/3/19.
//  Copyright © 2019 Ibrahim  Zakarya . All rights reserved.
//

import UIKit

class CardView: UIView {
    
    var cardViewModel: CardViewModel! {
        didSet {
            let imageName = cardViewModel.imageNames.first ?? ""
            imageView.image = UIImage(named: imageName)
            informationLbl.attributedText = cardViewModel.attributedString
            informationLbl.textAlignment = cardViewModel.textAlignment
            
            (0..<cardViewModel.imageNames.count).forEach { (_) in
                let v = UIView()
                v.backgroundColor = barDeselectColor
                barsStackView.addArrangedSubview(v)
            }
            barsStackView.subviews.first?.backgroundColor = .white
            
            cardViewModel.imageIndexObserver = { [weak self] (idx, image) in
                self?.imageView.image = image
                self?.barsStackView.subviews.forEach { (v) in
                    v.backgroundColor = self?.barDeselectColor
                }
                self?.barsStackView.subviews[idx].backgroundColor = .white
            }
        }
        
        
    }
    
    fileprivate let imageView = UIImageView(image: #imageLiteral(resourceName: "lady5c"))
    fileprivate let gradientLayer = CAGradientLayer()
    fileprivate let barsStackView = UIStackView()
    fileprivate let informationLbl = UILabel()
    
    fileprivate let threshold: CGFloat = 100
    fileprivate let barDeselectColor = UIColor(white: 0, alpha: 0.1)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    fileprivate func setupLayout() {
        layer.cornerRadius = 10
        clipsToBounds = true
        
        imageView.contentMode = .scaleAspectFill
        addSubview(imageView)
        imageView.fillSuperview()
        
        setupGradient()
        setupBarsStackView()
        informationLbl.textColor = .white
        informationLbl.numberOfLines = 0
        addSubview(informationLbl)
        informationLbl.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 20, bottom: 20, right: 20), size: .zero)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        addGestureRecognizer(panGesture)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapGesture)
    }
    
    fileprivate func setupBarsStackView() {
        addSubview(barsStackView)
        barsStackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 8, left: 8, bottom: 0, right: 8), size: .init(width: 0, height: 4))
        barsStackView.distribution = .fillEqually
        barsStackView.spacing = 4
        
        
    }
    
    fileprivate func setupGradient() {
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.6, 1.2]
        layer.addSublayer(gradientLayer)
    }
    
    override func layoutSubviews() {
        gradientLayer.frame = self.frame
    }
    
    var imageIndex = 0
    
    @objc fileprivate func handleTap(gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: nil)
        let shouldMoveNextPhoto = location.x > frame.width / 2 ? true : false
        if shouldMoveNextPhoto {
            cardViewModel.advanceToNextPhto()
        } else {
            cardViewModel.goToPreviousPhoto()
        }
        
    }
    
    @objc fileprivate func handlePan(gesture: UIPanGestureRecognizer) {
        
        switch gesture.state {
        case .began:
            superview?.subviews.forEach({ (subview) in
                subview.layer.removeAllAnimations()
            })
        case .changed:
            handleChanged(gesture)
        case .ended:
            handleEnded(gesture)
        default:
            ()
        }
        
    }
    
    func handleChanged(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: nil)
        let degree: CGFloat = translation.x / 15
        let angle = degree * .pi / 180
        let rotationalTransformatioin = CGAffineTransform(rotationAngle: angle)
        self.transform = rotationalTransformatioin.translatedBy(x: translation.x, y: translation.y)
    }
    
    fileprivate func handleEnded(_ gesture: UIPanGestureRecognizer) {
        let translationDirection: CGFloat = gesture.translation(in: nil).x > 0 ? 1 : -1
        let shouldDismissCard = abs(gesture.translation(in: nil).x) > threshold
        
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            if shouldDismissCard {
//                let offScreetTransform = self.transform.translatedBy(x: 1000, y: 0)
//                self.transform = offScreetTransform
                self.frame = CGRect(x: 1000 * translationDirection, y: 0, width: self.frame.width, height: self.frame.width)
            } else {
                self.transform = .identity
            }
            
        }) { (_) in
            self.transform = .identity
            if shouldDismissCard {
                self.removeFromSuperview()
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
