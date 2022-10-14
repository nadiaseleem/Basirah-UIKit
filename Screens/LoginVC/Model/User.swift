//
//  User.swift
//  Basirah
//
//  Created by Nadia seleem on 4/16/21.
//  Copyright © 2021 Nadia seleem. All rights reserved.
//

import Foundation
import RealmSwift

struct UserType
{
    static let volunteer = "volunteer"
    static let requester = "requester"
}

class User: Object
{
    @objc dynamic var name: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var password: String = ""
    @objc dynamic var type: String = ""
}





func isRegisteredEmail(email: String) -> Bool
{
    guard let realm = AppDelegate.realm else { return false }
    return realm.objects(User.self).filter("email == %@",email).first != nil
}

func currentUser() -> User?
{
    guard let realm = AppDelegate.realm else { return nil }
    return realm.objects(User.self).filter("email == %@",Defaults.getValue(of: DefaultsKeys.loggedUser.rawValue) ?? "").first
}

/*

class Request: Object
{
    @objc dynamic var category: String = ""
    @objc dynamic var finalDate: Date = Date()
    @objc dynamic var bookName: String = ""
    @objc dynamic var response: Response = Response()
}

class Response: Object
{
    @objc dynamic var audioFileURL: String = ""
    @objc dynamic var user: User = User()
}*/
