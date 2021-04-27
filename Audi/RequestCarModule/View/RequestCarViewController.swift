//
//  RequestCarViewController.swift
//  Audi
//
//  Created by EVGENII DUKA on 25.04.2021.
//

import UIKit

fileprivate let SETTINGS_VIEW_HEIGHT: CGFloat = 380

class RequestCarViewController: UIViewController {
    
    @IBOutlet weak var pricesCollectionView: UICollectionView!
    @IBOutlet weak var paymentsCollectionView: UICollectionView!
    @IBOutlet weak var backgroundColoredView: UIView!
    
    @IBOutlet weak var settingsViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var settingsViewHeightConstraint: NSLayoutConstraint!
    
    var presenter: iRequestCarPresenter?
    var delegate: iRequestCarViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let delegate = delegate { delegate.viewDidLoad() }
        if let presenter = presenter { presenter.setCollectionViews([pricesCollectionView, paymentsCollectionView]) }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        prepareToShowYourselfAnimated()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showViewAnimated()
    }
    
}

//MARK: - iRequestCarView
extension RequestCarViewController: iRequestCarView {
    
    func showViewAnimated() {
        UIView.animate(withDuration: 0.6) { [weak self] in
            self?.backgroundColoredView.alpha = 0.3;
            self?.view.layoutIfNeeded() }
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.settingsViewBottomConstraint.constant = 0;
            self?.view.layoutIfNeeded()
        }
    }
    
    func hideViewAnimated(completion: (() -> Void)?) {
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.settingsViewBottomConstraint.constant = -SETTINGS_VIEW_HEIGHT
            self?.view.layoutIfNeeded()
        }
        UIView.animate(withDuration: 0.6) { [weak self] in
            self?.backgroundColoredView.alpha = 0.0;
            self?.view.layoutIfNeeded()
        } completion: { _ in
            completion?()
        }
    }
    
    func dismissFromParent() {
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
    
}

//MARK: - UICollectionViewDelegate
extension RequestCarViewController: UICollectionViewDelegate {
    
    
    
}


//MARK: - Actions
extension RequestCarViewController {
    
    @IBAction func backgroundColoredViewTapAction(_ sender: Any) {
        if let delegate = delegate { delegate.backgroundColoredViewDidTap() }
    }
    
}

//MARK: - Helpers
extension RequestCarViewController {
    
    private func prepareToShowYourselfAnimated() {
        backgroundColoredView.alpha = 0.0
        settingsViewBottomConstraint.constant = -SETTINGS_VIEW_HEIGHT
        settingsViewHeightConstraint.constant = SETTINGS_VIEW_HEIGHT
    }
    
}
