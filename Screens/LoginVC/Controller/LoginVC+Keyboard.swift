//
//  LoginVC+Keyboard.swift
//  Basirah
//
//  Created by Nadia seleem on 4/16/21.
//  Copyright © 2021 Nadia seleem. All rights reserved.
//

import Foundation
import UIKit

extension LoginVC:UIScrollViewDelegate
{
    
    func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        hideKeyboard()
    }
    
    
    func registerKeyboardNotifications(){
        scrollView.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(notification:)), name: Notification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(notification:)), name: Notification.Name.UIKeyboardWillHide, object: nil)
    }
    
    
    
    //MARK:- Keyboard scrolling handling
    @objc func keyboardDidShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
            scrollView.contentInset = contentInsets
            scrollView.scrollIndicatorInsets = contentInsets
            var aRect = scrollView.superview!.frame
            aRect.size.height -= keyboardSize.size.height
        }
    }
    
    @objc func keyboardWillBeHidden(notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }

    
}
