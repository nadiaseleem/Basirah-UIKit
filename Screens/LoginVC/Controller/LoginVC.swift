//
//  LoginVC.swift
//  Basirah
//
//  Created by Nadia seleem on 4/16/21.
//  Copyright © 2021 Nadia seleem. All rights reserved.
//

import UIKit
import Firebase
class LoginVC: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var msgIndicatorLabel: UILabel!

    
    var ref: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerKeyboardNotifications()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        

    }

    @IBAction func createAccountButtonDidTouched(_ sender: UIButton)
    {
        route(to: .registerUser)
    }
    
    @IBAction func loginButtonDidTouched(_ sender: UIButton)
    {
        login()
    }
    
    
    @IBAction func forgetPasswordButtonDidTouched(_ sender: UIButton)
    {
        route(to: .forgetPassword)
    }
    
    
    func login()
    {
        guard let email = emailTextField.text,let password = passwordTextField.text else {
            return
        }
        validateInputs(email: email, password: password)
        {
            (isValid, msg) in
            
            if isValid
            {
                login(email: email, password: password, successHandler:
                    {
                        self.route(to: .dashboard)
                }, failureHandler:
                    {
                        msg in
                        self.showMSG(with: msg)
                })
            }
            else
            {
                showMSG(with: msg)
            }
        }
    }
    
}
