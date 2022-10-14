//
//  LoginVC+Validator.swift
//  Basirah
//
//  Created by Nadia Seleem on 4/19/21.
//  Copyright © 2021 Nadia seleem. All rights reserved.
//

import Foundation
extension LoginVC
{
    
    func validateInputs(email:String,password:String,completion:(_ valid: Bool,_ msg: String)->())
    {
        
        guard !email.isEmpty,!password.isEmpty else
        {
            completion(false, "املأ الخانات الفارغة")
            return
        }
        
        guard isValidEmail(email: email) else
        {
            completion(false, "ادخل البريد الالكتروني بشكل صحيح")
            return
        }
        
       
        
        completion(true, "")
    }
    
    
    func isValidEmail(email: String)->Bool
    {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    
}
