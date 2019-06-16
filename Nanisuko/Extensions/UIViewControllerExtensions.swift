//
//  UIViewControllerExtensions.swift
//  Nanisuko
//
//  Created by 福田走 on 2019/06/15.
//  Copyright © 2019 福田走. All rights reserved.
//

import UIKit

internal extension UIViewController {
    internal func showToast(_ text: String, duration: TimeInterval = 3.0) {
        DispatchQueue.main.async {
            guard let view = self.view.window else { return }

            self.toast?.removeFromSuperview()
            
            let label = UILabel()
            label.accessibilityIdentifier = "toast"
            label.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            label.textColor = UIColor.white
            label.textAlignment = .center;
            label.font = UIFont(name: "Montserrat-Light", size: 12.0)
            label.text = text
            label.alpha = 1.0
            label.layer.cornerRadius = 17.5;
            label.clipsToBounds  =  true
            label.numberOfLines = 0
            
            view.addSubview(label)
            self.reposition(label)
            
            UIView.animate(withDuration: 1.0, delay: duration, options: .curveEaseOut, animations: {
                label.alpha = 0.0
            }, completion: { _ in
                label.removeFromSuperview()
            })
            
            NotificationCenter.default.addObserver(self, selector: #selector(self.reposition(notification:)), name: UIDevice.orientationDidChangeNotification, object: nil)

        }
    }
    
    @objc private func reposition(notification: Notification) {
        reposition(toast)
    }
    
    private func reposition(_ label: UILabel?) {
        guard let label = label,
            let view = label.superview else { return }
        
        let width = label.size.width + 20
        let height = label.size.height + 15
        label.frame = CGRect(x: view.frame.size.width / 2 - (width / 2), y: view.frame.size.height - (height + 70), width: width, height: height)
    }
    
    private var toast: UILabel? {
        return self.view.window?.subviews.first(where: { $0.accessibilityIdentifier == "toast" }) as? UILabel
    }
}
