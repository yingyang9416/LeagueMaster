//
//  LoadingSpinner.swift
//  LeagueMaster
//
//  Created by Ying Yang on 3/28/19.
//  Copyright © 2019 Ying Yang. All rights reserved.
//

import UIKit
import Foundation

class LoadingSpinner {
    
    private let loadingIndicatorView: UIView
    private var spinnerView: UIImageView?
    ///the frame for loadingIndicatorView and spinnerView
    private let frame: CGRect
    ///a clear view to block user interaction
    private var blockView: UIView?
    var appeared: Bool = false
    
    /// init with the default image size, 40.0
    convenience init() {
        let size = CGSize(width: 30.0, height: 30.0)
        self.init(with: size)
    }
    
    /// init with a sepcific image size
    init(with size: CGSize) {
        frame = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        loadingIndicatorView = UIView(frame: frame)
        setupView()
    }
    
    private func setupView() {
        spinnerView = UIImageView(frame: loadingIndicatorView.bounds)
        spinnerView?.contentMode = .scaleAspectFill
        spinnerView?.image = UIImage(named: "spinner")
        spinnerView?.clipsToBounds = true
        
        if let view = spinnerView {
            loadingIndicatorView.addSubview(view)
        }
    }
    
    /// Show the loading indicator in a target UIViewController
    /// - Parameters:
    ///     - view: the target UIViewController to show the indicator,
    ///     - disableUserInteraction: disable user interaction in target view, default value is true.
    func show(in viewController: UIViewController, disableUserInteraction: Bool? = true) {
        show(in: viewController.view, disableUserInteraction: disableUserInteraction)
    }
    
    /// Show the loading indicator in a target UIView
    /// - Parameters:
    ///     - view: the target UIView to show the indicator,
    ///     - disableUserInteraction: disable user interaction in target view, default value is true.
    func show(in view: UIView, disableUserInteraction: Bool? = true) {
        
        if appeared {
            return
        } else {
            appeared = true
        }
        
        if let disabled = disableUserInteraction, disabled {
            let blockView = UIView(frame: view.bounds)
            blockView.backgroundColor = UIColor.init(white: 1, alpha: 0.5)
            self.blockView = blockView
            view.addSubview(blockView)
        }
        
        view.addSubview(loadingIndicatorView)
        loadingIndicatorView.isHidden = false
        setupConstraints()
        animation()
    }
    
    /// Dissmiss the indicator
    func dismiss() {
        
        if appeared {
            appeared = false
        } else {
            return
        }
        
        blockView?.removeFromSuperview()
        spinnerView?.layer.removeAllAnimations()
        loadingIndicatorView.isHidden = true
        loadingIndicatorView.removeFromSuperview()
        
    }
    
    private func setupConstraints() {
        guard let superview = loadingIndicatorView.superview else { return }
        loadingIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        [
            loadingIndicatorView.widthAnchor.constraint(equalToConstant: frame.size.width),
            loadingIndicatorView.heightAnchor.constraint(equalToConstant: frame.size.height),
            loadingIndicatorView.centerXAnchor.constraint(equalTo: superview.centerXAnchor),
            loadingIndicatorView.centerYAnchor.constraint(equalTo: superview.centerYAnchor)
            ].forEach{ $0.isActive = true }
        loadingIndicatorView.setNeedsLayout()
        loadingIndicatorView.layoutIfNeeded()
        
    }
    
    private func animation() {
        guard let view = spinnerView else { return }
        rotateAnimation(imageView: view)
    }
    
    private func rotateAnimation(imageView: UIImageView, duration: CFTimeInterval = 5.0) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(.pi * 10.0)
        rotateAnimation.duration = duration
        rotateAnimation.repeatCount = Float.greatestFiniteMagnitude;
        
        imageView.layer.add(rotateAnimation, forKey: nil)
    }
}
