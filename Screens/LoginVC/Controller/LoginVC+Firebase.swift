//
//  LoginVC+Firebase.swift
//  Basirah
//
//  Created by Nadia seleem on 4/16/21.
//  Copyright © 2021 Nadia seleem. All rights reserved.
//

import Foundation
import Firebase
import RealmSwift

extension LoginVC
{
    
    func login(email: String,password: String,successHandler: @escaping ()->(),failureHandler: @escaping (_ msg: String)->())
    {
        
        Auth.auth().signIn(withEmail: email, password: password)
        {
            (user, error) in
                        
            guard let user = user, error == nil else
            {
                failureHandler("تعذر تسجيل الدخول تأكد من البريد الالكتروني وكلمة المرور ثم حاول مرة اخري")
                return
            }
            
           
            //=================================
            
            self.ref = Database.database().reference()
            
            self.ref.child("users").child(user.uid).observeSingleEvent(of: .value)
                {
                    
                    (snapshot, str) in
                    guard let userDict = snapshot.value as? [String:String] else
                    {
                        failureHandler("تعذر تسجيل الدخول")
                        return
                    }
                    
                    let type = userDict["type"] ?? ""
                    let name = userDict["name"] ?? ""
                    //================================
                    
                    guard let realm = AppDelegate.realm else
                    {
                        failureHandler("تعذر تسجيل الدخول")
                        return
                    }
                    
                    
                    let realmUser = User()
                    realmUser.email = email
                    realmUser.password = password
                    realmUser.type = type
                    realmUser.name = name
                    
                    do
                    {
                        if !isRegisteredEmail(email: email)
                        {
                            try realm.write
                            {
                                realm.add(realmUser)
                            }
                        }
                        Defaults.set(key: DefaultsKeys.loggedUser.rawValue, for: realmUser.email)
                        successHandler()
                    }
                    catch
                    {
                        failureHandler("تعذر تسجيل الدخول")
                    }
                    
            }
            
                    
                }
            
            
            
            
    }
            
            
    
    
    
}
