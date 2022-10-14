//
//  LoginVC+MSG.swift
//  Basirah
//
//  Created by Nadia Seleem on 4/19/21.
//  Copyright © 2021 Nadia seleem. All rights reserved.
//

import Foundation

extension LoginVC
{
    
    
    func showMSG(with msg: String)
    {
        self.msgIndicatorLabel.text = msg
        self.msgIndicatorLabel.isHidden = false
        
    }
    
    func hideMSG()
    {
        self.msgIndicatorLabel.isHidden = true
    }
    
}

