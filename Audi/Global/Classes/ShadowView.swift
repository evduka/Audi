//
//  ShadowView.swift
//  Audi
//
//  Created by EVGENII DUKA on 18.04.2021.
//

import UIKit

class ShadowView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        dropShadow()
        print(#function)
    }
    
    convenience init() {
        self.init(frame: .zero)
        dropShadow()
        print(#function)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        dropShadow()
        print(#function)
    }
    
    private func dropShadow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
    
}
