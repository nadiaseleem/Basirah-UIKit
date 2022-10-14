//
//  LoginVC+TextField.swift
//  Basirah
//
//  Created by Nadia Seleem on 4/21/21.
//  Copyright © 2021 Nadia seleem. All rights reserved.
//

import Foundation
import UIKit
extension LoginVC: UITextFieldDelegate
{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        login()
        return true
        
    }
    
    
}
