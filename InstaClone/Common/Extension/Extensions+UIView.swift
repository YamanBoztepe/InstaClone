//
//  Extensions+UIView.swift
//  InstaClone
//
//  Created by Yaman Boztepe on 28.06.2021.
//

import UIKit

extension UIView {
    
    // MARK: - Keyboard Actions
    func keyboardShowObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardFrameChanged(_:)),
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil)
    }
    
    @objc private func keyboardFrameChanged(_ notification: Notification) {
        let time = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
        
        let startFrame = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let endFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        let distanceY = endFrame.origin.y - startFrame.origin.y
        
        Self.animateKeyframes(withDuration: time, delay: 0.0, options: .init(rawValue: curve)) { [weak self] in
            guard let self = self else { return }
            self.frame.origin.y += distanceY/2
        }
    }
}
