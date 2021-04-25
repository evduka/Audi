//
//  UIViewController.swift
//  Audi
//
//  Created by EVGENII DUKA on 10.04.2021.
//

import UIKit

extension UIViewController {
    
    class func initFromStoryboardWithTheSameName() -> Self {
        let name = String(describing: self)
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: name) as! Self
        return viewController
    }
    
}


